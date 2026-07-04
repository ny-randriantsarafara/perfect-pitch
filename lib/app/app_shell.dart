import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_navigation.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/features/courses/course_tab.dart';
import 'package:perfect_pitch/features/guitar/guitar_tab.dart';
import 'package:perfect_pitch/features/home/home_tab.dart';
import 'package:perfect_pitch/features/practice/practice_tab.dart';
import 'package:perfect_pitch/features/stats/stats_tab.dart';
import 'package:perfect_pitch/ui/ambient_glow.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

/// Root responsive scaffold. Chooses the desktop side-nav layout on
/// landscape tablet-and-up screens, and the mobile phone-frame layout
/// everywhere else (portrait, phones, reduced browser windows).
class AppShell extends StatelessWidget {
  const AppShell({required this.controller, super.key});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final mode = LayoutResolver.of(context);

        return Scaffold(
          backgroundColor: AppPalette.canvas,
          body: mode == LayoutMode.desktop
              ? _DesktopFrame(controller: controller)
              : _MobileFrame(controller: controller),
        );
      },
    );
  }
}

Widget _buildTabContent(AppController controller, LayoutMode mode) {
  final Widget child;

  switch (controller.tab) {
    case AppTab.home:
      child = HomeTab(controller: controller, mode: mode);
    case AppTab.practice:
      child = PracticeTab(
        controller: controller.practice,
        progress: controller.progress,
        mode: mode,
        onOpenCourse: controller.openRecommendedCourseForExercise,
      );
    case AppTab.learn:
      child = CourseTab(
        controller: controller.course,
        audioEngine: controller.audioEngine,
        mode: mode,
        onStartDrill: controller.startCourseDrill,
      );
    case AppTab.guitar:
      child = GuitarTab(controller: controller.guitar, mode: mode);
    case AppTab.stats:
      child = StatsTab(progress: controller.progress, mode: mode);
  }

  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 250),
    switchInCurve: Curves.easeOut,
    child: KeyedSubtree(key: ValueKey(controller.tab), child: child),
  );
}

const _violetGlow = AmbientGlow(color: Color(0x337C3AED), diameter: 500);
const _fuchsiaGlow = AmbientGlow(color: Color(0x1AC026D3), diameter: 420);

class _MobileFrame extends StatelessWidget {
  const _MobileFrame({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shouldStretch = size.shortestSide < 600 || size.width < 640;
    final contents = _MobileFrameContents(controller: controller);

    if (shouldStretch) {
      return ColoredBox(color: AppPalette.frame, child: contents);
    }

    final frameHeight = (size.height - 64).clamp(0.0, 850.0);

    return Center(
      child: Container(
        width: 480,
        height: frameHeight,
        decoration: BoxDecoration(
          color: AppPalette.frame,
          borderRadius: BorderRadius.circular(48),
          border: Border.all(color: AppPalette.whiteAlpha(0.1)),
          boxShadow: [
            BoxShadow(
              color: AppPalette.violet900.withValues(alpha: 0.3),
              blurRadius: 60,
              spreadRadius: 4,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: contents,
      ),
    );
  }
}

class _MobileFrameContents extends StatelessWidget {
  const _MobileFrameContents({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(left: -250, top: -250, child: _violetGlow),
        const Positioned(right: -210, bottom: -210, child: _fuchsiaGlow),
        SafeArea(child: _buildTabContent(controller, LayoutMode.mobile)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: MobileNavigationBar(
            currentTab: controller.tab,
            onSelect: controller.selectTab,
          ),
        ),
      ],
    );
  }
}

class _DesktopFrame extends StatelessWidget {
  const _DesktopFrame({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppPalette.frame),
      child: Stack(
        children: [
          const Positioned(left: -250, top: -250, child: _violetGlow),
          const Positioned(right: -210, bottom: -210, child: _fuchsiaGlow),
          Row(
            children: [
              DesktopNavigationRail(
                currentTab: controller.tab,
                onSelect: controller.selectTab,
                streakDays: controller.progress.streakDays,
              ),
              Expanded(
                child: SafeArea(
                  child: _buildTabContent(controller, LayoutMode.desktop),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
