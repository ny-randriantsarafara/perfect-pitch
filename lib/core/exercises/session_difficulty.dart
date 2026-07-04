import 'dart:math';

import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

/// A one-tap difficulty preset for the setup screen. Applying a difficulty
/// rewrites the interval set, choice count, replay allowance, and whether the
/// playback direction is revealed before answering, while keeping the
/// exercise's type, directions, instrument, and question count untouched.
enum SessionDifficulty {
  beginner(
    stage: 2,
    choiceCount: 3,
    replayLimit: null,
    showDirectionBeforeAnswer: true,
  ),
  easy(
    stage: 3,
    choiceCount: 4,
    replayLimit: 3,
    showDirectionBeforeAnswer: true,
  ),
  medium(
    stage: 6,
    choiceCount: 4,
    replayLimit: 2,
    showDirectionBeforeAnswer: false,
  ),
  hard(
    stage: MusicInterval.maxStage,
    choiceCount: 5,
    replayLimit: 1,
    showDirectionBeforeAnswer: false,
  );

  const SessionDifficulty({
    required this.stage,
    required this.choiceCount,
    required this.replayLimit,
    required this.showDirectionBeforeAnswer,
  });

  final int stage;
  final int choiceCount;
  final int? replayLimit;
  final bool showDirectionBeforeAnswer;

  /// The difficulty a freshly created [ExerciseConfig.defaults] corresponds to.
  static const SessionDifficulty initial = SessionDifficulty.easy;

  ExerciseConfig apply(ExerciseConfig base) {
    final intervals = _intervalsFor(base.directions);

    return base.copyWith(
      intervals: intervals,
      choiceCount: min(choiceCount, intervals.length),
      replayLimit: replayLimit,
      clearReplayLimit: replayLimit == null,
      showDirectionBeforeAnswer: showDirectionBeforeAnswer,
    );
  }

  List<MusicInterval> _intervalsFor(Set<IntervalDirection> directions) {
    final base = MusicInterval.upToStage(stage);
    final excludeUnison =
        directions.length == 1 &&
        directions.contains(IntervalDirection.descending);

    if (!excludeUnison) {
      return base;
    }

    return base.where((interval) => interval != MusicInterval.unison).toList();
  }
}
