/// The twelve musical intervals within an octave, plus the octave itself.
///
/// [stage] encodes the progressive introduction order described in the product
/// spec: beginners start with unison and octave, then add the perfect fifth,
/// the thirds, and so on. This avoids overwhelming learners with all intervals
/// at once.
enum MusicInterval {
  unison(
    semitones: 0,
    labelFr: 'Unisson',
    sensationFr: 'Même identité, même hauteur',
    stage: 1,
  ),
  minorSecond(
    semitones: 1,
    labelFr: 'Seconde Mineure',
    sensationFr: 'Très serrée, tendue',
    stage: 5,
  ),
  majorSecond(
    semitones: 2,
    labelFr: 'Seconde Majeure',
    sensationFr: 'Petit mouvement mélodique',
    stage: 5,
  ),
  minorThird(
    semitones: 3,
    labelFr: 'Tierce Mineure',
    sensationFr: 'Couleur mineure',
    stage: 3,
  ),
  majorThird(
    semitones: 4,
    labelFr: 'Tierce Majeure',
    sensationFr: 'Couleur majeure',
    stage: 3,
  ),
  perfectFourth(
    semitones: 5,
    labelFr: 'Quarte Juste',
    sensationFr: 'Ouverte, suspendue',
    stage: 4,
  ),
  tritone(
    semitones: 6,
    labelFr: 'Triton',
    sensationFr: 'Instable, très tendu',
    stage: 8,
  ),
  perfectFifth(
    semitones: 7,
    labelFr: 'Quinte Juste',
    sensationFr: 'Stable, puissante',
    stage: 2,
  ),
  minorSixth(
    semitones: 8,
    labelFr: 'Sixte Mineure',
    sensationFr: 'Nostalgique, douce',
    stage: 6,
  ),
  majorSixth(
    semitones: 9,
    labelFr: 'Sixte Majeure',
    sensationFr: 'Ouverte, lumineuse',
    stage: 6,
  ),
  minorSeventh(
    semitones: 10,
    labelFr: 'Septième Mineure',
    sensationFr: 'Tendue, en attente',
    stage: 7,
  ),
  majorSeventh(
    semitones: 11,
    labelFr: 'Septième Majeure',
    sensationFr: 'Très tendue, brillante',
    stage: 7,
  ),
  octave(
    semitones: 12,
    labelFr: 'Octave',
    sensationFr: 'Même identité, autre hauteur',
    stage: 1,
  );

  const MusicInterval({
    required this.semitones,
    required this.labelFr,
    required this.sensationFr,
    required this.stage,
  });

  final int semitones;
  final String labelFr;
  final String sensationFr;
  final int stage;

  /// The number of progression stages available.
  static const int maxStage = 8;

  /// All intervals unlocked up to and including [stage], in pitch order.
  static List<MusicInterval> upToStage(int stage) {
    return values.where((interval) => interval.stage <= stage).toList();
  }
}
