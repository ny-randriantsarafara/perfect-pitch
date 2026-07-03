import 'package:perfect_pitch/core/audio/audio_engine.dart';

/// The interval-recognition exercises offered in the catalogue.
///
/// Each exercise reuses the same session flow; the difference is which playback
/// directions its questions may use (see [defaultDirections]). Mixed mode picks
/// a direction per question, while the others stay on a single direction.
enum ExerciseType {
  ascendingIntervals(
    labelFr: 'Intervalles ascendants',
    descriptionFr: 'La note grave puis la note aiguë.',
  ),
  descendingIntervals(
    labelFr: 'Intervalles descendants',
    descriptionFr: 'La note aiguë puis la note grave.',
  ),
  harmonicIntervals(
    labelFr: 'Intervalles harmoniques',
    descriptionFr: 'Les deux notes jouées ensemble.',
  ),
  mixedIntervals(
    labelFr: 'Intervalles mixtes',
    descriptionFr: 'Ascendant, descendant ou harmonique à chaque question.',
  );

  const ExerciseType({required this.labelFr, required this.descriptionFr});

  final String labelFr;
  final String descriptionFr;

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
