import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';

void main() {
  group('AudioClipRequest', () {
    test('derives frequency from note and octave for synthesis', () {
      final request = AudioClipRequest(
        note: MusicNote.la,
        octave: 4,
        instrumentId: InstrumentId.sine,
      );

      expect(request.frequency, closeTo(440, 0.01));
      expect(request.duration, const Duration(milliseconds: 900));
    });
  });

  group('SampleAssetResolver', () {
    test('builds stable asset paths for future bundled samples', () {
      final resolver = SampleAssetResolver();
      final request = AudioClipRequest(
        note: MusicNote.doNote,
        octave: 4,
        instrumentId: InstrumentId.piano,
      );

      expect(resolver.pathFor(request), 'assets/audio/piano/c4.mp3');
    });
  });

  group('ComparisonSequence', () {
    test('plays correct, selected, correct with pauses', () {
      final sequence = ComparisonSequence(
        correct: const AudioClipRequest(
          note: MusicNote.sol,
          octave: 4,
          instrumentId: InstrumentId.sine,
        ),
        selected: const AudioClipRequest(
          note: MusicNote.la,
          octave: 4,
          instrumentId: InstrumentId.sine,
        ),
      );

      expect(sequence.steps, hasLength(5));
      expect(sequence.steps[0].request?.note, MusicNote.sol);
      expect(sequence.steps[1].pause, const Duration(milliseconds: 350));
      expect(sequence.steps[2].request?.note, MusicNote.la);
      expect(sequence.steps[3].pause, const Duration(milliseconds: 350));
      expect(sequence.steps[4].request?.note, MusicNote.sol);
    });
  });
}
