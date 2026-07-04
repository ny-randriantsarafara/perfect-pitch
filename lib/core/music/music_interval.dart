/// The twelve musical intervals within an octave, plus the octave itself.
///
/// [stage] encodes the progressive introduction order described in the product
/// spec: beginners start with unison and octave, then add the perfect fifth,
/// the thirds, and so on. This avoids overwhelming learners with all intervals
/// at once.
enum MusicInterval {
  unison(semitones: 0, stage: 1),
  minorSecond(semitones: 1, stage: 5),
  majorSecond(semitones: 2, stage: 5),
  minorThird(semitones: 3, stage: 3),
  majorThird(semitones: 4, stage: 3),
  perfectFourth(semitones: 5, stage: 4),
  tritone(semitones: 6, stage: 8),
  perfectFifth(semitones: 7, stage: 2),
  minorSixth(semitones: 8, stage: 6),
  majorSixth(semitones: 9, stage: 6),
  minorSeventh(semitones: 10, stage: 7),
  majorSeventh(semitones: 11, stage: 7),
  octave(semitones: 12, stage: 1);

  const MusicInterval({required this.semitones, required this.stage});

  final int semitones;
  final int stage;

  /// The number of progression stages available.
  static const int maxStage = 8;

  /// All intervals unlocked up to and including [stage], in pitch order.
  static List<MusicInterval> upToStage(int stage) {
    return values.where((interval) => interval.stage <= stage).toList();
  }
}
