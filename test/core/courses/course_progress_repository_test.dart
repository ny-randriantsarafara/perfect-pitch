import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course_progress.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CourseProgressSnapshot', () {
    test('defensively copies mutable source collections', () {
      final completedIds = {'course_a'};
      final versions = {'course_a': 1};
      final snapshot = CourseProgressSnapshot(
        completedIds: completedIds,
        lastSeenVersions: versions,
      );

      completedIds.add('course_b');
      versions['course_a'] = 2;
      versions['course_b'] = 1;

      expect(snapshot.isCompleted('course_a'), isTrue);
      expect(snapshot.isCompleted('course_b'), isFalse);
      expect(snapshot.lastSeenVersion('course_a'), 1);
      expect(snapshot.lastSeenVersion('course_b'), isNull);
    });

    test('exposes immutable collections', () {
      final snapshot = CourseProgressSnapshot(
        completedIds: {'course_a'},
        lastSeenVersions: {'course_a': 1},
      );

      expect(
        () => snapshot.completedIds.add('course_b'),
        throwsUnsupportedError,
      );
      expect(
        () => snapshot.lastSeenVersions['course_b'] = 2,
        throwsUnsupportedError,
      );
    });
  });

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

      final preferences = await SharedPreferences.getInstance();
      final reloaded = await repository.load();

      expect(reloaded.isCompleted(course.id), isTrue);
      expect(reloaded.lastSeenVersion(course.id), course.version);
      expect(preferences.getStringList('courses.completedIds'), [course.id]);
      expect(
        preferences.getInt('courses.lastSeenVersion.${course.id}'),
        course.version,
      );
    });
  });
}
