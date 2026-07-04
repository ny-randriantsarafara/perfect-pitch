import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

void main() {
  final audioEngine = AudioEngine(player: createPlatformAudioPlayer());
  const progressRepository = SharedPreferencesIntervalProgressRepository();
  const courseProgressRepository = SharedPreferencesCourseProgressRepository();

  runApp(
    PerfectPitchApp(
      audioEngine: audioEngine,
      progressRepository: progressRepository,
      courseProgressRepository: courseProgressRepository,
    ),
  );
}
