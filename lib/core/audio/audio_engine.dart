import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';

class AudioClipRequest {
  const AudioClipRequest({
    required this.note,
    required this.octave,
    required this.instrumentId,
    this.duration = const Duration(milliseconds: 900),
  });

  final MusicNote note;
  final int octave;
  final InstrumentId instrumentId;
  final Duration duration;

  double get frequency {
    return note.frequencyInOctave(octave);
  }
}

class AudioSequenceStep {
  const AudioSequenceStep._({required this.request, required this.pause});

  factory AudioSequenceStep.play(AudioClipRequest request) {
    return AudioSequenceStep._(request: request, pause: Duration.zero);
  }

  factory AudioSequenceStep.pause(Duration duration) {
    return AudioSequenceStep._(request: null, pause: duration);
  }

  final AudioClipRequest? request;
  final Duration pause;
}

class ComparisonSequence {
  ComparisonSequence({
    required AudioClipRequest correct,
    required AudioClipRequest selected,
  }) : steps = List.unmodifiable([
         AudioSequenceStep.play(correct),
         AudioSequenceStep.pause(const Duration(milliseconds: 350)),
         AudioSequenceStep.play(selected),
         AudioSequenceStep.pause(const Duration(milliseconds: 350)),
         AudioSequenceStep.play(correct),
       ]);

  final List<AudioSequenceStep> steps;
}

class SampleAssetResolver {
  const SampleAssetResolver();

  String pathFor(AudioClipRequest request) {
    final instrumentFolder = _instrumentFolder(request.instrumentId);
    final noteName = request.note.internationalName.toLowerCase();

    return 'assets/audio/$instrumentFolder/$noteName${request.octave}.mp3';
  }

  String _instrumentFolder(InstrumentId instrumentId) {
    switch (instrumentId) {
      case InstrumentId.sine:
        return 'sine';
      case InstrumentId.warmSynth:
        return 'warm-synth';
      case InstrumentId.piano:
        return 'piano';
      case InstrumentId.cleanElectricGuitar:
        return 'clean-electric-guitar';
      case InstrumentId.acousticGuitar:
        return 'acoustic-guitar';
      case InstrumentId.synthesizer:
        return 'synthesizer';
      case InstrumentId.random:
        return 'random';
    }
  }
}

abstract class AudioPlayer {
  Future<void> play(AudioClipRequest request);
}

class AudioEngine {
  const AudioEngine({required this.player});

  final AudioPlayer player;

  Future<void> play(AudioClipRequest request) {
    return player.play(request);
  }

  Future<void> playComparison(ComparisonSequence sequence) async {
    for (final step in sequence.steps) {
      final request = step.request;

      if (request != null) {
        await player.play(request);
        continue;
      }

      await Future<void>.delayed(step.pause);
    }
  }
}
