import 'package:perfect_pitch/core/music/music_interval.dart';

/// A context in which an interval can be practiced. These map directly to the
/// columns of the mastery matrix on the progress screen.
enum TrainingMode {
  ascending(labelFr: 'Ascendant'),
  descending(labelFr: 'Descendant'),
  harmonic(labelFr: 'Harmonique'),
  guitar(labelFr: 'Guitare');

  const TrainingMode({required this.labelFr});

  final String labelFr;
}

/// A single graded answer, fed to the repository to update mastery.
class IntervalAttempt {
  const IntervalAttempt({
    required this.interval,
    required this.mode,
    required this.correct,
  });

  final MusicInterval interval;
  final TrainingMode mode;
  final bool correct;
}

/// Correct-over-total tally for one interval in one mode.
class MasteryScore {
  const MasteryScore({required this.correct, required this.total});

  const MasteryScore.empty() : correct = 0, total = 0;

  final int correct;
  final int total;

  double get successRate {
    if (total == 0) {
      return 0;
    }

    return correct / total;
  }

  int get percentage {
    return (successRate * 100).round();
  }

  MasteryScore add({required bool correct}) {
    return MasteryScore(
      correct: this.correct + (correct ? 1 : 0),
      total: total + 1,
    );
  }
}

/// Mastery of a single interval across every training mode.
class IntervalProgress {
  const IntervalProgress({required this.interval, required this.scores});

  factory IntervalProgress.empty(MusicInterval interval) {
    return IntervalProgress(
      interval: interval,
      scores: {
        for (final mode in TrainingMode.values) mode: const MasteryScore.empty(),
      },
    );
  }

  final MusicInterval interval;
  final Map<TrainingMode, MasteryScore> scores;

  MasteryScore scoreFor(TrainingMode mode) {
    return scores[mode] ?? const MasteryScore.empty();
  }

  int get totalAttempts {
    return scores.values.fold(0, (total, score) => total + score.total);
  }

  double get overallSuccessRate {
    final correct = scores.values.fold(0, (sum, score) => sum + score.correct);

    if (totalAttempts == 0) {
      return 0;
    }

    return correct / totalAttempts;
  }

  int get averagePercentage {
    return (overallSuccessRate * 100).round();
  }

  bool get isMastered {
    return totalAttempts >= 4 && overallSuccessRate >= 0.9;
  }
}

/// Immutable view of all locally stored progress.
class ProgressSnapshot {
  const ProgressSnapshot({
    required this.streakDays,
    required this.completedSessions,
    required this.intervals,
  });

  factory ProgressSnapshot.empty() {
    return const ProgressSnapshot(
      streakDays: 0,
      completedSessions: 0,
      intervals: {},
    );
  }

  final int streakDays;
  final int completedSessions;
  final Map<MusicInterval, IntervalProgress> intervals;

  List<IntervalProgress> get attemptedIntervals {
    return intervals.values.where((entry) => entry.totalAttempts > 0).toList()
      ..sort((a, b) => a.interval.semitones.compareTo(b.interval.semitones));
  }

  int get attemptedIntervalCount {
    return attemptedIntervals.length;
  }

  int get masteredIntervalCount {
    return intervals.values.where((entry) => entry.isMastered).length;
  }
}
