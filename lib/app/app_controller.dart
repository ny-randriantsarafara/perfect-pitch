import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';
import 'package:perfect_pitch/features/guitar/guitar_controller.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';

/// The four primary destinations mirrored from the designer navigation.
enum AppTab { home, practice, guitar, stats }

/// Owns global app state: the active tab, the loaded progress snapshot, and the
/// per-feature controllers. Feature controllers report their graded answers
/// back here so mastery is persisted in one place.
class AppController extends ChangeNotifier {
  AppController({
    required this.audioEngine,
    IntervalProgressRepository? progressRepository,
  }) : _progressRepository =
           progressRepository ?? InMemoryIntervalProgressRepository() {
    practice = PracticeController(
      audioEngine: audioEngine,
      onSessionCompleted: _handlePracticeCompleted,
    );
    guitar = GuitarController(
      audioEngine: audioEngine,
      onAttemptRecorded: _handleGuitarAttempt,
    );
    unawaited(_loadProgress());
  }

  final AudioEngine audioEngine;
  final IntervalProgressRepository _progressRepository;

  late final PracticeController practice;
  late final GuitarController guitar;

  AppTab _tab = AppTab.home;
  ProgressSnapshot _progress = ProgressSnapshot.empty();

  AppTab get tab {
    return _tab;
  }

  ProgressSnapshot get progress {
    return _progress;
  }

  void selectTab(AppTab tab) {
    _tab = tab;
    notifyListeners();
  }

  /// Opens the Exercises tab on its catalogue (no session starts implicitly).
  void startPractice() {
    practice.returnToExercises();
    selectTab(AppTab.practice);
  }

  Future<void> _loadProgress() async {
    _progress = await _progressRepository.load();
    notifyListeners();
  }

  void _handlePracticeCompleted(List<ExerciseAttempt> exerciseAttempts) {
    unawaited(_recordExerciseAttempts(exerciseAttempts));
  }

  void _handleGuitarAttempt({
    required MusicInterval interval,
    required bool correct,
  }) {
    unawaited(
      _record([
        IntervalAttempt(
          interval: interval,
          mode: TrainingMode.guitar,
          correct: correct,
        ),
      ]),
    );
  }

  Future<void> _record(List<IntervalAttempt> attempts) async {
    _progress = await _progressRepository.recordAttempts(attempts);
    notifyListeners();
  }

  Future<void> _recordExerciseAttempts(List<ExerciseAttempt> attempts) async {
    _progress = await _progressRepository.recordExerciseAttempts(attempts);
    notifyListeners();
  }

  @override
  void dispose() {
    practice.dispose();
    guitar.dispose();
    super.dispose();
  }
}
