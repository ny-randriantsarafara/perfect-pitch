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
      final current =
          _intervals[attempt.interval] ??
          IntervalProgress.empty(attempt.interval);
      final scores = Map<TrainingMode, MasteryScore>.from(current.scores);
      scores[attempt.mode] = current
          .scoreFor(attempt.mode)
          .add(correct: attempt.correct);
      _intervals[attempt.interval] = IntervalProgress(
        interval: attempt.interval,
        scores: scores,
      );
    }

    final now = occurredAt ?? DateTime.now();
    _streakDays = nextStreak(
      currentStreak: _streakDays,
      lastSessionDate: _lastSessionDate,
      now: now,
    );
    _lastSessionDate = now;
    _completedSessions += 1;

    return _snapshot();
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
      final correctKey = _correctKey(attempt.interval, attempt.mode);
      final totalKey = _totalKey(attempt.interval, attempt.mode);

      await preferences.setInt(
        totalKey,
        (preferences.getInt(totalKey) ?? 0) + 1,
      );

      if (attempt.correct) {
        await preferences.setInt(
          correctKey,
          (preferences.getInt(correctKey) ?? 0) + 1,
        );
      }
    }

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

    return _readSnapshot(preferences);
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

  String _correctKey(MusicInterval interval, TrainingMode mode) {
    return 'intervals.${interval.name}.${mode.name}.correct';
  }

  String _totalKey(MusicInterval interval, TrainingMode mode) {
    return 'intervals.${interval.name}.${mode.name}.total';
  }
}
