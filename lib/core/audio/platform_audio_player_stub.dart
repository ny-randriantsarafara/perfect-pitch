import 'package:perfect_pitch/core/audio/audio_engine.dart';

AudioPlayer createAudioPlayer() {
  return const SilentAudioPlayer();
}

class SilentAudioPlayer implements AudioPlayer {
  const SilentAudioPlayer();

  @override
  Future<void> play(AudioClipRequest request) async {}
}
