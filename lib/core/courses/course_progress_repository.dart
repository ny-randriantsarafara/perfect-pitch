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
