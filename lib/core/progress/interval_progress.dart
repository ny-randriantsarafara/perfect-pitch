import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
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

/// Rolling totals for a slice of attempts (one interval, one direction, or one
/// exercise type). Rich enough to derive success rate, replay usage, skip
/// count, and average response time.
class AttemptTotals {
  const AttemptTotals({
    this.total = 0,
    this.correct = 0,
    this.skipped = 0,
    this.replays = 0,
    this.responseMillis = 0,
  });

  final int total;
  final int correct;
  final int skipped;
  final int replays;
  final int responseMillis;

  double get successRate {
    if (total == 0) {
      return 0;
    }

    return correct / total;
  }

  int get percentage {
    return (successRate * 100).round();
  }

  double get averageReplays {
    if (total == 0) {
      return 0;
    }

    return replays / total;
  }

  Duration get averageResponseTime {
    if (total == 0) {
      return Duration.zero;
    }

    return Duration(milliseconds: responseMillis ~/ total);
  }

  AttemptTotals add({
    required bool correct,
    required bool skipped,
    required int replays,
    required int responseMillis,
  }) {
    return AttemptTotals(
      total: total + 1,
      correct: this.correct + (correct ? 1 : 0),
      skipped: this.skipped + (skipped ? 1 : 0),
      replays: this.replays + replays,
      responseMillis: this.responseMillis + responseMillis,
    );
  }
}

/// How often one interval was mistaken for another (expected vs. selected).
class IntervalConfusion {
  const IntervalConfusion({
    required this.expected,
    required this.selected,
    required this.count,
  });

  final MusicInterval expected;
  final MusicInterval selected;
  final int count;
}

/// The persisted breakdown of every recorded [attempt], sliced along the
/// dimensions the progress screen needs.
class ExerciseStatsSnapshot {
  const ExerciseStatsSnapshot({
    required this.byInterval,
    required this.byDirection,
    required this.byExerciseType,
    required this.confusions,
  });

  factory ExerciseStatsSnapshot.empty() {
    return const ExerciseStatsSnapshot(
      byInterval: {},
      byDirection: {},
      byExerciseType: {},
      confusions: [],
    );
  }

  final Map<MusicInterval, AttemptTotals> byInterval;
  final Map<IntervalDirection, AttemptTotals> byDirection;
  final Map<ExerciseType, AttemptTotals> byExerciseType;
  final List<IntervalConfusion> confusions;

  int get skippedCount {
    return byInterval.values.fold(0, (total, entry) => total + entry.skipped);
  }

  AttemptTotals totalsForDirection(IntervalDirection direction) {
    return byDirection[direction] ?? const AttemptTotals();
  }

  IntervalConfusion? get mostCommonConfusion {
    if (confusions.isEmpty) {
      return null;
    }

    return confusions.reduce(
      (best, candidate) => candidate.count > best.count ? candidate : best,
    );
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
