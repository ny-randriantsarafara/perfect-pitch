import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local, offline-first store for interval mastery and the daily streak.
abstract class IntervalProgressRepository {
  Future<ProgressSnapshot> load();

  Future<ProgressSnapshot> recordAttempts(
    List<IntervalAttempt> attempts, {
    DateTime? occurredAt,
  });

  /// Records full [ExerciseAttempt]s: it updates the aggregate mastery used by
  /// the Home and Progress screens and persists the richer breakdown exposed by
  /// [loadExerciseStats].
  Future<ProgressSnapshot> recordExerciseAttempts(
    List<ExerciseAttempt> attempts, {
    DateTime? occurredAt,
  });

  Future<ExerciseStatsSnapshot> loadExerciseStats();
}

/// The mastery-matrix column that a playback [direction] contributes to.
TrainingMode trainingModeForDirection(IntervalDirection direction) {
  switch (direction) {
    case IntervalDirection.ascending:
      return TrainingMode.ascending;
    case IntervalDirection.descending:
      return TrainingMode.descending;
    case IntervalDirection.harmonic:
      return TrainingMode.harmonic;
  }
}

/// Computes the next streak value from the previous session date.
int nextStreak({
  required int currentStreak,
  required DateTime? lastSessionDate,
  required DateTime now,
}) {
  if (lastSessionDate == null) {
    return 1;
  }

  final today = DateTime(now.year, now.month, now.day);
  final last = DateTime(
    lastSessionDate.year,
    lastSessionDate.month,
    lastSessionDate.day,
  );
  final dayGap = today.difference(last).inDays;

  if (dayGap <= 0) {
    return currentStreak;
  }

  if (dayGap == 1) {
    return currentStreak + 1;
  }

  return 1;
}

class InMemoryIntervalProgressRepository implements IntervalProgressRepository {
  final Map<MusicInterval, IntervalProgress> _intervals = {};
  final Map<MusicInterval, AttemptTotals> _byInterval = {};
  final Map<IntervalDirection, AttemptTotals> _byDirection = {};
  final Map<ExerciseType, AttemptTotals> _byExerciseType = {};
  final Map<(MusicInterval, MusicInterval), int> _confusions = {};
  int _streakDays = 0;
  int _completedSessions = 0;
  DateTime? _lastSessionDate;

  @override
  Future<ProgressSnapshot> load() async {
    return _snapshot();
  }

  @override
  Future<ProgressSnapshot> recordAttempts(
    List<IntervalAttempt> attempts, {
    DateTime? occurredAt,
  }) async {
    for (final attempt in attempts) {
      _applyAggregate(attempt.interval, attempt.mode, attempt.correct);
    }

    _bumpSession(occurredAt);

    return _snapshot();
  }

  @override
  Future<ProgressSnapshot> recordExerciseAttempts(
    List<ExerciseAttempt> attempts, {
    DateTime? occurredAt,
  }) async {
    for (final attempt in attempts) {
      _applyAggregate(
        attempt.expected,
        trainingModeForDirection(attempt.direction),
        attempt.correct,
      );
      _applyDetailed(attempt);
    }

    _bumpSession(occurredAt);

    return _snapshot();
  }

  @override
  Future<ExerciseStatsSnapshot> loadExerciseStats() async {
    return ExerciseStatsSnapshot(
      byInterval: Map.unmodifiable(_byInterval),
      byDirection: Map.unmodifiable(_byDirection),
      byExerciseType: Map.unmodifiable(_byExerciseType),
      confusions: _confusions.entries
          .map(
            (entry) => IntervalConfusion(
              expected: entry.key.$1,
              selected: entry.key.$2,
              count: entry.value,
            ),
          )
          .toList(),
    );
  }

  void _applyAggregate(MusicInterval interval, TrainingMode mode, bool correct) {
    final current = _intervals[interval] ?? IntervalProgress.empty(interval);
    final scores = Map<TrainingMode, MasteryScore>.from(current.scores);
    scores[mode] = current.scoreFor(mode).add(correct: correct);
    _intervals[interval] = IntervalProgress(interval: interval, scores: scores);
  }

  void _applyDetailed(ExerciseAttempt attempt) {
    final responseMillis = attempt.responseTime.inMilliseconds;

    _byInterval[attempt.expected] = (_byInterval[attempt.expected] ??
            const AttemptTotals())
        .add(
          correct: attempt.correct,
          skipped: attempt.skipped,
          replays: attempt.replayCount,
          responseMillis: responseMillis,
        );
    _byDirection[attempt.direction] = (_byDirection[attempt.direction] ??
            const AttemptTotals())
        .add(
          correct: attempt.correct,
          skipped: attempt.skipped,
          replays: attempt.replayCount,
          responseMillis: responseMillis,
        );
    _byExerciseType[attempt.type] = (_byExerciseType[attempt.type] ??
            const AttemptTotals())
        .add(
          correct: attempt.correct,
          skipped: attempt.skipped,
          replays: attempt.replayCount,
          responseMillis: responseMillis,
        );

    final selected = attempt.selected;

    if (selected != null && !attempt.correct) {
      final key = (attempt.expected, selected);
      _confusions[key] = (_confusions[key] ?? 0) + 1;
    }
  }

  void _bumpSession(DateTime? occurredAt) {
    final now = occurredAt ?? DateTime.now();
    _streakDays = nextStreak(
      currentStreak: _streakDays,
      lastSessionDate: _lastSessionDate,
      now: now,
    );
    _lastSessionDate = now;
    _completedSessions += 1;
  }

  ProgressSnapshot _snapshot() {
    return ProgressSnapshot(
      streakDays: _streakDays,
      completedSessions: _completedSessions,
      intervals: Map.unmodifiable(_intervals),
    );
  }
}

class SharedPreferencesIntervalProgressRepository
    implements IntervalProgressRepository {
  const SharedPreferencesIntervalProgressRepository();

  static const _streakKey = 'intervals.streakDays';
  static const _sessionsKey = 'intervals.completedSessions';
  static const _lastSessionKey = 'intervals.lastSessionEpochDay';

  @override
  Future<ProgressSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();

    return _readSnapshot(preferences);
  }

  @override
  Future<ProgressSnapshot> recordAttempts(
    List<IntervalAttempt> attempts, {
    DateTime? occurredAt,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    for (final attempt in attempts) {
      await _applyAggregate(
        preferences,
        attempt.interval,
        attempt.mode,
        attempt.correct,
      );
    }

    await _bumpSession(preferences, occurredAt);

    return _readSnapshot(preferences);
  }

  @override
  Future<ProgressSnapshot> recordExerciseAttempts(
    List<ExerciseAttempt> attempts, {
    DateTime? occurredAt,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    for (final attempt in attempts) {
      await _applyAggregate(
        preferences,
        attempt.expected,
        trainingModeForDirection(attempt.direction),
        attempt.correct,
      );
      await _applyDetailed(preferences, attempt);
    }

    await _bumpSession(preferences, occurredAt);

    return _readSnapshot(preferences);
  }

  @override
  Future<ExerciseStatsSnapshot> loadExerciseStats() async {
    final preferences = await SharedPreferences.getInstance();

    return _readExerciseStats(preferences);
  }

  Future<void> _applyAggregate(
    SharedPreferences preferences,
    MusicInterval interval,
    TrainingMode mode,
    bool correct,
  ) async {
    final correctKey = _correctKey(interval, mode);
    final totalKey = _totalKey(interval, mode);

    await preferences.setInt(totalKey, (preferences.getInt(totalKey) ?? 0) + 1);

    if (correct) {
      await preferences.setInt(
        correctKey,
        (preferences.getInt(correctKey) ?? 0) + 1,
      );
    }
  }

  Future<void> _applyDetailed(
    SharedPreferences preferences,
    ExerciseAttempt attempt,
  ) async {
    final responseMillis = attempt.responseTime.inMilliseconds;

    await _addTotals(
      preferences,
      'exstats.interval.${attempt.expected.name}',
      correct: attempt.correct,
      skipped: attempt.skipped,
      replays: attempt.replayCount,
      responseMillis: responseMillis,
    );
    await _addTotals(
      preferences,
      'exstats.direction.${attempt.direction.name}',
      correct: attempt.correct,
      skipped: attempt.skipped,
      replays: attempt.replayCount,
      responseMillis: responseMillis,
    );
    await _addTotals(
      preferences,
      'exstats.type.${attempt.type.name}',
      correct: attempt.correct,
      skipped: attempt.skipped,
      replays: attempt.replayCount,
      responseMillis: responseMillis,
    );

    final selected = attempt.selected;

    if (selected != null && !attempt.correct) {
      final key =
          'exstats.confusion.${attempt.expected.name}.${selected.name}';
      await preferences.setInt(key, (preferences.getInt(key) ?? 0) + 1);
    }
  }

  Future<void> _addTotals(
    SharedPreferences preferences,
    String prefix, {
    required bool correct,
    required bool skipped,
    required int replays,
    required int responseMillis,
  }) async {
    await _increment(preferences, '$prefix.total', 1);
    await _increment(preferences, '$prefix.correct', correct ? 1 : 0);
    await _increment(preferences, '$prefix.skipped', skipped ? 1 : 0);
    await _increment(preferences, '$prefix.replays', replays);
    await _increment(preferences, '$prefix.millis', responseMillis);
  }

  Future<void> _increment(
    SharedPreferences preferences,
    String key,
    int delta,
  ) async {
    if (delta == 0) {
      return;
    }

    await preferences.setInt(key, (preferences.getInt(key) ?? 0) + delta);
  }

  Future<void> _bumpSession(
    SharedPreferences preferences,
    DateTime? occurredAt,
  ) async {
    final now = occurredAt ?? DateTime.now();
    final lastEpochDay = preferences.getInt(_lastSessionKey);
    final lastSessionDate = lastEpochDay == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            lastEpochDay * Duration.millisecondsPerDay,
          );
    final streak = nextStreak(
      currentStreak: preferences.getInt(_streakKey) ?? 0,
      lastSessionDate: lastSessionDate,
      now: now,
    );

    await preferences.setInt(_streakKey, streak);
    await preferences.setInt(
      _sessionsKey,
      (preferences.getInt(_sessionsKey) ?? 0) + 1,
    );
    await preferences.setInt(
      _lastSessionKey,
      DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/
          Duration.millisecondsPerDay,
    );
  }

  ProgressSnapshot _readSnapshot(SharedPreferences preferences) {
    final intervals = <MusicInterval, IntervalProgress>{};

    for (final interval in MusicInterval.values) {
      final scores = <TrainingMode, MasteryScore>{};

      for (final mode in TrainingMode.values) {
        scores[mode] = MasteryScore(
          correct: preferences.getInt(_correctKey(interval, mode)) ?? 0,
          total: preferences.getInt(_totalKey(interval, mode)) ?? 0,
        );
      }

      intervals[interval] = IntervalProgress(
        interval: interval,
        scores: scores,
      );
    }

    return ProgressSnapshot(
      streakDays: preferences.getInt(_streakKey) ?? 0,
      completedSessions: preferences.getInt(_sessionsKey) ?? 0,
      intervals: Map.unmodifiable(intervals),
    );
  }

  ExerciseStatsSnapshot _readExerciseStats(SharedPreferences preferences) {
    final byInterval = <MusicInterval, AttemptTotals>{};

    for (final interval in MusicInterval.values) {
      final totals = _readTotals(
        preferences,
        'exstats.interval.${interval.name}',
      );

      if (totals.total > 0) {
        byInterval[interval] = totals;
      }
    }

    final byDirection = <IntervalDirection, AttemptTotals>{};

    for (final direction in IntervalDirection.values) {
      final totals = _readTotals(
        preferences,
        'exstats.direction.${direction.name}',
      );

      if (totals.total > 0) {
        byDirection[direction] = totals;
      }
    }

    final byExerciseType = <ExerciseType, AttemptTotals>{};

    for (final type in ExerciseType.values) {
      final totals = _readTotals(preferences, 'exstats.type.${type.name}');

      if (totals.total > 0) {
        byExerciseType[type] = totals;
      }
    }

    final confusions = <IntervalConfusion>[];

    for (final expected in MusicInterval.values) {
      for (final selected in MusicInterval.values) {
        final key = 'exstats.confusion.${expected.name}.${selected.name}';
        final count = preferences.getInt(key) ?? 0;

        if (count > 0) {
          confusions.add(
            IntervalConfusion(
              expected: expected,
              selected: selected,
              count: count,
            ),
          );
        }
      }
    }

    return ExerciseStatsSnapshot(
      byInterval: Map.unmodifiable(byInterval),
      byDirection: Map.unmodifiable(byDirection),
      byExerciseType: Map.unmodifiable(byExerciseType),
      confusions: confusions,
    );
  }

  AttemptTotals _readTotals(SharedPreferences preferences, String prefix) {
    return AttemptTotals(
      total: preferences.getInt('$prefix.total') ?? 0,
      correct: preferences.getInt('$prefix.correct') ?? 0,
      skipped: preferences.getInt('$prefix.skipped') ?? 0,
      replays: preferences.getInt('$prefix.replays') ?? 0,
      responseMillis: preferences.getInt('$prefix.millis') ?? 0,
    );
  }

  String _correctKey(MusicInterval interval, TrainingMode mode) {
    return 'intervals.${interval.name}.${mode.name}.correct';
  }

  String _totalKey(MusicInterval interval, TrainingMode mode) {
    return 'intervals.${interval.name}.${mode.name}.total';
  }
}
