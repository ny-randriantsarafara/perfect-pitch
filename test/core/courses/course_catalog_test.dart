import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

void main() {
  group('CourseCatalog', () {
    test('contains the 21 v1 courses in stable order', () {
      expect(CourseCatalog.v1.map((course) => course.id), [
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
      ]);
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
      expect(
        intervalCourses.every((course) => course.intervals.length == 1),
        isTrue,
      );
    });

    test('nested catalogue collections are immutable', () {
      final course = CourseCatalog.v1.firstWhere(
        (course) => course.kind == CourseKind.interval,
      );

      expect(
        () => course.steps.add(
          const CourseStepSpec(id: 'mutation', type: CourseStepType.concept),
        ),
        throwsUnsupportedError,
      );
      expect(() => course.intervals.clear(), throwsUnsupportedError);
      expect(() => course.exerciseTypes.clear(), throwsUnsupportedError);
    });
  });
}
