import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_result.dart';
import 'package:perfect_pitch/core/storage/progress_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SharedPreferencesProgressRepository', () {
    test('loads default local progress when storage is empty', () async {
      SharedPreferences.setMockInitialValues({});
      final repository = SharedPreferencesProgressRepository();

      final snapshot = await repository.load();

      expect(snapshot.guidedPathStep, 1);
      expect(snapshot.completedSessions, 0);
      expect(snapshot.totalTrainingTime, Duration.zero);
      expect(snapshot.noteProgress, isEmpty);
    });

    test('persists guided path progress locally', () async {
      SharedPreferences.setMockInitialValues({});
      final repository = SharedPreferencesProgressRepository();

      await repository.saveGuidedPathStep(3);
      final snapshot = await repository.load();

      expect(snapshot.guidedPathStep, 3);
    });

    test('records session note statistics locally', () async {
      SharedPreferences.setMockInitialValues({});
      final repository = SharedPreferencesProgressRepository();
      final outcomes = [
        QuestionOutcome.correct(
          note: MusicNote.doNote,
          octave: 4,
          responseTime: const Duration(milliseconds: 1200),
          replayCount: 1,
        ),
        QuestionOutcome.incorrect(
          note: MusicNote.re,
          selectedNote: MusicNote.mi,
          octave: 4,
          responseTime: const Duration(milliseconds: 3200),
          replayCount: 2,
        ),
      ];

      await repository.recordSession(
        outcomes: outcomes,
        trainingTime: const Duration(minutes: 5),
      );
      final snapshot = await repository.load();

      expect(snapshot.completedSessions, 1);
      expect(snapshot.totalTrainingTime, const Duration(minutes: 5));
      expect(snapshot.noteProgress[MusicNote.doNote]?.playedCount, 1);
      expect(snapshot.noteProgress[MusicNote.doNote]?.successRate, 1);
      expect(snapshot.noteProgress[MusicNote.re]?.playedCount, 1);
      expect(snapshot.noteProgress[MusicNote.re]?.successRate, 0);
      expect(snapshot.noteProgress[MusicNote.re]?.mainConfusion, MusicNote.mi);
    });
  });
}
