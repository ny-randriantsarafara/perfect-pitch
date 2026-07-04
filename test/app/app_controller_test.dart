import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';

AppController _controller() {
  return AppController(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    progressRepository: InMemoryIntervalProgressRepository(),
    courseProgressRepository: InMemoryCourseProgressRepository(),
  );
}

void main() {
  test('home recommendations are existing catalogue exercise types', () {
    final controller = _controller();
    addTearDown(controller.dispose);

    expect(controller.homeRecommendations, hasLength(2));
    expect(
      controller.homeRecommendations.every(ExerciseType.values.contains),
      isTrue,
    );
  });

  test('opening a home recommendation keeps the normal exercise defaults', () {
    final controller = _controller();
    addTearDown(controller.dispose);

    final type = controller.homeRecommendations.first;
    controller.openExerciseSetup(type);

    expect(controller.tab, AppTab.practice);
    expect(controller.practice.draftConfig, isNotNull);
    expect(controller.practice.draftConfig!.type, type);
    expect(
      controller.practice.draftConfig!.intervals,
      ExerciseConfig.defaults(type).intervals,
    );
    expect(controller.practice.draftConfig!.intervals.length, greaterThan(1));
  });

  test('owns course controller and opens a course drill in practice', () async {
    final controller = _controller();
    addTearDown(controller.dispose);
    await controller.course.load();

    final course = controller.course.recommendedCourse;
    controller.openCourse(course);

    expect(controller.tab, AppTab.learn);
    expect(controller.course.selectedCourse, course);

    await controller.startCourseDrill(course);

    expect(controller.tab, AppTab.practice);
    expect(controller.practice.stage, PracticeStage.active);
    expect(controller.practice.config, isNotNull);
    expect(controller.course.progress.isCompleted(course.id), isTrue);
    // Starting a drill must close the lesson so the Learn tab reopens on the
    // course list, letting the learner pick a different course afterwards.
    expect(controller.course.selectedCourse, isNull);
  });

  test(
    'opens the recommended course targeting an exercise type',
    () async {
      final controller = _controller();
      addTearDown(controller.dispose);
      await controller.course.load();

      controller.openRecommendedCourseForExercise(
        ExerciseType.descendingIntervals,
      );

      expect(controller.tab, AppTab.learn);
      expect(controller.course.selectedCourse, isNotNull);
      expect(
        controller.course.selectedCourse!.exerciseTypes,
        contains(ExerciseType.descendingIntervals),
      );
    },
  );
}
