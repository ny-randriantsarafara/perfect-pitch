import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

enum CourseKind { foundation, interval, exercise, strategy }

enum CourseStepType { concept, earClue, listenDemo, compareDemo, miniDrill }

class CourseSpec {
  CourseSpec({
    required this.id,
    required this.version,
    required this.order,
    required this.kind,
    required this.stage,
    required Set<ExerciseType> exerciseTypes,
    required Set<MusicInterval> intervals,
    required this.estimatedSeconds,
    required List<CourseStepSpec> steps,
  }) : exerciseTypes = Set.unmodifiable(exerciseTypes),
       intervals = Set.unmodifiable(intervals),
       steps = List.unmodifiable(steps);

  final String id;
  final int version;
  final int order;
  final CourseKind kind;
  final int stage;
  final Set<ExerciseType> exerciseTypes;
  final Set<MusicInterval> intervals;
  final int estimatedSeconds;
  final List<CourseStepSpec> steps;

  ExerciseType get primaryExerciseType {
    return exerciseTypes.first;
  }
}

class CourseStepSpec {
  const CourseStepSpec({
    required this.id,
    required this.type,
    this.demoInterval,
    this.demoDirection,
  });

  final String id;
  final CourseStepType type;
  final MusicInterval? demoInterval;
  final IntervalDirection? demoDirection;
}
