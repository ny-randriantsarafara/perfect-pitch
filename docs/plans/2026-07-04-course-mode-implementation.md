# Course Mode Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a first-class Learn tab with 21 localized interval micro-courses that can launch focused drills through the existing practice engine.

**Architecture:** Add typed course metadata and progress persistence under `lib/core/courses`, then add `CourseController` and Learn UI under `lib/features/courses`. `AppController` wires course drill actions into the existing `PracticeController`; no second exercise engine is created.

**Tech Stack:** Flutter, Dart, `ChangeNotifier`, generated Flutter l10n from ARB files, `shared_preferences`, `flutter_test`.

## Documentation and Artifact Disposition

- **Temporary artifacts:** `docs/plans/2026-07-04-course-mode-design.md`, `docs/plans/2026-07-04-course-mode-implementation.md`
- **Promote if validated:** Update `docs/product/functional-spec.md` with the Learn tab, 21-course v1 scope, local course completion, and ARB-localized course-copy decisions.
- **Delete if not durable:** Remove both course-mode plan files after implementation if their durable decisions have been promoted or are obvious from code/tests.

---

### Task 1: Add Course Model And Static V1 Catalogue

**Files:**
- Create: `lib/core/courses/course.dart`
- Create: `lib/core/courses/course_catalog.dart`
- Create: `test/core/courses/course_catalog_test.dart`

**Step 1: Write the failing catalogue tests**

Create `test/core/courses/course_catalog_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

void main() {
  group('CourseCatalog', () {
    test('contains the 21 v1 courses in stable order', () {
      expect(
        CourseCatalog.v1.map((course) => course.id),
        [
          'course_ear_training_basics',
          'course_interval_direction',
          'course_practice_strategy',
          'course_unison',
          'course_octave',
          'course_perfect_fifth',
          'course_minor_third',
          'course_major_third',
          'course_perfect_fourth',
          'course_minor_second',
          'course_major_second',
          'course_minor_sixth',
          'course_major_sixth',
          'course_minor_seventh',
          'course_major_seventh',
          'course_tritone',
          'course_ascending_intervals',
          'course_descending_intervals',
          'course_harmonic_intervals',
          'course_mixed_intervals',
          'course_mistake_review',
        ],
      );
    });

    test('does not include the deferred guitar course in v1', () {
      expect(
        CourseCatalog.v1.map((course) => course.id),
        isNot(contains('course_guitar_intervals')),
      );
    });

    test('all courses have valid metadata', () {
      for (final course in CourseCatalog.v1) {
        expect(course.id, startsWith('course_'));
        expect(course.version, greaterThan(0));
        expect(course.order, greaterThan(0));
        expect(course.estimatedSeconds, greaterThan(0));
        expect(course.steps, hasLength(3));
        expect(course.exerciseTypes, isNotEmpty);

        for (final type in course.exerciseTypes) {
          expect(ExerciseType.values, contains(type));
        }

        for (final interval in course.intervals) {
          expect(MusicInterval.values, contains(interval));
        }
      }
    });

    test('interval courses reference exactly one interval', () {
      final intervalCourses = CourseCatalog.v1.where(
        (course) => course.kind == CourseKind.interval,
      );

      expect(intervalCourses, hasLength(13));
      expect(intervalCourses.every((course) => course.intervals.length == 1), isTrue);
    });
  });
}
```

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/core/courses/course_catalog_test.dart
```

Expected: FAIL because `core/courses` files do not exist.

**Step 3: Add the model**

Create `lib/core/courses/course.dart`:

```dart
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

enum CourseKind { foundation, interval, exercise, strategy }

enum CourseStepType { concept, earClue, listenDemo, compareDemo, miniDrill }

class CourseSpec {
  const CourseSpec({
    required this.id,
    required this.version,
    required this.order,
    required this.kind,
    required this.stage,
    required this.exerciseTypes,
    required this.intervals,
    required this.estimatedSeconds,
    required this.steps,
  });

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
```

**Step 4: Add the static catalogue**

Create `lib/core/courses/course_catalog.dart` with a private helper and the 21 courses:

```dart
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
    _exerciseCourse(17, 'course_ascending_intervals', 2, ExerciseType.ascendingIntervals),
    _exerciseCourse(18, 'course_descending_intervals', 3, ExerciseType.descendingIntervals),
    _exerciseCourse(19, 'course_harmonic_intervals', 4, ExerciseType.harmonicIntervals),
    _exerciseCourse(20, 'course_mixed_intervals', 5, ExerciseType.mixedIntervals),
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

CourseSpec _exerciseCourse(
  int order,
  String id,
  int stage,
  ExerciseType type,
) {
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
```

**Step 5: Run the test to verify it passes**

Run:

```bash
flutter test test/core/courses/course_catalog_test.dart
```

Expected: PASS.

**Step 6: Commit**

```bash
git add lib/core/courses/course.dart lib/core/courses/course_catalog.dart test/core/courses/course_catalog_test.dart
git commit -m "feat(courses): add v1 course catalogue"
```

### Task 2: Add Course Progress Persistence

**Files:**
- Create: `lib/core/courses/course_progress.dart`
- Create: `lib/core/courses/course_progress_repository.dart`
- Create: `test/core/courses/course_progress_repository_test.dart`

**Step 1: Write repository tests**

Create `test/core/courses/course_progress_repository_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('InMemoryCourseProgressRepository', () {
    test('starts empty and records completion', () async {
      final repository = InMemoryCourseProgressRepository();
      final course = CourseCatalog.v1.first;

      expect((await repository.load()).isCompleted(course.id), isFalse);

      final progress = await repository.completeCourse(course);

      expect(progress.isCompleted(course.id), isTrue);
      expect(progress.lastSeenVersion(course.id), course.version);
    });
  });

  group('SharedPreferencesCourseProgressRepository', () {
    test('persists completed ids and versions', () async {
      SharedPreferences.setMockInitialValues({});
      final repository = SharedPreferencesCourseProgressRepository();
      final course = CourseCatalog.v1.first;

      await repository.completeCourse(course);

      final reloaded = await repository.load();
      expect(reloaded.isCompleted(course.id), isTrue);
      expect(reloaded.lastSeenVersion(course.id), course.version);
    });
  });
}
```

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/core/courses/course_progress_repository_test.dart
```

Expected: FAIL because progress classes do not exist.

**Step 3: Add progress snapshot**

Create `lib/core/courses/course_progress.dart`:

```dart
class CourseProgressSnapshot {
  const CourseProgressSnapshot({
    required this.completedIds,
    required this.lastSeenVersions,
  });

  factory CourseProgressSnapshot.empty() {
    return const CourseProgressSnapshot(
      completedIds: {},
      lastSeenVersions: {},
    );
  }

  final Set<String> completedIds;
  final Map<String, int> lastSeenVersions;

  bool isCompleted(String courseId) {
    return completedIds.contains(courseId);
  }

  int? lastSeenVersion(String courseId) {
    return lastSeenVersions[courseId];
  }
}
```

**Step 4: Add in-memory and shared-preferences repositories**

Create `lib/core/courses/course_progress_repository.dart`:

```dart
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CourseProgressRepository {
  Future<CourseProgressSnapshot> load();

  Future<CourseProgressSnapshot> completeCourse(CourseSpec course);
}

class InMemoryCourseProgressRepository implements CourseProgressRepository {
  final Set<String> _completedIds = {};
  final Map<String, int> _lastSeenVersions = {};

  @override
  Future<CourseProgressSnapshot> load() async {
    return _snapshot();
  }

  @override
  Future<CourseProgressSnapshot> completeCourse(CourseSpec course) async {
    _completedIds.add(course.id);
    _lastSeenVersions[course.id] = course.version;
    return _snapshot();
  }

  CourseProgressSnapshot _snapshot() {
    return CourseProgressSnapshot(
      completedIds: Set.unmodifiable(_completedIds),
      lastSeenVersions: Map.unmodifiable(_lastSeenVersions),
    );
  }
}

class SharedPreferencesCourseProgressRepository
    implements CourseProgressRepository {
  const SharedPreferencesCourseProgressRepository();

  static const _completedIdsKey = 'courses.completedIds';

  @override
  Future<CourseProgressSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    return _readSnapshot(preferences);
  }

  @override
  Future<CourseProgressSnapshot> completeCourse(CourseSpec course) async {
    final preferences = await SharedPreferences.getInstance();
    final completed = preferences.getStringList(_completedIdsKey) ?? <String>[];

    if (!completed.contains(course.id)) {
      completed.add(course.id);
      await preferences.setStringList(_completedIdsKey, completed);
    }

    await preferences.setInt(_versionKey(course.id), course.version);
    return _readSnapshot(preferences);
  }

  CourseProgressSnapshot _readSnapshot(SharedPreferences preferences) {
    final completed = preferences.getStringList(_completedIdsKey) ?? <String>[];
    final versions = <String, int>{};

    for (final id in completed) {
      final version = preferences.getInt(_versionKey(id));
      if (version != null) {
        versions[id] = version;
      }
    }

    return CourseProgressSnapshot(
      completedIds: Set.unmodifiable(completed),
      lastSeenVersions: Map.unmodifiable(versions),
    );
  }

  static String _versionKey(String courseId) {
    return 'courses.lastSeenVersion.$courseId';
  }
}
```

**Step 5: Run the test**

Run:

```bash
flutter test test/core/courses/course_progress_repository_test.dart
```

Expected: PASS.

**Step 6: Commit**

```bash
git add lib/core/courses/course_progress.dart lib/core/courses/course_progress_repository.dart test/core/courses/course_progress_repository_test.dart
git commit -m "feat(courses): persist course completion"
```

### Task 3: Add Course Controller And Drill Config Builder

**Files:**
- Create: `lib/features/courses/course_controller.dart`
- Create: `test/features/courses/course_controller_test.dart`
- Modify: `lib/core/courses/course.dart`

**Step 1: Write controller tests**

Create `test/features/courses/course_controller_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
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
}
```

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/features/courses/course_controller_test.dart
```

Expected: FAIL because `CourseController` does not exist.

**Step 3: Add `CourseController`**

Create `lib/features/courses/course_controller.dart`:

```dart
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

class CourseController extends ChangeNotifier {
  CourseController({
    required CourseProgressRepository progressRepository,
  }) : _progressRepository = progressRepository;

  final CourseProgressRepository _progressRepository;

  CourseProgressSnapshot _progress = CourseProgressSnapshot.empty();
  CourseSpec? _selectedCourse;
  int _currentStepIndex = 0;

  CourseProgressSnapshot get progress => _progress;
  CourseSpec? get selectedCourse => _selectedCourse;
  int get currentStepIndex => _currentStepIndex;

  CourseSpec get recommendedCourse {
    return CourseCatalog.v1.firstWhere(
      (course) => !_progress.isCompleted(course.id),
      orElse: () => CourseCatalog.v1.first,
    );
  }

  Future<void> load() async {
    _progress = await _progressRepository.load();
    notifyListeners();
  }

  void openCourse(CourseSpec course) {
    _selectedCourse = course;
    _currentStepIndex = 0;
    notifyListeners();
  }

  void closeCourse() {
    _selectedCourse = null;
    _currentStepIndex = 0;
    notifyListeners();
  }

  void nextStep() {
    final course = _selectedCourse;
    if (course == null || _currentStepIndex >= course.steps.length - 1) {
      return;
    }

    _currentStepIndex += 1;
    notifyListeners();
  }

  void previousStep() {
    if (_currentStepIndex == 0) {
      return;
    }

    _currentStepIndex -= 1;
    notifyListeners();
  }

  Future<void> completeCourse(CourseSpec course) async {
    _progress = await _progressRepository.completeCourse(course);
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
        return ExerciseConfig.defaults(ExerciseType.ascendingIntervals).copyWith(
          intervals: MusicInterval.upToStage(1),
          questionCount: 5,
          choiceCount: 3,
          clearReplayLimit: true,
        );
      case CourseKind.interval:
        final type = contextType ?? ExerciseType.ascendingIntervals;
        final target = course.intervals.first;
        final intervals = _intervalDrillPool(target, type);
        return ExerciseConfig.defaults(type).copyWith(
          intervals: intervals,
          questionCount: 5,
          choiceCount: intervals.length.clamp(2, 3).toInt(),
          clearReplayLimit: true,
        );
      case CourseKind.exercise:
        final type = course.primaryExerciseType;
        return ExerciseConfig.defaults(type).copyWith(
          intervals: MusicInterval.upToStage(course.stage),
          questionCount: type == ExerciseType.mixedIntervals ? 8 : 8,
          choiceCount: 4,
        );
      case CourseKind.strategy:
        return ExerciseConfig.defaults(ExerciseType.ascendingIntervals).copyWith(
          intervals: MusicInterval.upToStage(2),
          questionCount: 5,
          choiceCount: 3,
          clearReplayLimit: true,
        );
    }
  }

  List<MusicInterval> _intervalDrillPool(
    MusicInterval target,
    ExerciseType type,
  ) {
    final pool = <MusicInterval>[target];
    final nearest = _nearestInterval(target);

    if (nearest != null && nearest != target) {
      pool.add(nearest);
    }

    if (type == ExerciseType.descendingIntervals &&
        pool.length == 1 &&
        pool.single == MusicInterval.unison) {
      pool.add(MusicInterval.octave);
    }

    return pool;
  }

  MusicInterval? _nearestInterval(MusicInterval target) {
    final byDistance = MusicInterval.values.where((interval) => interval != target).toList()
      ..sort(
        (a, b) => (a.semitones - target.semitones)
            .abs()
            .compareTo((b.semitones - target.semitones).abs()),
      );

    return byDistance.isEmpty ? null : byDistance.first;
  }
}
```

**Step 4: Run the test**

Run:

```bash
flutter test test/features/courses/course_controller_test.dart
```

Expected: PASS after import fixes.

**Step 5: Commit**

```bash
git add lib/features/courses/course_controller.dart test/features/courses/course_controller_test.dart lib/core/courses/course.dart
git commit -m "feat(courses): add course controller"
```

### Task 4: Wire Course State Into AppController

**Files:**
- Modify: `lib/app/app_controller.dart`
- Modify: `lib/app/perfect_pitch_app.dart`
- Modify: `test/app/app_controller_test.dart`

**Step 1: Write app-controller tests**

Append to `test/app/app_controller_test.dart`:

```dart
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
});
```

Update imports in that test file:

```dart
import 'package:perfect_pitch/features/practice/practice_controller.dart';
```

Update `_controller()` to pass an in-memory course repository after the app
constructor supports it.

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/app/app_controller_test.dart
```

Expected: FAIL because `AppTab.learn`, `controller.course`, and app wiring do not exist.

**Step 3: Modify `AppController`**

In `lib/app/app_controller.dart`:

- Add import:

```dart
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
```

- Change enum:

```dart
enum AppTab { home, practice, learn, guitar, stats }
```

- Add constructor parameter and field:

```dart
    CourseProgressRepository? courseProgressRepository,
```

```dart
  late final CourseController course;
```

- Initialize in the constructor body:

```dart
    course = CourseController(
      progressRepository:
          courseProgressRepository ?? InMemoryCourseProgressRepository(),
    );
    unawaited(course.load());
```

- Add methods:

```dart
  void openCourse(CourseSpec courseSpec) {
    course.openCourse(courseSpec);
    selectTab(AppTab.learn);
  }

  Future<void> startCourseDrill(CourseSpec courseSpec) async {
    final config = course.buildDrillConfig(courseSpec);
    selectTab(AppTab.practice);
    await practice.startExercise(config);
  }
```

- Dispose:

```dart
    course.dispose();
```

**Step 4: Modify `PerfectPitchApp` for injectable course repository**

In `lib/app/perfect_pitch_app.dart`, add:

```dart
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
```

Add widget field:

```dart
  final CourseProgressRepository? courseProgressRepository;
```

Pass it to `AppController`.

**Step 5: Run the app-controller test**

Run:

```bash
flutter test test/app/app_controller_test.dart
```

Expected: PASS.

**Step 6: Commit**

```bash
git add lib/app/app_controller.dart lib/app/perfect_pitch_app.dart test/app/app_controller_test.dart
git commit -m "feat(courses): wire learn state into app controller"
```

### Task 5: Add Learn Navigation Shell

**Files:**
- Modify: `lib/app/app_navigation.dart`
- Modify: `lib/app/app_shell.dart`
- Create: `lib/features/courses/course_tab.dart`
- Modify: `test/widget_test.dart`

**Step 1: Write widget navigation test**

Append to `test/widget_test.dart`:

```dart
testWidgets('mobile bottom navigation opens learn tab', (tester) async {
  _setSurface(tester, const Size(500, 1000));

  await tester.pumpWidget(_buildApp());
  await tester.pump();

  await tester.tap(find.byIcon(Icons.school_rounded));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));

  expect(find.text('Learn'), findsWidgets);
  expect(find.text('How to train your ear'), findsOneWidget);
});
```

Update the existing `mobile bottom navigation switches tabs` test if icon
positions change. Prefer finding by icon rather than relying on tab order.

**Step 2: Run the widget test to verify it fails**

Run:

```bash
flutter test test/widget_test.dart
```

Expected: FAIL because the Learn nav item and tab do not exist.

**Step 3: Add a minimal `CourseTab`**

Create `lib/features/courses/course_tab.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

class CourseTab extends StatelessWidget {
  const CourseTab({
    required this.controller,
    required this.mode,
    required this.onStartDrill,
    super.key,
  });

  final CourseController controller;
  final LayoutMode mode;
  final Future<void> Function() onStartDrill;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final recommended = controller.recommendedCourse;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24,
            mode == LayoutMode.desktop ? 32 : 16,
            24,
            mode == LayoutMode.desktop ? 48 : 128,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.navLearn,
                style: TextStyle(
                  fontSize: mode == LayoutMode.desktop ? 48 : 30,
                  fontWeight: FontWeight.w800,
                  color: AppPalette.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.courseEarTrainingBasicsTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppPalette.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                recommended.id,
                style: TextStyle(color: AppPalette.whiteAlpha(0.55)),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

This is intentionally minimal. Task 7 replaces the raw ID with full course cards
and lessons.

**Step 4: Wire navigation**

In `lib/app/app_navigation.dart`:

- Add `AppTab.learn` to `_NavItem.label` with `l10n.navLearn`.
- Add `_NavItem(tab: AppTab.learn, icon: Icons.school_rounded)` to `_navItems`
  between Exercises and Guitar.
- Check mobile width. With five items, reduce `_MobileNavButton.width` from `62`
  to `56` if text clips at 500px wide.

In `lib/app/app_shell.dart`:

- Import `package:perfect_pitch/features/courses/course_tab.dart`.
- Add `AppTab.learn` to `_buildTabContent`:

```dart
    case AppTab.learn:
      child = CourseTab(
        controller: controller.course,
        mode: mode,
        onStartDrill: () => controller.startCourseDrill(
          controller.course.selectedCourse ?? controller.course.recommendedCourse,
        ),
      );
```

**Step 5: Add l10n key**

Add to all ARB files:

```json
"navLearn": "Learn"
```

Use localized values:

- `app_fr.arb`: `"Apprendre"`
- `app_es.arb`: `"Aprender"`
- `app_de.arb`: `"Lernen"`
- `app_it.arb`: `"Impara"`
- `app_pt.arb`: `"Aprender"`

Run:

```bash
flutter gen-l10n
```

Expected: generated localization files update.

**Step 6: Run widget test**

Run:

```bash
flutter test test/widget_test.dart
```

Expected: PASS.

**Step 7: Commit**

```bash
git add lib/app/app_navigation.dart lib/app/app_shell.dart lib/features/courses/course_tab.dart lib/l10n test/widget_test.dart
git commit -m "feat(courses): add learn navigation"
```

### Task 6: Add Course Localized Copy

**Files:**
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_fr.arb`
- Modify: `lib/l10n/app_es.arb`
- Modify: `lib/l10n/app_de.arb`
- Modify: `lib/l10n/app_it.arb`
- Modify: `lib/l10n/app_pt.arb`
- Create: `lib/core/courses/course_copy.dart`
- Create: `lib/core/courses/course_localizations.dart`
- Create: `test/core/courses/course_localizations_test.dart`

**Step 1: Write localization coverage test**

Create `test/core/courses/course_localizations_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course_localizations.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';

void main() {
  testWidgets('all v1 courses have copy in every supported locale', (tester) async {
    for (final locale in AppLocalizations.supportedLocales) {
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context);

              for (final course in CourseCatalog.v1) {
                final copy = course.localizedCopy(l10n);
                expect(copy.title.trim(), isNotEmpty);
                expect(copy.goal.trim(), isNotEmpty);
                expect(copy.cards, hasLength(course.steps.length));
                expect(copy.cards.every((card) => card.title.trim().isNotEmpty), isTrue);
                expect(copy.cards.every((card) => card.body.trim().isNotEmpty), isTrue);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    }
  });
}
```

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/core/courses/course_localizations_test.dart
```

Expected: FAIL because course copy helpers and ARB keys do not exist.

**Step 3: Add copy value objects**

Create `lib/core/courses/course_copy.dart`:

```dart
class CourseCopy {
  const CourseCopy({
    required this.title,
    required this.goal,
    required this.cards,
  });

  final String title;
  final String goal;
  final List<CourseCardCopy> cards;
}

class CourseCardCopy {
  const CourseCardCopy({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}
```

**Step 4: Add ARB course keys**

For each of the 21 v1 course IDs, add these keys to all six ARB files:

```text
<camelCourseId>Title
<camelCourseId>Goal
<camelCourseId>Card1Title
<camelCourseId>Card1Body
<camelCourseId>Card2Title
<camelCourseId>Card2Body
<camelCourseId>Card3Title
<camelCourseId>Card3Body
```

Example for `course_ear_training_basics` in `app_en.arb`:

```json
"courseEarTrainingBasicsTitle": "How to train your ear",
"courseEarTrainingBasicsGoal": "Learn the app routine before the first exercise.",
"courseEarTrainingBasicsCard1Title": "Concept",
"courseEarTrainingBasicsCard1Body": "An interval is the distance between two notes. In this app, your job is to name that distance by ear.",
"courseEarTrainingBasicsCard2Title": "Ear clue",
"courseEarTrainingBasicsCard2Body": "Do not hunt for the note names. Listen for size, color, and stability: small/large, tense/calm, dark/bright.",
"courseEarTrainingBasicsCard3Title": "Mini drill",
"courseEarTrainingBasicsCard3Body": "Play the example, pause, then say whether it feels same, close, open, or far before choosing an answer."
```

Populate values from `/Users/nrandriantsarafara/Downloads/course-content-v1.json`.
Do not add `course_guitar_intervals` keys unless needed for later scope.

After editing ARB files, run:

```bash
flutter gen-l10n
```

**Step 5: Add localization resolver**

Create `lib/core/courses/course_localizations.dart`:

```dart
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_copy.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';

extension CourseLocalizations on CourseSpec {
  CourseCopy localizedCopy(AppLocalizations l10n) {
    switch (id) {
      case 'course_ear_training_basics':
        return CourseCopy(
          title: l10n.courseEarTrainingBasicsTitle,
          goal: l10n.courseEarTrainingBasicsGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseEarTrainingBasicsCard1Title,
              body: l10n.courseEarTrainingBasicsCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseEarTrainingBasicsCard2Title,
              body: l10n.courseEarTrainingBasicsCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseEarTrainingBasicsCard3Title,
              body: l10n.courseEarTrainingBasicsCard3Body,
            ),
          ],
        );
      // Add the same mapping for the remaining 20 v1 course IDs.
      default:
        throw ArgumentError.value(id, 'id', 'Unknown course id');
    }
  }
}
```

Use the same structure for all 21 courses. Keep this explicit switch for compile-time
coverage from generated l10n getters.

**Step 6: Run localization tests**

Run:

```bash
flutter test test/core/courses/course_localizations_test.dart
```

Expected: PASS.

**Step 7: Commit**

```bash
git add lib/core/courses/course_copy.dart lib/core/courses/course_localizations.dart lib/l10n test/core/courses/course_localizations_test.dart
git commit -m "feat(courses): add localized course copy"
```

### Task 7: Build Learn Course List And Lesson View

**Files:**
- Modify: `lib/features/courses/course_tab.dart`
- Create: `lib/features/courses/course_lesson_view.dart`
- Create: `test/features/courses/course_tab_test.dart`

**Step 1: Write widget tests**

Create `test/features/courses/course_tab_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/features/courses/course_tab.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

Widget _build(CourseController controller, {Future<void> Function()? onStartDrill}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: CourseTab(
      controller: controller,
      mode: LayoutMode.mobile,
      onStartDrill: onStartDrill ?? () async {},
    ),
  );
}

void main() {
  testWidgets('shows recommended course and opens lesson', (tester) async {
    final controller = CourseController(
      progressRepository: InMemoryCourseProgressRepository(),
    );
    addTearDown(controller.dispose);
    await controller.load();

    await tester.pumpWidget(_build(controller));
    await tester.pump();

    expect(find.text('How to train your ear'), findsOneWidget);

    await tester.tap(find.text('How to train your ear'));
    await tester.pump();

    expect(find.text('Concept'), findsOneWidget);
    expect(find.textContaining('An interval is the distance'), findsOneWidget);
  });

  testWidgets('lesson next and start drill actions work', (tester) async {
    final controller = CourseController(
      progressRepository: InMemoryCourseProgressRepository(),
    );
    var started = false;
    addTearDown(controller.dispose);
    await controller.load();
    controller.openCourse(controller.recommendedCourse);

    await tester.pumpWidget(_build(controller, onStartDrill: () async => started = true));
    await tester.pump();

    await tester.tap(find.text('Next'));
    await tester.pump();
    expect(find.text('Ear clue'), findsOneWidget);

    await tester.tap(find.text('Start drill'));
    await tester.pump();
    expect(started, isTrue);
  });
}
```

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/features/courses/course_tab_test.dart
```

Expected: FAIL because the current placeholder tab has no cards or lesson view.

**Step 3: Implement course list**

In `lib/features/courses/course_tab.dart`:

- Import `course_catalog.dart`, `course_localizations.dart`, `pressable.dart`, and `glass_panel.dart`.
- If `controller.selectedCourse == null`, render:
  - title `l10n.navLearn`;
  - recommended course section;
  - list of `CourseCatalog.v1`;
  - each card calls `controller.openCourse(course)`.
- Use `controller.progress.isCompleted(course.id)` to show a check icon.

Keep card text sizes compact enough for mobile. Do not put cards inside other
cards.

**Step 4: Implement lesson view**

Create `lib/features/courses/course_lesson_view.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_localizations.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/glass_panel.dart';
import 'package:perfect_pitch/ui/pressable.dart';

class CourseLessonView extends StatelessWidget {
  const CourseLessonView({
    required this.course,
    required this.controller,
    required this.onBack,
    required this.onStartDrill,
    super.key,
  });

  final CourseSpec course;
  final CourseController controller;
  final VoidCallback onBack;
  final Future<void> Function() onStartDrill;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final copy = course.localizedCopy(l10n);
    final card = copy.cards[controller.currentStepIndex];
    final isLast = controller.currentStepIndex == copy.cards.length - 1;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 128),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Pressable(
            onTap: onBack,
            child: const Icon(Icons.arrow_back_rounded, color: AppPalette.white),
          ),
          const SizedBox(height: 24),
          Text(
            copy.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 16),
          GlassPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppPalette.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  card.body,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: AppPalette.whiteAlpha(0.72),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (controller.currentStepIndex > 0)
                TextButton(
                  onPressed: controller.previousStep,
                  child: const Text('Previous'),
                ),
              const Spacer(),
              FilledButton(
                onPressed: isLast ? onStartDrill : controller.nextStep,
                child: Text(isLast ? 'Start drill' : 'Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

Replace hardcoded `Previous`, `Next`, and `Start drill` with ARB keys before
finishing this task.

**Step 5: Add action l10n keys**

Add to all ARB files:

```json
"coursePrevious": "Previous",
"courseNext": "Next",
"courseStartDrill": "Start drill",
"courseRecommended": "Recommended",
"courseCompleted": "Completed"
```

Localize the values in FR/ES/DE/IT/PT, then run:

```bash
flutter gen-l10n
```

**Step 6: Run widget tests**

Run:

```bash
flutter test test/features/courses/course_tab_test.dart test/widget_test.dart
```

Expected: PASS.

**Step 7: Commit**

```bash
git add lib/features/courses/course_tab.dart lib/features/courses/course_lesson_view.dart lib/l10n test/features/courses/course_tab_test.dart test/widget_test.dart
git commit -m "feat(courses): build learn course flow"
```

### Task 8: Add Exercise Catalogue Learn Chips

**Files:**
- Modify: `lib/features/practice/practice_tab.dart`
- Modify: `lib/app/app_shell.dart`
- Modify: `test/features/practice/practice_tab_test.dart`

**Step 1: Write widget test**

Add a test to `test/features/practice/practice_tab_test.dart` that pumps
`PracticeTab` with an `onOpenCourse` callback if the widget signature changes:

```dart
testWidgets('catalogue cards expose learn action', (tester) async {
  final controller = _buildController();
  var opened = false;

  await tester.pumpWidget(
    _buildPracticeTab(
      controller: controller,
      onOpenCourse: (_) => opened = true,
    ),
  );

  await tester.tap(find.text('Learn first').first);
  await tester.pump();

  expect(opened, isTrue);
});
```

Use the existing helper names in `practice_tab_test.dart`; if no helper exists,
create a small `MaterialApp` wrapper with `AppLocalizations.localizationsDelegates`.

**Step 2: Run the test to verify it fails**

Run:

```bash
flutter test test/features/practice/practice_tab_test.dart
```

Expected: FAIL because the chip does not exist.

**Step 3: Add optional course callback**

Modify `PracticeTab` constructor in `lib/features/practice/practice_tab.dart`:

```dart
  final void Function(ExerciseType type)? onOpenCourse;
```

Pass it through `_CatalogueView` and `_CatalogueCard`.

**Step 4: Render the chip**

In `_CatalogueCard`, add a compact secondary action:

```dart
TextButton.icon(
  onPressed: onOpenCourse == null ? null : () => onOpenCourse!(type),
  icon: const Icon(Icons.school_rounded, size: 16),
  label: Text(l10n.courseLearnFirst),
)
```

Add ARB key in all locales:

```json
"courseLearnFirst": "Learn first"
```

Run:

```bash
flutter gen-l10n
```

**Step 5: Wire callback from shell**

In `lib/app/app_shell.dart`, pass:

```dart
onOpenCourse: controller.openRecommendedCourseForExercise,
```

Add this method to `AppController`:

```dart
void openRecommendedCourseForExercise(ExerciseType type) {
  final courseSpec = course.recommendedCourseForExercise(type);
  openCourse(courseSpec);
}
```

Add `recommendedCourseForExercise` to `CourseController`:

```dart
CourseSpec recommendedCourseForExercise(ExerciseType type) {
  return CourseCatalog.v1.firstWhere(
    (course) =>
        course.exerciseTypes.contains(type) && !_progress.isCompleted(course.id),
    orElse: () => CourseCatalog.v1.firstWhere(
      (course) => course.exerciseTypes.contains(type),
      orElse: () => recommendedCourse,
    ),
  );
}
```

**Step 6: Run tests**

Run:

```bash
flutter test test/features/practice/practice_tab_test.dart test/app/app_controller_test.dart
```

Expected: PASS.

**Step 7: Commit**

```bash
git add lib/features/practice/practice_tab.dart lib/app/app_shell.dart lib/app/app_controller.dart lib/features/courses/course_controller.dart lib/l10n test/features/practice/practice_tab_test.dart test/app/app_controller_test.dart
git commit -m "feat(courses): link exercises to learn content"
```

### Task 9: Final Validation And Product Documentation

**Files:**
- Modify: `docs/product/functional-spec.md`
- Optional Delete: `docs/plans/2026-07-04-course-mode-design.md`
- Optional Delete: `docs/plans/2026-07-04-course-mode-implementation.md`

**Step 1: Update product documentation**

Add a concise Learn section to `docs/product/functional-spec.md`:

```markdown
## Learn

The Learn area contains short micro-courses that teach interval listening
concepts before launching focused drills. V1 includes 21 course lessons for
foundations, interval recognition, exercise directions, and mistake review.
Guitar-specific lessons are deferred.

Course completion is stored locally and is separate from interval mastery.
Course drills reuse the same `ExerciseConfig` and practice session engine as
the Exercises tab.
```

**Step 2: Run full validation**

Run:

```bash
flutter analyze
flutter test
```

Expected: both commands pass.

**Step 3: Build web smoke check**

Run:

```bash
flutter build web --release
```

Expected: build succeeds.

**Step 4: Decide plan-file disposition**

If `docs/product/functional-spec.md` now captures the durable decisions and the
implementation is complete, delete:

```bash
git rm docs/plans/2026-07-04-course-mode-design.md docs/plans/2026-07-04-course-mode-implementation.md
```

If the team still wants the detailed task history, keep both plan files.

**Step 5: Commit final docs/cleanup**

```bash
git add docs/product/functional-spec.md docs/plans
git commit -m "docs: document learn course mode"
```

If plan files were deleted, use:

```bash
git add docs/product/functional-spec.md
git commit -m "docs: document learn course mode"
```

**Step 6: Final verification before handoff**

Run:

```bash
git status --short
flutter analyze
flutter test
```

Expected:

- `git status --short` is clean;
- analyzer passes;
- tests pass.
