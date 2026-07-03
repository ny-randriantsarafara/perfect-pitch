import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_native.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';

void main() {
  test('uses a real audio player on native platforms', () {
    expect(createPlatformAudioPlayer(), isNot(isA<SilentAudioPlayer>()));
  });

  test('configures iOS playback audio session for audible tones', () {
    expect(
      NativeSynthAudioPlayer.playbackAudioContext.iOS.category,
      AVAudioSessionCategory.playback,
    );
  });

  test('declares generated tone bytes as wav audio', () {
    expect(NativeSynthAudioPlayer.wavMimeType, 'audio/wav');
  });
}
