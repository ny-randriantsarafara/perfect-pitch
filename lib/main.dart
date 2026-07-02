import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

void main() {
  final audioEngine = AudioEngine(player: createPlatformAudioPlayer());
  const progressRepository = SharedPreferencesIntervalProgressRepository();

  runApp(
    PerfectPitchApp(
      audioEngine: audioEngine,
      progressRepository: progressRepository,
    ),
  );
}
