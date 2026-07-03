import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

ExerciseAttempt _exerciseAttempt({
  required MusicInterval expected,
  required MusicInterval? selected,
  ExerciseType type = ExerciseType.ascendingIntervals,
  IntervalDirection direction = IntervalDirection.ascending,
  int replayCount = 0,
  Duration responseTime = const Duration(milliseconds: 1200),
}) {
  return ExerciseAttempt(
    type: type,
    expected: expected,
    selected: selected,
    direction: direction,
    instrument: Instrument.piano,
    replayCount: replayCount,
    hesitated: false,
    responseTime: responseTime,
    occurredAt: DateTime(2026, 7, 3),
  );
}

void main() {
  group('nextStreak', () {
    test('starts at one with no prior session', () {
      final streak = nextStreak(
        currentStreak: 0,
        lastSessionDate: null,
        now: DateTime(2026, 7, 2),
      );

      expect(streak, 1);
    });

    test('increments on a consecutive day', () {
      final streak = nextStreak(
        currentStreak: 3,
        lastSessionDate: DateTime(2026, 7, 1),
        now: DateTime(2026, 7, 2),
      );

      expect(streak, 4);
    });

    test('is unchanged for a second session the same day', () {
      final streak = nextStreak(
        currentStreak: 3,
        lastSessionDate: DateTime(2026, 7, 2, 9),
        now: DateTime(2026, 7, 2, 20),
      );

      expect(streak, 3);
    });

    test('resets after a gap', () {
      final streak = nextStreak(
        currentStreak: 5,
        lastSessionDate: DateTime(2026, 6, 28),
        now: DateTime(2026, 7, 2),
      );

      expect(streak, 1);
    });
  });

  group('InMemoryIntervalProgressRepository', () {
    test('accumulates mastery per interval and mode', () async {
      final repository = InMemoryIntervalProgressRepository();

      final snapshot = await repository.recordAttempts([
        const IntervalAttempt(
          interval: MusicInterval.perfectFifth,
          mode: TrainingMode.ascending,
          correct: true,
        ),
        const IntervalAttempt(
          interval: MusicInterval.perfectFifth,
          mode: TrainingMode.ascending,
          correct: false,
        ),
      ], occurredAt: DateTime(2026, 7, 2));

      final fifth = snapshot.intervals[MusicInterval.perfectFifth]!;

      expect(fifth.scoreFor(TrainingMode.ascending).total, 2);
      expect(fifth.scoreFor(TrainingMode.ascending).percentage, 50);
      expect(snapshot.streakDays, 1);
      expect(snapshot.completedSessions, 1);
      expect(snapshot.attemptedIntervalCount, 1);
    });

    test('marks an interval mastered above 90 percent', () async {
      final repository = InMemoryIntervalProgressRepository();
      final attempts = List.generate(
        10,
        (index) => IntervalAttempt(
          interval: MusicInterval.octave,
          mode: TrainingMode.ascending,
          correct: index != 0,
        ),
      );

      final snapshot = await repository.recordAttempts(attempts);

      expect(snapshot.masteredIntervalCount, 1);
    });
  });

  group('recordExerciseAttempts', () {
    test('still updates aggregate correct and incorrect totals', () async {
      final repository = InMemoryIntervalProgressRepository();

      final snapshot = await repository.recordExerciseAttempts([
        _exerciseAttempt(
          expected: MusicInterval.perfectFifth,
          selected: MusicInterval.perfectFifth,
        ),
        _exerciseAttempt(
          expected: MusicInterval.perfectFifth,
          selected: MusicInterval.perfectFourth,
        ),
      ], occurredAt: DateTime(2026, 7, 3));

      final fifth = snapshot.intervals[MusicInterval.perfectFifth]!;

      expect(fifth.scoreFor(TrainingMode.ascending).total, 2);
      expect(fifth.scoreFor(TrainingMode.ascending).correct, 1);
      expect(snapshot.completedSessions, 1);
    });

    test('keeps direction-specific scores separate', () async {
      final repository = InMemoryIntervalProgressRepository();

      await repository.recordExerciseAttempts([
        _exerciseAttempt(
          expected: MusicInterval.perfectFifth,
          selected: MusicInterval.perfectFifth,
        ),
        _exerciseAttempt(
          expected: MusicInterval.perfectFifth,
          selected: MusicInterval.perfectFifth,
          direction: IntervalDirection.descending,
          type: ExerciseType.descendingIntervals,
        ),
      ]);

      final stats = await repository.loadExerciseStats();

      expect(stats.totalsForDirection(IntervalDirection.ascending).total, 1);
      expect(stats.totalsForDirection(IntervalDirection.descending).total, 1);
      expect(stats.byExerciseType[ExerciseType.descendingIntervals]!.total, 1);
    });

    test('counts a skip as incorrect and skipped', () async {
      final repository = InMemoryIntervalProgressRepository();

      final snapshot = await repository.recordExerciseAttempts([
        _exerciseAttempt(expected: MusicInterval.majorThird, selected: null),
      ]);

      final third = snapshot.intervals[MusicInterval.majorThird]!;
      final stats = await repository.loadExerciseStats();

      expect(third.scoreFor(TrainingMode.ascending).total, 1);
      expect(third.scoreFor(TrainingMode.ascending).correct, 0);
      expect(stats.byInterval[MusicInterval.majorThird]!.skipped, 1);
      expect(stats.skippedCount, 1);
    });

    test('records the expected to selected confusion', () async {
      final repository = InMemoryIntervalProgressRepository();

      await repository.recordExerciseAttempts([
        _exerciseAttempt(
          expected: MusicInterval.perfectFifth,
          selected: MusicInterval.perfectFourth,
        ),
        _exerciseAttempt(
          expected: MusicInterval.perfectFifth,
          selected: MusicInterval.perfectFourth,
        ),
      ]);

      final stats = await repository.loadExerciseStats();
      final confusion = stats.mostCommonConfusion;

      expect(confusion, isNotNull);
      expect(confusion!.expected, MusicInterval.perfectFifth);
      expect(confusion.selected, MusicInterval.perfectFourth);
      expect(confusion.count, 2);
    });

    test('averages replay usage and response time per interval', () async {
      final repository = InMemoryIntervalProgressRepository();

      await repository.recordExerciseAttempts([
        _exerciseAttempt(
          expected: MusicInterval.octave,
          selected: MusicInterval.octave,
          replayCount: 1,
          responseTime: const Duration(milliseconds: 1000),
        ),
        _exerciseAttempt(
          expected: MusicInterval.octave,
          selected: MusicInterval.octave,
          replayCount: 3,
          responseTime: const Duration(milliseconds: 3000),
        ),
      ]);

      final stats = await repository.loadExerciseStats();
      final octave = stats.byInterval[MusicInterval.octave]!;

      expect(octave.averageReplays, 2);
      expect(octave.averageResponseTime, const Duration(milliseconds: 2000));
    });
  });
}
