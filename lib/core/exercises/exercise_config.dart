import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

/// The complete, immutable description of one practice session.
///
/// A single [ExerciseConfig] drives question generation, playback direction,
/// UI labels, persistence, and summary behavior, so every exercise in the
/// catalogue reuses the same session flow.
class ExerciseConfig {
  ExerciseConfig({
    required this.type,
    required List<MusicInterval> intervals,
    required Set<IntervalDirection> directions,
    this.instrument = Instrument.piano,
    this.questionCount = 10,
    this.choiceCount = 4,
    this.replayLimit = 3,
    this.minimumRootMidi = 55,
    this.maximumRootMidi = 64,
    this.autoPlay = true,
    this.immediateFeedback = true,
    this.showDirectionBeforeAnswer = true,
  }) : intervals = List.unmodifiable(intervals),
       directions = Set.unmodifiable(directions);

  /// A beginner-friendly configuration for [type], using the intervals unlocked
  /// through stage three and the exercise's [ExerciseType.defaultDirections].
  factory ExerciseConfig.defaults(ExerciseType type) {
    final directions = type.defaultDirections;

    return ExerciseConfig(
      type: type,
      intervals: _defaultIntervals(directions),
      directions: directions,
    );
  }

  final ExerciseType type;
  final List<MusicInterval> intervals;
  final Set<IntervalDirection> directions;
  final Instrument instrument;
  final int questionCount;
  final int choiceCount;

  /// Manual replays allowed per question, or `null` for unlimited.
  final int? replayLimit;
  final int minimumRootMidi;
  final int maximumRootMidi;
  final bool autoPlay;
  final bool immediateFeedback;
  final bool showDirectionBeforeAnswer;

  bool get allowsUnlimitedReplays {
    return replayLimit == null;
  }

  ExerciseConfig copyWith({
    List<MusicInterval>? intervals,
    Set<IntervalDirection>? directions,
    Instrument? instrument,
    int? questionCount,
    int? choiceCount,
    int? replayLimit,
    bool clearReplayLimit = false,
    int? minimumRootMidi,
    int? maximumRootMidi,
    bool? autoPlay,
    bool? immediateFeedback,
    bool? showDirectionBeforeAnswer,
  }) {
    return ExerciseConfig(
      type: type,
      intervals: intervals ?? this.intervals,
      directions: directions ?? this.directions,
      instrument: instrument ?? this.instrument,
      questionCount: questionCount ?? this.questionCount,
      choiceCount: choiceCount ?? this.choiceCount,
      replayLimit: clearReplayLimit ? null : (replayLimit ?? this.replayLimit),
      minimumRootMidi: minimumRootMidi ?? this.minimumRootMidi,
      maximumRootMidi: maximumRootMidi ?? this.maximumRootMidi,
      autoPlay: autoPlay ?? this.autoPlay,
      immediateFeedback: immediateFeedback ?? this.immediateFeedback,
      showDirectionBeforeAnswer:
          showDirectionBeforeAnswer ?? this.showDirectionBeforeAnswer,
    );
  }

  /// Intervals unlocked through stage three, excluding unison whenever the only
  /// available direction is descending (a descending unison has no audible
  /// direction).
  static List<MusicInterval> _defaultIntervals(
    Set<IntervalDirection> directions,
  ) {
    final base = MusicInterval.upToStage(3);
    final excludeUnison =
        directions.length == 1 &&
        directions.contains(IntervalDirection.descending);

    if (!excludeUnison) {
      return base;
    }

    return base
        .where((interval) => interval != MusicInterval.unison)
        .toList();
  }
}
