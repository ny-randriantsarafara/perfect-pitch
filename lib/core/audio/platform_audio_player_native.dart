import 'package:audioplayers/audioplayers.dart' as audio_package;
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/synth_wav.dart';

AudioPlayer createAudioPlayer() {
  return const NativeSynthAudioPlayer();
}

class NativeSynthAudioPlayer implements AudioPlayer {
  const NativeSynthAudioPlayer();

  static const wavMimeType = 'audio/wav';

  static final playbackAudioContext = audio_package.AudioContext(
    iOS: audio_package.AudioContextIOS(
      category: audio_package.AVAudioSessionCategory.playback,
    ),
  );

  @override
  Future<void> playTone(ToneRequest request) {
    return _play(request);
  }

  @override
  Future<void> playChord(List<ToneRequest> requests) {
    return Future.wait(requests.map(_play)).then((_) {});
  }

  Future<void> _play(ToneRequest request) async {
    final player = audio_package.AudioPlayer();
    final bytes = SynthWav.encodeTone(
      frequency: request.frequency,
      instrument: request.instrument,
      duration: request.duration,
    );

    try {
      await audio_package.AudioPlayer.global.setAudioContext(
        playbackAudioContext,
      );
      await player.setAudioContext(playbackAudioContext);
      await player.setReleaseMode(audio_package.ReleaseMode.stop);
      await player.play(
        audio_package.BytesSource(bytes, mimeType: wavMimeType),
      );
      await Future<void>.delayed(request.duration);
    } finally {
      await player.dispose();
    }
  }
}
