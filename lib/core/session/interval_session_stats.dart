import 'package:perfect_pitch/core/session/interval_outcome.dart';

/// Aggregate performance for a single completed practice session.
class IntervalSessionStats {
  const IntervalSessionStats({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.successRate,
    required this.averageResponseTime,
    required this.bestStreak,
  });

  factory IntervalSessionStats.fromOutcomes(List<IntervalOutcome> outcomes) {
    if (outcomes.isEmpty) {
      return const IntervalSessionStats(
        totalQuestions: 0,
        correctAnswers: 0,
        successRate: 0,
        averageResponseTime: Duration.zero,
        bestStreak: 0,
      );
    }

    final correctAnswers = outcomes
        .where((outcome) => outcome.isCorrect)
        .length;
    final totalResponseMillis = outcomes.fold<int>(
      0,
      (total, outcome) => total + outcome.responseTime.inMilliseconds,
    );

    return IntervalSessionStats(
      totalQuestions: outcomes.length,
      correctAnswers: correctAnswers,
      successRate: correctAnswers / outcomes.length,
      averageResponseTime: Duration(
        milliseconds: totalResponseMillis ~/ outcomes.length,
      ),
      bestStreak: _bestStreak(outcomes),
    );
  }

  final int totalQuestions;
  final int correctAnswers;
  final double successRate;
  final Duration averageResponseTime;
  final int bestStreak;

  static int _bestStreak(List<IntervalOutcome> outcomes) {
    var currentStreak = 0;
    var bestStreak = 0;

    for (final outcome in outcomes) {
      if (!outcome.isCorrect) {
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
}
