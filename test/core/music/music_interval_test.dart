import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';

void main() {
  group('Pitch', () {
    test('A4 resolves to 440 Hz', () {
      expect(const Pitch(69).frequency, closeTo(440, 0.001));
    });

    test('transposing by an octave doubles the frequency', () {
      final root = Pitch.middleC;
      final octaveUp = root.transposed(MusicInterval.octave.semitones);

      expect(octaveUp.frequency, closeTo(root.frequency * 2, 0.001));
    });

    test('exposes the chromatic note name', () {
      expect(Pitch.middleC.noteName, 'C');
      expect(const Pitch(67).noteName, 'G');
    });
  });

  group('MusicInterval', () {
    test('unlocks progressively by stage', () {
      final stageOne = MusicInterval.upToStage(1);

      expect(stageOne, containsAll([MusicInterval.unison, MusicInterval.octave]));
      expect(stageOne, isNot(contains(MusicInterval.perfectFifth)));

      final stageTwo = MusicInterval.upToStage(2);

      expect(stageTwo, contains(MusicInterval.perfectFifth));
    });

    test('semitone counts are correct', () {
      expect(MusicInterval.perfectFifth.semitones, 7);
      expect(MusicInterval.majorThird.semitones, 4);
      expect(MusicInterval.octave.semitones, 12);
    });
  });
}
