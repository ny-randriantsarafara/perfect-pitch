import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course_localizations.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/features/courses/course_lesson_view.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/glass_panel.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';
import 'package:perfect_pitch/ui/pressable.dart';

/// The Learn tab. When no course is selected, shows the recommended course and
/// the full V1 catalogue. When a course is selected, hosts [CourseLessonView].
class CourseTab extends StatelessWidget {
  const CourseTab({
    required this.controller,
    required this.audioEngine,
    required this.mode,
    required this.onStartDrill,
    super.key,
  });

  final CourseController controller;
  final AudioEngine audioEngine;
  final LayoutMode mode;
  final Future<void> Function(CourseSpec course) onStartDrill;

  bool get _isDesktop {
    return mode == LayoutMode.desktop;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final selected = controller.selectedCourse;

        if (selected != null) {
          return CourseLessonView(
            course: selected,
            controller: controller,
            audioEngine: audioEngine,
            isDesktop: _isDesktop,
            onBack: controller.closeCourse,
            onStartDrill: () => onStartDrill(selected),
          );
        }

        return _CourseListView(controller: controller, isDesktop: _isDesktop);
      },
    );
  }
}

class _CourseListView extends StatelessWidget {
  const _CourseListView({required this.controller, required this.isDesktop});

  final CourseController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recommended = controller.recommendedCourse;
    final catalog = CourseCatalog.v1;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        isDesktop ? 32 : 16,
        24,
        isDesktop ? 48 : 128,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.learnTabTitle,
            style: TextStyle(
              fontSize: isDesktop ? 48 : 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.learnTabSubtitle,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 14,
              fontWeight: FontWeight.w500,
              color: AppPalette.violet200.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: isDesktop ? 32 : 20),
          _CourseCard(
            course: recommended,
            highlighted: true,
            completed: controller.progress.isCompleted(recommended.id),
            onTap: () => controller.openCourse(recommended),
          ),
          const SizedBox(height: 24),
          for (final course in catalog) ...[
            if (course.id != recommended.id) ...[
              _CourseCard(
                course: course,
                highlighted: false,
                completed: controller.progress.isCompleted(course.id),
                onTap: () => controller.openCourse(course),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.highlighted,
    required this.completed,
    required this.onTap,
  });

  final CourseSpec course;
  final bool highlighted;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final copy = course.localizedCopy(l10n);
    final estimateMinutes = (course.estimatedSeconds / 60).ceil();

    return Pressable(
      onTap: onTap,
      pressedScale: 0.99,
      child: GlassPanel(
        fillAlpha: highlighted ? 0.06 : 0.03,
        borderAlpha: highlighted ? 0.15 : 0.08,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (highlighted)
                  _MetaChip(
                    label: l10n.courseRecommended,
                    color: AppPalette.violet400,
                  ),
                if (highlighted) const SizedBox(width: 8),
                _MetaChip(
                  label: l10n.courseEstimatedMinutes(estimateMinutes),
                  color: AppPalette.whiteAlpha(0.6),
                ),
                const Spacer(),
                if (completed)
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 20,
                    color: AppPalette.green400,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              copy.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppPalette.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              copy.goal,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AppPalette.whiteAlpha(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: color,
        ),
      ),
    );
  }
}
