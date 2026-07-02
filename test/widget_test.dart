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
  testWidgets('mobile layout starts practice from the home session card', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Bonjour !'), findsOneWidget);

    await tester.tap(find.text('Démarrer (5 min)'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Quel est cet intervalle ?'), findsOneWidget);
  });

  testWidgets('mobile bottom navigation switches tabs', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.music_note_rounded));
    await tester.pump();
    expect(find.text('Le Manche'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.auto_awesome_rounded));
    await tester.pump();
    expect(find.text('Détail par intervalle'), findsOneWidget);
  });

  testWidgets('desktop layout shows the side navigation rail', (tester) async {
    _setSurface(tester, const Size(1400, 900));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Intervals'), findsOneWidget);
    expect(find.text('Bonjour !'), findsOneWidget);
  });
}
