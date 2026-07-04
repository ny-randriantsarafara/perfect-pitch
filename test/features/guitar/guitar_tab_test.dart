import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/features/guitar/guitar_controller.dart';
import 'package:perfect_pitch/features/guitar/guitar_tab.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

GuitarController _controller() {
  return GuitarController(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    onAttemptRecorded: ({required interval, required correct}) {},
  );
}

Widget _host({required GuitarController controller, required LayoutMode mode}) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      backgroundColor: AppPalette.canvas,
      body: GuitarTab(controller: controller, mode: mode),
    ),
  );
}

void _setSurface(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('mobile guitar tab has no bottom overflow at screenshot size', (
    tester,
  ) async {
    _setSurface(tester, const Size(400, 770));

    await tester.pumpWidget(
      _host(controller: _controller(), mode: LayoutMode.mobile),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop guitar tab has no bottom overflow at screenshot size', (
    tester,
  ) async {
    _setSurface(tester, const Size(957, 857));

    await tester.pumpWidget(
      _host(controller: _controller(), mode: LayoutMode.desktop),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('English guitar prompt uses English interval labels', (
    tester,
  ) async {
    _setSurface(tester, const Size(400, 770));

    await tester.pumpWidget(
      _host(controller: _controller(), mode: LayoutMode.mobile),
    );
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Perfect Fifth'),
      ),
      findsOneWidget,
    );
    expect(find.text('Quinte Juste'), findsNothing);
  });
}
