import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player.dart';
import 'package:perfect_pitch/core/storage/progress_repository.dart';

void main() {
  final audioEngine = AudioEngine(player: createPlatformAudioPlayer());
  const progressRepository = SharedPreferencesProgressRepository();

  runApp(
    PerfectPitchApp(
      audioEngine: audioEngine,
      progressRepository: progressRepository,
    ),
  );
}
