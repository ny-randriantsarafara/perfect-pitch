import 'dart:math';

/// A concrete pitch identified by its MIDI note number.
///
/// Using MIDI numbers keeps interval math simple: transposing by an interval is
/// just adding its semitone count, and any chromatic pitch can be represented.
class Pitch {
  const Pitch(this.midi);

  /// C4 (middle C), a comfortable reference for ear-training sessions.
  static const Pitch middleC = Pitch(60);

  final int midi;

  static const List<String> _noteNames = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  double get frequency {
    final semitonesFromA4 = midi - 69;

    return 440 * pow(2, semitonesFromA4 / 12).toDouble();
  }

  int get octave {
    return (midi ~/ 12) - 1;
  }

  String get noteName {
    return _noteNames[midi % 12];
  }

  Pitch transposed(int semitones) {
    return Pitch(midi + semitones);
  }

  @override
  bool operator ==(Object other) {
    return other is Pitch && other.midi == midi;
  }

  @override
  int get hashCode {
    return midi.hashCode;
  }

  @override
  String toString() {
    return '$noteName$octave';
  }
}
