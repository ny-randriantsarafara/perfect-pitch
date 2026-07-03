import 'package:perfect_pitch/core/audio/audio_engine.dart';

AudioPlayer createAudioPlayer() {
  return const SilentAudioPlayer();
}

/// No-op player used in tests and unsupported targets.
class SilentAudioPlayer implements AudioPlayer {
  const SilentAudioPlayer();

  @override
  Future<void> playTone(ToneRequest request) async {}

  @override
  Future<void> playChord(List<ToneRequest> requests) async {}
}
