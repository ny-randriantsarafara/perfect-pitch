/// Localized copy shown for a single course lesson.
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
  const CourseCardCopy({required this.title, required this.body});

  final String title;
  final String body;
}
