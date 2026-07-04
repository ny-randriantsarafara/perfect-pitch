import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';

void main() {
  CourseController controller() {
    return CourseController(
      progressRepository: InMemoryCourseProgressRepository(),
    );
  }

  test('starts with the first course recommended', () async {
    final subject = controller();
    addTearDown(subject.dispose);

    await subject.load();

    expect(subject.recommendedCourse.id, 'course_ear_training_basics');
    expect(subject.selectedCourse, isNull);
  });

  test('opens a course and navigates lesson cards', () async {
    final subject = controller();
    addTearDown(subject.dispose);
    await subject.load();

    subject.openCourse(CourseCatalog.v1.first);
    expect(subject.selectedCourse, CourseCatalog.v1.first);
    expect(subject.currentStepIndex, 0);

    subject.nextStep();
    expect(subject.currentStepIndex, 1);

    subject.previousStep();
    expect(subject.currentStepIndex, 0);
  });

  test('keeps navigation in range and closes a course', () async {
    final subject = controller();
    addTearDown(subject.dispose);
    await subject.load();

    subject.openCourse(CourseCatalog.v1.first);
    subject.previousStep();
    expect(subject.currentStepIndex, 0);

    for (var index = 0; index < 10; index += 1) {
      subject.nextStep();
    }

    expect(subject.currentStepIndex, CourseCatalog.v1.first.steps.length - 1);

    subject.closeCourse();
    expect(subject.selectedCourse, isNull);
    expect(subject.currentStepIndex, 0);
  });

  test('completion persists and advances recommendation', () async {
    final subject = controller();
    addTearDown(subject.dispose);
    await subject.load();

    await subject.completeCourse(CourseCatalog.v1.first);

    expect(subject.progress.isCompleted('course_ear_training_basics'), isTrue);
    expect(subject.recommendedCourse.id, 'course_interval_direction');
  });

  test('builds foundation drill config', () {
    final subject = controller();
    final config = subject.buildDrillConfig(CourseCatalog.v1.first);

    expect(config.type, ExerciseType.ascendingIntervals);
    expect(config.intervals, MusicInterval.upToStage(1));
    expect(config.questionCount, 5);
    expect(config.allowsUnlimitedReplays, isTrue);
  });

  test('builds interval drill config with the target interval', () {
    final subject = controller();
    final course = CourseCatalog.v1.firstWhere(
      (course) => course.id == 'course_perfect_fifth',
    );

    final config = subject.buildDrillConfig(
      course,
      contextType: ExerciseType.ascendingIntervals,
    );

    expect(config.type, ExerciseType.ascendingIntervals);
    expect(config.intervals, contains(MusicInterval.perfectFifth));
    expect(config.questionCount, 5);
    expect(config.choiceCount, 3);
    expect(config.allowsUnlimitedReplays, isTrue);
  });

  test('plays step demo only when interval and direction exist', () async {
    final subject = controller();
    final player = _RecordingAudioPlayer();
    final audioEngine = AudioEngine(player: player);

    await subject.playStepDemo(
      audioEngine: audioEngine,
      step: CourseCatalog.v1.first.steps.first,
    );
    expect(player.playedTones, 0);
    expect(player.playedChords, 0);

    await subject.playStepDemo(
      audioEngine: audioEngine,
      step: const CourseStepSpec(
        id: 'demo',
        type: CourseStepType.listenDemo,
        demoInterval: MusicInterval.perfectFifth,
        demoDirection: IntervalDirection.harmonic,
      ),
    );

    expect(player.playedTones, 0);
    expect(player.playedChords, 1);
  });
}

class _RecordingAudioPlayer implements AudioPlayer {
  int playedTones = 0;
  int playedChords = 0;

  @override
  Future<void> playChord(List<ToneRequest> requests) async {
    playedChords += 1;
  }

  @override
  Future<void> playTone(ToneRequest request) async {
    playedTones += 1;
  }
}
