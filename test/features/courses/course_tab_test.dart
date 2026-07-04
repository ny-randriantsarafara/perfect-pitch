import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/features/courses/course_controller.dart';
import 'package:perfect_pitch/features/courses/course_tab.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

Widget _host(
  CourseController controller, {
  Future<void> Function(CourseSpec course)? onStartDrill,
  Locale locale = const Locale('en'),
}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      backgroundColor: AppPalette.canvas,
      body: CourseTab(
        controller: controller,
        audioEngine: const AudioEngine(player: SilentAudioPlayer()),
        mode: LayoutMode.mobile,
        onStartDrill: onStartDrill ?? (_) async {},
      ),
    ),
  );
}

void _setSurface(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

CourseController _newController() {
  return CourseController(
    progressRepository: InMemoryCourseProgressRepository(),
  );
}

void main() {
  testWidgets('shows recommended course and opens lesson on tap', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1200));

    final controller = _newController();
    addTearDown(controller.dispose);
    await controller.load();

    await tester.pumpWidget(_host(controller));
    await tester.pump();

    expect(find.text('Learn'), findsWidgets);
    expect(find.text('How to train your ear'), findsOneWidget);
    expect(find.text('RECOMMENDED'), findsOneWidget);

    await tester.tap(find.text('How to train your ear'));
    await tester.pump();

    expect(find.text('Concept'), findsOneWidget);
    expect(find.textContaining('An interval is the distance'), findsOneWidget);
  });

  testWidgets(
    'lesson next and start drill actions work and mark completion',
    (tester) async {
      _setSurface(tester, const Size(500, 1200));

      final controller = _newController();
      addTearDown(controller.dispose);
      var startedCourseId = '';

      await controller.load();
      controller.openCourse(controller.recommendedCourse);

      await tester.pumpWidget(
        _host(
          controller,
          onStartDrill: (course) async {
            startedCourseId = course.id;
            await controller.completeCourse(course);
          },
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pump();
      expect(find.text('Ear clue'), findsOneWidget);

      await tester.tap(find.text('Next'));
      await tester.pump();
      expect(find.text('Mini drill'), findsOneWidget);

      await tester.tap(find.text('Start drill'));
      await tester.pump();
      expect(startedCourseId, 'course_ear_training_basics');
      expect(
        controller.progress.isCompleted('course_ear_training_basics'),
        isTrue,
      );
    },
  );

  testWidgets('back arrow returns to the course list', (tester) async {
    _setSurface(tester, const Size(500, 1200));

    final controller = _newController();
    addTearDown(controller.dispose);
    await controller.load();
    controller.openCourse(controller.recommendedCourse);

    await tester.pumpWidget(_host(controller));
    await tester.pump();

    expect(find.text('Concept'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pump();

    expect(find.text('Learn'), findsWidgets);
    expect(find.text('RECOMMENDED'), findsOneWidget);
  });
}
