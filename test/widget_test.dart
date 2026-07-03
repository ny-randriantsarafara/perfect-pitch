import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

PerfectPitchApp _buildApp() {
  return PerfectPitchApp(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    progressRepository: InMemoryIntervalProgressRepository(),
  );
}

void _setSurface(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('mobile home session card opens the exercises catalogue', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Hello!'), findsOneWidget);

    await tester.tap(find.text('Start (5 min)'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Intervalles ascendants'), findsOneWidget);
    expect(find.text('Intervalles mixtes'), findsOneWidget);
  });

  testWidgets('mobile bottom navigation switches tabs', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.music_note_rounded));
    await tester.pump();
    expect(find.text('Fretboard'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.auto_awesome_rounded));
    await tester.pump();
    expect(find.text('Détail par intervalle'), findsOneWidget);
  });

  testWidgets('desktop layout shows the side navigation rail', (tester) async {
    _setSurface(tester, const Size(1400, 900));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Intervals'), findsOneWidget);
    expect(find.text('Hello!'), findsOneWidget);
  });

  testWidgets('mobile home recommendation card opens an existing exercise setup', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(
      find.byKey(const ValueKey('home-exercise-recommendation-0')),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(const ValueKey('home-exercise-recommendation-0')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const ValueKey('practice-setup-start')), findsOneWidget);
    expect(find.text('SETTINGS'), findsOneWidget);
  });
}
