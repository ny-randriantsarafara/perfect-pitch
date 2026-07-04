import 'package:flutter/foundation.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course_progress.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';

/// Coordinates the Courses tab state and converts lessons into practice drills.
class CourseController extends ChangeNotifier {
  CourseController({required this.progressRepository});

  final CourseProgressRepository progressRepository;

  CourseProgressSnapshot progress = CourseProgressSnapshot.empty();
  CourseSpec? selectedCourse;
  int currentStepIndex = 0;

  Future<void> load() async {
    progress = await progressRepository.load();
    notifyListeners();
  }

  CourseSpec get recommendedCourse {
    return CourseCatalog.v1.firstWhere(
      (course) => !progress.isCompleted(course.id),
      orElse: () => CourseCatalog.v1.first,
    );
  }

  void openCourse(CourseSpec course) {
    selectedCourse = course;
    currentStepIndex = 0;
    notifyListeners();
  }

  void closeCourse() {
    selectedCourse = null;
    currentStepIndex = 0;
    notifyListeners();
  }

  void nextStep() {
    final course = selectedCourse;

    if (course == null || currentStepIndex >= course.steps.length - 1) {
      return;
    }

    currentStepIndex += 1;
    notifyListeners();
  }

  void previousStep() {
    if (currentStepIndex == 0) {
      return;
    }

    currentStepIndex -= 1;
    notifyListeners();
  }

  Future<void> completeCourse(CourseSpec course) async {
    progress = await progressRepository.completeCourse(course);
    notifyListeners();
  }

  Future<void> playStepDemo({
    required AudioEngine audioEngine,
    required CourseStepSpec step,
  }) async {
    final interval = step.demoInterval;
    final direction = step.demoDirection;

    if (interval == null || direction == null) {
      return;
    }

    await audioEngine.playInterval(
      IntervalPlayback(
        root: Pitch.middleC,
        interval: interval,
        direction: direction,
        instrument: Instrument.piano,
      ),
    );
  }

  ExerciseConfig buildDrillConfig(
    CourseSpec course, {
    ExerciseType? contextType,
  }) {
    switch (course.kind) {
      case CourseKind.foundation:
        return ExerciseConfig.defaults(
          ExerciseType.ascendingIntervals,
        ).copyWith(
          intervals: MusicInterval.upToStage(1),
          questionCount: 5,
          choiceCount: 3,
          clearReplayLimit: true,
        );
      case CourseKind.interval:
        return _buildIntervalDrillConfig(course, contextType: contextType);
      case CourseKind.exercise:
        return ExerciseConfig.defaults(course.primaryExerciseType).copyWith(
          intervals: MusicInterval.upToStage(course.stage),
          questionCount: 8,
          choiceCount: 4,
        );
      case CourseKind.strategy:
        return ExerciseConfig.defaults(
          ExerciseType.ascendingIntervals,
        ).copyWith(
          intervals: MusicInterval.upToStage(2),
          questionCount: 5,
          choiceCount: 3,
          clearReplayLimit: true,
        );
    }
  }

  ExerciseConfig _buildIntervalDrillConfig(
    CourseSpec course, {
    ExerciseType? contextType,
  }) {
    final target = course.intervals.first;
    final type = _intervalExerciseTypeFor(target, contextType);
    final intervals = _intervalChoicesFor(course, target);

    return ExerciseConfig.defaults(type).copyWith(
      intervals: intervals,
      questionCount: 5,
      choiceCount: intervals.length.clamp(2, 3).toInt(),
      clearReplayLimit: true,
    );
  }

  List<MusicInterval> _intervalChoicesFor(
    CourseSpec course,
    MusicInterval target,
  ) {
    final choices = <MusicInterval>{target};
    final candidates =
        MusicInterval.upToStage(
          course.stage,
        ).where((interval) => interval != target).toList()..sort((a, b) {
          final aDistance = (a.semitones - target.semitones).abs();
          final bDistance = (b.semitones - target.semitones).abs();
          final distanceComparison = aDistance.compareTo(bDistance);

          if (distanceComparison != 0) {
            return distanceComparison;
          }

          return a.semitones.compareTo(b.semitones);
        });

    choices.add(
      candidates.isEmpty ? _nearestInterval(target) : candidates.first,
    );

    return choices.toList()..sort((a, b) => a.semitones.compareTo(b.semitones));
  }

  ExerciseType _intervalExerciseTypeFor(
    MusicInterval target,
    ExerciseType? contextType,
  ) {
    final requested = contextType ?? ExerciseType.ascendingIntervals;

    if (target == MusicInterval.unison &&
        requested.defaultDirections.length == 1 &&
        requested.defaultDirections.contains(IntervalDirection.descending)) {
      return ExerciseType.ascendingIntervals;
    }

    return requested;
  }

  MusicInterval _nearestInterval(MusicInterval target) {
    return MusicInterval.values.where((interval) => interval != target).reduce((
      nearest,
      candidate,
    ) {
      final nearestDistance = (nearest.semitones - target.semitones).abs();
      final candidateDistance = (candidate.semitones - target.semitones).abs();

      if (candidateDistance < nearestDistance) {
        return candidate;
      }

      return nearest;
    });
  }
}
