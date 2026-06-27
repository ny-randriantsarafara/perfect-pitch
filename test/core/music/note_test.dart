import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/music/music_note.dart';

void main() {
  group('MusicNote', () {
    test('exposes natural notes in solfege order', () {
      final solfegeNames = MusicNote.naturalNotes
          .map((note) => note.solfegeName)
          .toList();

      expect(solfegeNames, ['Do', 'Ré', 'Mi', 'Fa', 'Sol', 'La', 'Si']);
    });

    test('maps natural notes to international names', () {
      final internationalNames = MusicNote.naturalNotes
          .map((note) => note.internationalName)
          .toList();

      expect(internationalNames, ['C', 'D', 'E', 'F', 'G', 'A', 'B']);
    });

    test('calculates frequencies from octave and semitone', () {
      expect(MusicNote.la.frequencyInOctave(4), closeTo(440, 0.01));
      expect(MusicNote.doNote.frequencyInOctave(4), closeTo(261.63, 0.01));
      expect(MusicNote.doNote.frequencyInOctave(5), closeTo(523.25, 0.01));
    });
  });
}
