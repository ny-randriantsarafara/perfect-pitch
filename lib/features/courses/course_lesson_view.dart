import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_localizations.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/glass_panel.dart';
import 'package:perfect_pitch/ui/pressable.dart';

/// Card-by-card lesson viewer with optional demo playback and a final "start
/// drill" call to action that hands off to [PracticeController].
class CourseLessonView extends StatelessWidget {
  const CourseLessonView({
    required this.course,
    required this.controller,
    required this.audioEngine,
    required this.isDesktop,
    required this.onBack,
    required this.onStartDrill,
    super.key,
  });

  final CourseSpec course;
  final CourseController controller;
  final AudioEngine audioEngine;
  final bool isDesktop;
  final VoidCallback onBack;
  final Future<void> Function() onStartDrill;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final copy = course.localizedCopy(l10n);
    final step = course.steps[controller.currentStepIndex];
    final card = copy.cards[controller.currentStepIndex];
    final total = copy.cards.length;
    final isLast = controller.currentStepIndex == total - 1;
    final canPlayDemo = step.demoInterval != null && step.demoDirection != null;

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
          Pressable(
            onTap: onBack,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppPalette.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            copy.title,
            style: TextStyle(
              fontSize: isDesktop ? 40 : 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            copy.goal,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: AppPalette.whiteAlpha(0.6),
            ),
          ),
          const SizedBox(height: 20),
          _StepIndicator(
            total: total,
            currentIndex: controller.currentStepIndex,
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
                    height: 1.45,
                    color: AppPalette.whiteAlpha(0.75),
                  ),
                ),
                if (canPlayDemo) ...[
                  const SizedBox(height: 16),
                  _DemoButton(
                    label: l10n.coursePlayDemo,
                    onTap: () => controller.playStepDemo(
                      audioEngine: audioEngine,
                      step: step,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (controller.currentStepIndex > 0)
                _SecondaryButton(
                  label: l10n.coursePrevious,
                  onTap: controller.previousStep,
                )
              else
                const SizedBox.shrink(),
              const Spacer(),
              _PrimaryButton(
                label: isLast ? l10n.courseStartDrill : l10n.courseNext,
                onTap: isLast ? onStartDrill : () async => controller.nextStep(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.total, required this.currentIndex});

  final int total;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final active = index <= currentIndex;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == total - 1 ? 0 : 6),
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: active
                  ? AppPalette.violet500
                  : AppPalette.whiteAlpha(0.1),
            ),
          ),
        );
      }),
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({required this.label, required this.onTap});

  final String label;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: () => onTap(),
      pressedScale: 0.97,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: AppPalette.violet600.withValues(alpha: 0.2),
          border: Border.all(
            color: AppPalette.violet500.withValues(alpha: 0.35),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow_rounded,
              color: AppPalette.violet300,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppPalette.violet300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});

  final String label;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: () => onTap(),
      pressedScale: 0.97,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: const LinearGradient(
            colors: [AppPalette.violet600, AppPalette.fuchsia600],
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppPalette.white,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      pressedScale: 0.97,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppPalette.whiteAlpha(0.2)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppPalette.whiteAlpha(0.8),
          ),
        ),
      ),
    );
  }
}
