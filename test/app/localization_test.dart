import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

PerfectPitchApp _buildApp({Locale? locale}) {
  return PerfectPitchApp(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    progressRepository: InMemoryIntervalProgressRepository(),
    locale: locale,
  );
}

void _setSurface(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('uses English by default', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Hello!'), findsOneWidget);
    expect(find.text('Your repertoire'), findsOneWidget);
  });

  testWidgets('renders the home screen in French', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp(locale: const Locale('fr')));
    await tester.pump();

    expect(find.text('Bonjour !'), findsOneWidget);
    expect(find.text('Ton répertoire'), findsOneWidget);
  });

  testWidgets('renders the home screen in Spanish', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp(locale: const Locale('es')));
    await tester.pump();

    expect(find.text('¡Hola!'), findsOneWidget);
    expect(find.text('Tu repertorio'), findsOneWidget);
  });

  testWidgets('language picker switches the app language', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Hello!'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('language-picker')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    await tester.tap(find.text('Français').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Bonjour !'), findsOneWidget);
  });
}
