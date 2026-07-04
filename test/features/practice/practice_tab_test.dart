import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';
import 'package:perfect_pitch/features/practice/practice_tab.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

PracticeController _controller() {
  return PracticeController(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    onSessionCompleted: (_) {},
  );
}

Widget _host(
  PracticeController controller, {
  Locale locale = const Locale('fr'),
}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      backgroundColor: AppPalette.canvas,
      body: PracticeTab(
        controller: controller,
        progress: ProgressSnapshot.empty(),
        mode: LayoutMode.mobile,
      ),
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
  testWidgets('renders the four catalogue cards', (tester) async {
    _setSurface(tester, const Size(500, 1200));

    await tester.pumpWidget(_host(_controller()));
    await tester.pump();

    expect(find.text('Intervalles ascendants'), findsOneWidget);
    expect(find.text('Intervalles descendants'), findsOneWidget);
    expect(find.text('Intervalles harmoniques'), findsOneWidget);
    expect(find.text('Intervalles mixtes'), findsOneWidget);
  });

  testWidgets('starting a card opens the setup screen', (tester) async {
    _setSurface(tester, const Size(500, 1200));

    await tester.pumpWidget(_host(_controller()));
    await tester.pump();

    await tester.tap(find.text('Intervalles ascendants'));
    await tester.pump();

    expect(find.text('Démarrer la session'), findsOneWidget);
    expect(find.text('RÉGLAGES'), findsOneWidget);
  });

  testWidgets('English catalogue and setup contain no French exercise labels', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1200));

    await tester.pumpWidget(_host(_controller(), locale: const Locale('en')));
    await tester.pump();

    expect(find.text('Ascending intervals'), findsOneWidget);
    expect(find.text('Descending intervals'), findsOneWidget);
    expect(find.text('Harmonic intervals'), findsOneWidget);
    expect(find.text('Mixed intervals'), findsOneWidget);
    expect(find.text('Intervalles ascendants'), findsNothing);

    await tester.tap(find.text('Ascending intervals'));
    await tester.pump();

    expect(find.text('Start session'), findsOneWidget);
    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('Beginner'), findsOneWidget);
    expect(find.text('Démarrer la session'), findsNothing);
  });

  testWidgets('English active session uses English interval labels', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1200));
    final controller = _controller();

    await tester.pumpWidget(_host(controller, locale: const Locale('en')));
    await tester.pump();

    await tester.tap(find.text('Ascending intervals'));
    await tester.pump();

    controller.updateDraftConfig(
      controller.draftConfig!.copyWith(
        intervals: const [MusicInterval.perfectFifth, MusicInterval.octave],
        choiceCount: 2,
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Start session'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('What interval is this?'), findsOneWidget);
    expect(find.text('Perfect Fifth'), findsOneWidget);
    expect(find.text('Quinte Juste'), findsNothing);
  });

  testWidgets('starting the setup opens the active session', (tester) async {
    _setSurface(tester, const Size(500, 1200));

    await tester.pumpWidget(_host(_controller()));
    await tester.pump();

    await tester.tap(find.text('Intervalles ascendants'));
    await tester.pump();

    await tester.tap(find.text('Démarrer la session'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Quel est cet intervalle ?'), findsOneWidget);
  });

  testWidgets('mixed easy mode shows the direction badge before answering', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1200));

    final controller = _controller();

    await tester.pumpWidget(_host(controller));
    await tester.pump();

    await tester.tap(find.text('Intervalles mixtes'));
    await tester.pump();

    await tester.tap(find.text('Démarrer la session'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Quel est cet intervalle ?'), findsOneWidget);
    expect(find.byKey(const ValueKey('direction-badge')), findsOneWidget);
  });
}
