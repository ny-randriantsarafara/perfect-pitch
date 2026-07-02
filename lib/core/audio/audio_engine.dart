import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';

/// How the two notes of an interval are presented to the ear.
enum IntervalDirection { ascending, descending, harmonic }

/// A single synthesized tone.
class ToneRequest {
  const ToneRequest({
    required this.frequency,
    required this.instrument,
    this.duration = const Duration(milliseconds: 850),
  });

  factory ToneRequest.forPitch(
    Pitch pitch, {
    required Instrument instrument,
    Duration duration = const Duration(milliseconds: 850),
  }) {
    return ToneRequest(
      frequency: pitch.frequency,
      instrument: instrument,
      duration: duration,
    );
  }

  final double frequency;
  final Instrument instrument;
  final Duration duration;
}

/// Describes an interval to play from a concrete root pitch.
class IntervalPlayback {
  const IntervalPlayback({
    required this.root,
    required this.interval,
    required this.direction,
    required this.instrument,
  });

  final Pitch root;
  final MusicInterval interval;
  final IntervalDirection direction;
  final Instrument instrument;

  Pitch get target {
    return root.transposed(interval.semitones);
  }
}

/// Platform-specific tone renderer.
abstract class AudioPlayer {
  Future<void> playTone(ToneRequest request);

  /// Plays several tones simultaneously (used for harmonic intervals).
  Future<void> playChord(List<ToneRequest> requests);
}

class AudioEngine {
  const AudioEngine({required this.player});

  final AudioPlayer player;

  static const Duration _gap = Duration(milliseconds: 120);
  static const Duration _comparisonPause = Duration(milliseconds: 350);

  Future<void> playPitch(Pitch pitch, {required Instrument instrument}) {
    return player.playTone(ToneRequest.forPitch(pitch, instrument: instrument));
  }

  Future<void> playInterval(IntervalPlayback playback) async {
    final root = ToneRequest.forPitch(
      playback.root,
      instrument: playback.instrument,
    );
    final target = ToneRequest.forPitch(
      playback.target,
      instrument: playback.instrument,
    );

    switch (playback.direction) {
      case IntervalDirection.ascending:
        await _playSequence([root, target]);
      case IntervalDirection.descending:
        await _playSequence([target, root]);
      case IntervalDirection.harmonic:
        await player.playChord([root, target]);
    }
  }

  /// Plays the correct interval, the learner's interval, then the correct one
  /// again so the ear can hear the difference (see the spec's comparison flow).
  Future<void> playComparison({
    required IntervalPlayback correct,
    required IntervalPlayback selected,
  }) async {
    await playInterval(correct);
    await Future<void>.delayed(_comparisonPause);
    await playInterval(selected);
    await Future<void>.delayed(_comparisonPause);
    await playInterval(correct);
  }

  Future<void> _playSequence(List<ToneRequest> tones) async {
    for (var index = 0; index < tones.length; index += 1) {
      await player.playTone(tones[index]);

      if (index < tones.length - 1) {
        await Future<void>.delayed(_gap);
      }
    }
  }
}
