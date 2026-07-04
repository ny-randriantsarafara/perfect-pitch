import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/features/guitar/guitar_controller.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';

/// The five primary destinations mirrored from the designer navigation.
enum AppTab { home, practice, learn, guitar, stats }

/// Owns global app state: the active tab, the loaded progress snapshot, and the
/// per-feature controllers. Feature controllers report their graded answers
/// back here so mastery is persisted in one place.
class AppController extends ChangeNotifier {
  AppController({
    required this.audioEngine,
    IntervalProgressRepository? progressRepository,
    CourseProgressRepository? courseProgressRepository,
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
    course = CourseController(
      progressRepository:
          courseProgressRepository ?? InMemoryCourseProgressRepository(),
    );
    unawaited(_loadProgress());
    unawaited(course.load());
  }

  final AudioEngine audioEngine;
  final IntervalProgressRepository _progressRepository;

  late final PracticeController practice;
  late final GuitarController guitar;
  late final CourseController course;

  AppTab _tab = AppTab.home;
  ProgressSnapshot _progress = ProgressSnapshot.empty();
  Locale? _locale;
  late final List<ExerciseType> _homeRecommendations =
      _pickHomeRecommendations();

  AppTab get tab {
    return _tab;
  }

  ProgressSnapshot get progress {
    return _progress;
  }

  Locale? get locale {
    return _locale;
  }

  /// Two random existing catalogue exercises to feature on Home. The list is
  /// stable for the lifetime of this controller so it does not reroll on every
  /// Flutter rebuild.
  List<ExerciseType> get homeRecommendations {
    return List.unmodifiable(_homeRecommendations);
  }

  List<ExerciseType> _pickHomeRecommendations() {
    final types = ExerciseType.values.toList()..shuffle(Random());
    return types.take(2).toList();
  }

  void selectTab(AppTab tab) {
    _tab = tab;
    notifyListeners();
  }

  void changeLocale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }

  /// Opens the Exercises tab on its catalogue (no session starts implicitly).
  void startPractice() {
    practice.returnToExercises();
    selectTab(AppTab.practice);
  }

  /// Opens the shared exercise setup for [type] with the standard catalogue
  /// defaults. Mirrors tapping the matching card on the Exercises tab; no
  /// interval overrides are applied here.
  void openExerciseSetup(ExerciseType type) {
    practice.configureExercise(type);
    selectTab(AppTab.practice);
  }

  /// Opens the Learn tab focused on [courseSpec]'s lesson view.
  void openCourse(CourseSpec courseSpec) {
    course.openCourse(courseSpec);
    selectTab(AppTab.learn);
  }

  /// Builds the drill for [courseSpec] and hands it to the practice engine.
  /// Marks the course as complete because reaching the drill means the learner
  /// walked through every lesson card.
  Future<void> startCourseDrill(CourseSpec courseSpec) async {
    final config = course.buildDrillConfig(courseSpec);
    await course.completeCourse(courseSpec);
    selectTab(AppTab.practice);
    await practice.startExercise(config);
  }

  /// Returns the best-fit course to open before starting exercise [type] and
  /// switches to the Learn tab positioned on that course.
  void openRecommendedCourseForExercise(ExerciseType type) {
    openCourse(course.recommendedCourseForExercise(type));
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
    course.dispose();
    super.dispose();
  }
}
