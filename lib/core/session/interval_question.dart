import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';

/// A single ear-recognition question: an interval to play from a root pitch and
/// the answer choices offered to the learner.
class IntervalQuestion {
  const IntervalQuestion({
    required this.root,
    required this.interval,
    required this.direction,
    required this.instrument,
    required this.choices,
  });

  final Pitch root;
  final MusicInterval interval;
  final IntervalDirection direction;
  final Instrument instrument;
  final List<MusicInterval> choices;

  IntervalPlayback get playback {
    return IntervalPlayback(
      root: root,
      interval: interval,
      direction: direction,
      instrument: instrument,
    );
  }

  IntervalPlayback playbackFor(MusicInterval choice) {
    return IntervalPlayback(
      root: root,
      interval: choice,
      direction: direction,
      instrument: instrument,
    );
  }
}
