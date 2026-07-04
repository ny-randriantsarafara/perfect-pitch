class CourseProgressSnapshot {
  const CourseProgressSnapshot({
    required this.completedIds,
    required this.lastSeenVersions,
  });

  factory CourseProgressSnapshot.empty() {
    return const CourseProgressSnapshot(completedIds: {}, lastSeenVersions: {});
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
