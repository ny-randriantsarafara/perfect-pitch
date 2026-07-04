import 'package:perfect_pitch/core/audio/audio_engine.dart';

/// The interval-recognition exercises offered in the catalogue.
///
/// Each exercise reuses the same session flow; the difference is which playback
/// directions its questions may use (see [defaultDirections]). Mixed mode picks
/// a direction per question, while the others stay on a single direction.
enum ExerciseType {
  ascendingIntervals,
  descendingIntervals,
  harmonicIntervals,
  mixedIntervals;

  /// The playback directions a fresh session of this exercise may use.
  Set<IntervalDirection> get defaultDirections {
    switch (this) {
      case ExerciseType.ascendingIntervals:
        return const {IntervalDirection.ascending};
      case ExerciseType.descendingIntervals:
        return const {IntervalDirection.descending};
      case ExerciseType.harmonicIntervals:
        return const {IntervalDirection.harmonic};
      case ExerciseType.mixedIntervals:
        return const {
          IntervalDirection.ascending,
          IntervalDirection.descending,
          IntervalDirection.harmonic,
        };
    }
  }

  /// Whether this exercise mixes several playback directions.
  bool get isMixed {
    return this == ExerciseType.mixedIntervals;
  }
}
