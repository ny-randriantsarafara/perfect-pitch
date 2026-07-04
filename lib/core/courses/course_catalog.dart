import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

class CourseCatalog {
  const CourseCatalog._();

  static final v1 = List<CourseSpec>.unmodifiable([
    CourseSpec(
      id: 'course_ear_training_basics',
      version: 1,
      order: 1,
      kind: CourseKind.foundation,
      stage: 0,
      exerciseTypes: {ExerciseType.ascendingIntervals},
      intervals: {},
      estimatedSeconds: 90,
      steps: _foundationSteps('course_ear_training_basics'),
    ),
    CourseSpec(
      id: 'course_interval_direction',
      version: 1,
      order: 2,
      kind: CourseKind.foundation,
      stage: 0,
      exerciseTypes: _allExerciseTypes,
      intervals: {},
      estimatedSeconds: 90,
      steps: _foundationSteps('course_interval_direction'),
    ),
    CourseSpec(
      id: 'course_practice_strategy',
      version: 1,
      order: 3,
      kind: CourseKind.foundation,
      stage: 0,
      exerciseTypes: _allExerciseTypes,
      intervals: {},
      estimatedSeconds: 90,
      steps: _foundationSteps('course_practice_strategy'),
    ),
    _intervalCourse(4, 'course_unison', 1, MusicInterval.unison),
    _intervalCourse(5, 'course_octave', 1, MusicInterval.octave),
    _intervalCourse(6, 'course_perfect_fifth', 2, MusicInterval.perfectFifth),
    _intervalCourse(7, 'course_minor_third', 3, MusicInterval.minorThird),
    _intervalCourse(8, 'course_major_third', 3, MusicInterval.majorThird),
    _intervalCourse(9, 'course_perfect_fourth', 4, MusicInterval.perfectFourth),
    _intervalCourse(10, 'course_minor_second', 5, MusicInterval.minorSecond),
    _intervalCourse(11, 'course_major_second', 5, MusicInterval.majorSecond),
    _intervalCourse(12, 'course_minor_sixth', 6, MusicInterval.minorSixth),
    _intervalCourse(13, 'course_major_sixth', 6, MusicInterval.majorSixth),
    _intervalCourse(14, 'course_minor_seventh', 7, MusicInterval.minorSeventh),
    _intervalCourse(15, 'course_major_seventh', 7, MusicInterval.majorSeventh),
    _intervalCourse(16, 'course_tritone', 8, MusicInterval.tritone),
    _exerciseCourse(
      17,
      'course_ascending_intervals',
      2,
      ExerciseType.ascendingIntervals,
    ),
    _exerciseCourse(
      18,
      'course_descending_intervals',
      3,
      ExerciseType.descendingIntervals,
    ),
    _exerciseCourse(
      19,
      'course_harmonic_intervals',
      4,
      ExerciseType.harmonicIntervals,
    ),
    _exerciseCourse(
      20,
      'course_mixed_intervals',
      5,
      ExerciseType.mixedIntervals,
    ),
    CourseSpec(
      id: 'course_mistake_review',
      version: 1,
      order: 21,
      kind: CourseKind.strategy,
      stage: 2,
      exerciseTypes: _allExerciseTypes,
      intervals: {},
      estimatedSeconds: 90,
      steps: _foundationSteps('course_mistake_review'),
    ),
  ]);
}

const _allExerciseTypes = {
  ExerciseType.ascendingIntervals,
  ExerciseType.descendingIntervals,
  ExerciseType.harmonicIntervals,
  ExerciseType.mixedIntervals,
};

CourseSpec _intervalCourse(
  int order,
  String id,
  int stage,
  MusicInterval interval,
) {
  return CourseSpec(
    id: id,
    version: 1,
    order: order,
    kind: CourseKind.interval,
    stage: stage,
    exerciseTypes: _allExerciseTypes,
    intervals: {interval},
    estimatedSeconds: 75,
    steps: [
      CourseStepSpec(
        id: '${id}_card1',
        type: CourseStepType.concept,
        demoInterval: interval,
        demoDirection: IntervalDirection.ascending,
      ),
      CourseStepSpec(
        id: '${id}_card2',
        type: CourseStepType.compareDemo,
        demoInterval: interval,
        demoDirection: IntervalDirection.harmonic,
      ),
      CourseStepSpec(
        id: '${id}_card3',
        type: CourseStepType.miniDrill,
        demoInterval: interval,
        demoDirection: IntervalDirection.ascending,
      ),
    ],
  );
}

CourseSpec _exerciseCourse(int order, String id, int stage, ExerciseType type) {
  return CourseSpec(
    id: id,
    version: 1,
    order: order,
    kind: CourseKind.exercise,
    stage: stage,
    exerciseTypes: {type},
    intervals: {},
    estimatedSeconds: 75,
    steps: _foundationSteps(id),
  );
}

List<CourseStepSpec> _foundationSteps(String id) {
  return [
    CourseStepSpec(id: '${id}_card1', type: CourseStepType.concept),
    CourseStepSpec(id: '${id}_card2', type: CourseStepType.earClue),
    CourseStepSpec(id: '${id}_card3', type: CourseStepType.miniDrill),
  ];
}
