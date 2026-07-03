import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart'
    if (dart.library.io) 'package:perfect_pitch/core/audio/platform_audio_player_native.dart'
    if (dart.library.html) 'package:perfect_pitch/core/audio/platform_audio_player_web.dart';

AudioPlayer createPlatformAudioPlayer() {
  return createAudioPlayer();
}
