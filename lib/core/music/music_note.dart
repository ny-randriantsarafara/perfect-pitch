import 'dart:math';

enum MusicNote {
  doNote(solfegeName: 'Do', internationalName: 'C', semitoneFromC: 0),
  re(solfegeName: 'Ré', internationalName: 'D', semitoneFromC: 2),
  mi(solfegeName: 'Mi', internationalName: 'E', semitoneFromC: 4),
  fa(solfegeName: 'Fa', internationalName: 'F', semitoneFromC: 5),
  sol(solfegeName: 'Sol', internationalName: 'G', semitoneFromC: 7),
  la(solfegeName: 'La', internationalName: 'A', semitoneFromC: 9),
  si(solfegeName: 'Si', internationalName: 'B', semitoneFromC: 11);

  const MusicNote({
    required this.solfegeName,
    required this.internationalName,
    required this.semitoneFromC,
  });

  static const naturalNotes = [doNote, re, mi, fa, sol, la, si];

  final String solfegeName;
  final String internationalName;
  final int semitoneFromC;

  int get naturalIndex {
    return naturalNotes.indexOf(this);
  }

  double frequencyInOctave(int octave) {
    final midiNote = ((octave + 1) * 12) + semitoneFromC;
    final semitoneDistanceFromA4 = midiNote - 69;
    final frequencyRatio = pow(2, semitoneDistanceFromA4 / 12);

    return 440 * frequencyRatio.toDouble();
  }
}
