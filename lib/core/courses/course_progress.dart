class CourseProgressSnapshot {
  CourseProgressSnapshot({
    required Set<String> completedIds,
    required Map<String, int> lastSeenVersions,
  }) : completedIds = Set.unmodifiable(completedIds),
       lastSeenVersions = Map.unmodifiable(lastSeenVersions);

  factory CourseProgressSnapshot.empty() {
    return CourseProgressSnapshot(completedIds: {}, lastSeenVersions: {});
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
