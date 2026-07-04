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
