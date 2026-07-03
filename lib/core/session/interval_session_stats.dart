import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';

/// Aggregate performance for a single completed session, derived from its
/// [ExerciseAttempt]s and shown on the summary screen.
class IntervalSessionStats {
  const IntervalSessionStats({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.skippedQuestions,
    required this.successRate,
    required this.averageResponseTime,
    required this.manualReplays,
    required this.bestStreak,
    required this.hardestInterval,
    required this.mostCommonConfusion,
  });

  factory IntervalSessionStats.fromAttempts(List<ExerciseAttempt> attempts) {
    if (attempts.isEmpty) {
      return const IntervalSessionStats(
        totalQuestions: 0,
        correctAnswers: 0,
        skippedQuestions: 0,
        successRate: 0,
        averageResponseTime: Duration.zero,
        manualReplays: 0,
        bestStreak: 0,
        hardestInterval: null,
        mostCommonConfusion: null,
      );
    }

    final correctAnswers = attempts.where((attempt) => attempt.correct).length;
    final skippedQuestions = attempts.where((attempt) => attempt.skipped).length;
    final totalResponseMillis = attempts.fold<int>(
      0,
      (total, attempt) => total + attempt.responseTime.inMilliseconds,
    );
    final manualReplays = attempts.fold<int>(
      0,
      (total, attempt) => total + attempt.replayCount,
    );

    return IntervalSessionStats(
      totalQuestions: attempts.length,
      correctAnswers: correctAnswers,
      skippedQuestions: skippedQuestions,
      successRate: correctAnswers / attempts.length,
      averageResponseTime: Duration(
        milliseconds: totalResponseMillis ~/ attempts.length,
      ),
      manualReplays: manualReplays,
      bestStreak: _bestStreak(attempts),
      hardestInterval: _hardestInterval(attempts),
      mostCommonConfusion: _mostCommonConfusion(attempts),
    );
  }

  final int totalQuestions;
  final int correctAnswers;
  final int skippedQuestions;
  final double successRate;
  final Duration averageResponseTime;
  final int manualReplays;
  final int bestStreak;
  final MusicInterval? hardestInterval;
  final IntervalConfusion? mostCommonConfusion;

  int get accuracyPercentage {
    return (successRate * 100).round();
  }

  static int _bestStreak(List<ExerciseAttempt> attempts) {
    var currentStreak = 0;
    var bestStreak = 0;

    for (final attempt in attempts) {
      if (!attempt.correct) {
        currentStreak = 0;
        continue;
      }

      currentStreak += 1;

      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
      }
    }

    return bestStreak;
  }

  static MusicInterval? _hardestInterval(List<ExerciseAttempt> attempts) {
    final totals = <MusicInterval, ({int total, int missed})>{};

    for (final attempt in attempts) {
      final current = totals[attempt.expected] ?? (total: 0, missed: 0);
      totals[attempt.expected] = (
        total: current.total + 1,
        missed: current.missed + (attempt.correct ? 0 : 1),
      );
    }

    MusicInterval? hardest;
    var worstMissRate = -1.0;

    totals.forEach((interval, tally) {
      if (tally.missed == 0) {
        return;
      }

      final missRate = tally.missed / tally.total;

      if (missRate > worstMissRate) {
        worstMissRate = missRate;
        hardest = interval;
      }
    });

    return hardest;
  }

  static IntervalConfusion? _mostCommonConfusion(
    List<ExerciseAttempt> attempts,
  ) {
    final counts = <(MusicInterval, MusicInterval), int>{};

    for (final attempt in attempts) {
      final selected = attempt.selected;

      if (selected == null || attempt.correct) {
        continue;
      }

      final key = (attempt.expected, selected);
      counts[key] = (counts[key] ?? 0) + 1;
    }

    if (counts.isEmpty) {
      return null;
    }

    final best = counts.entries.reduce(
      (a, b) => b.value > a.value ? b : a,
    );

    return IntervalConfusion(
      expected: best.key.$1,
      selected: best.key.$2,
      count: best.value,
    );
  }
}
