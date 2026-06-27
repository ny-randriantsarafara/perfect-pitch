import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';

void main() {
  testWidgets('home exposes the three main modes without authentication', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    expect(find.text('Perfect Pitch'), findsOneWidget);
    expect(find.byKey(const Key('learn-mode-action')), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('training-mode-action')));
    expect(find.byKey(const Key('training-mode-action')), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('guided-path-action')));
    expect(find.byKey(const Key('guided-path-action')), findsOneWidget);
    expect(find.text('Connexion'), findsNothing);
  });

  testWidgets('learn mode shows note names and replay action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.ensureVisible(find.byKey(const Key('learn-mode-action')));
    await tester.tap(find.byKey(const Key('learn-mode-action')));
    await tester.pump();

    expect(find.text('Do'), findsWidgets);
    expect(find.text('C'), findsOneWidget);
    expect(find.text('Écouter Do'), findsOneWidget);
    expect(find.text('Note suivante'), findsOneWidget);
  });

  testWidgets('training mode gives immediate result after an answer', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.ensureVisible(find.byKey(const Key('training-mode-action')));
    await tester.tap(find.byKey(const Key('training-mode-action')));
    await tester.pump();

    await tester.tap(find.text('Ré'));
    await tester.pump();

    expect(find.textContaining('Réponse'), findsOneWidget);
    expect(find.textContaining('Bonne note'), findsOneWidget);
    expect(find.textContaining('Votre choix'), findsOneWidget);
    expect(find.text('Comparer'), findsOneWidget);
  });
}

PerfectPitchApp _buildTestApp() {
  return const PerfectPitchApp(
    audioEngine: AudioEngine(player: SilentAudioPlayer()),
  );
}
