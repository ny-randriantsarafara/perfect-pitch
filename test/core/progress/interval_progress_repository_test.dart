import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

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
}
