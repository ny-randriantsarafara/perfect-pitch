import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/perfect_pitch_app.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/courses/course_progress_repository.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

PerfectPitchApp _buildApp() {
  return PerfectPitchApp(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    progressRepository: InMemoryIntervalProgressRepository(),
    courseProgressRepository: InMemoryCourseProgressRepository(),
  );
}

void _setSurface(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  test('keeps desktop mode for wide landscape screens only', () {
    expect(LayoutResolver.fromSize(const Size(932, 430)), LayoutMode.mobile);
    expect(LayoutResolver.fromSize(const Size(1024, 768)), LayoutMode.desktop);
    expect(LayoutResolver.fromSize(const Size(1400, 900)), LayoutMode.desktop);
    expect(LayoutResolver.fromSize(const Size(900, 1400)), LayoutMode.mobile);
  });

  testWidgets('mobile home session card opens the exercises catalogue', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('Hello!'), findsOneWidget);

    await tester.tap(find.text('Start (5 min)'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Ascending intervals'), findsOneWidget);
    expect(find.text('Mixed intervals'), findsOneWidget);
  });

  testWidgets('mobile home see all opens the exercises catalogue', (
    tester,
  ) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    await tester.tap(find.text('SEE ALL'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Exercises'), findsOneWidget);
    expect(find.text('Ascending intervals'), findsOneWidget);
  });

  testWidgets('mobile bottom navigation switches tabs', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.music_note_rounded));
    await tester.pump();
    expect(find.text('Fretboard'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.auto_awesome_rounded));
    await tester.pump();
    expect(find.text('Interval detail'), findsOneWidget);
  });

  testWidgets('mobile bottom navigation opens learn tab', (tester) async {
    _setSurface(tester, const Size(500, 1000));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.school_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('How to train your ear'), findsOneWidget);
  });

  testWidgets('desktop layout shows the side navigation rail', (tester) async {
    _setSurface(tester, const Size(1400, 900));

    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('The Perfect Pitch'), findsOneWidget);
    expect(find.text('Intervals'), findsNothing);
    expect(find.text('.pro'), findsNothing);
    expect(find.text('Hello!'), findsOneWidget);
  });

  testWidgets(
    'mobile home recommendation card opens an existing exercise setup',
    (tester) async {
      _setSurface(tester, const Size(500, 1000));

      await tester.pumpWidget(_buildApp());
      await tester.pump();

      expect(
        find.byKey(const ValueKey('home-exercise-recommendation-0')),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const ValueKey('home-exercise-recommendation-0')),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.byKey(const ValueKey('practice-setup-start')),
        findsOneWidget,
      );
      expect(find.text('SETTINGS'), findsOneWidget);
    },
  );
}
