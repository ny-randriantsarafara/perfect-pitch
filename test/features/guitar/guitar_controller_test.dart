import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/features/guitar/guitar_controller.dart';

void main() {
  group('GuitarController', () {
    test('grades a position the target interval above the root as correct', () {
      final controller = GuitarController(
        audioEngine: const AudioEngine(player: SilentAudioPlayer()),
        onAttemptRecorded: ({required interval, required correct}) {},
        random: Random(1),
      );
      final root = controller.root;
      final target = FretPosition(
        string: root.string,
        fret: root.fret + controller.interval.semitones,
      );

      expect(controller.isCorrectTarget(target), isTrue);
      expect(
        controller.isCorrectTarget(
          FretPosition(string: root.string, fret: root.fret + 1),
        ),
        isFalse,
      );
    });

    test('records the attempt and reveals the result on selection', () async {
      MusicInterval? recordedInterval;
      bool? recordedCorrect;
      final controller = GuitarController(
        audioEngine: const AudioEngine(player: SilentAudioPlayer()),
        onAttemptRecorded: ({required interval, required correct}) {
          recordedInterval = interval;
          recordedCorrect = correct;
        },
        random: Random(1),
      );
      final root = controller.root;
      final target = FretPosition(
        string: root.string,
        fret: root.fret + controller.interval.semitones,
      );

      await controller.selectPosition(target);

      expect(controller.showResult, isTrue);
      expect(controller.lastAnswerCorrect, isTrue);
      expect(recordedInterval, controller.interval);
      expect(recordedCorrect, isTrue);
    });

    test('reveals a reachable correct target for a wrong answer', () {
      final controller = GuitarController(
        audioEngine: const AudioEngine(player: SilentAudioPlayer()),
        onAttemptRecorded: ({required interval, required correct}) {},
        random: Random(5),
      );

      final revealed = controller.revealedTarget(fretCount: 15);

      expect(revealed, isNotNull);
      expect(controller.isCorrectTarget(revealed!), isTrue);
    });

    test('nextChallenge clears the previous result', () async {
      final controller = GuitarController(
        audioEngine: const AudioEngine(player: SilentAudioPlayer()),
        onAttemptRecorded: ({required interval, required correct}) {},
        random: Random(2),
      );
      final root = controller.root;
      await controller.selectPosition(
        FretPosition(string: root.string, fret: root.fret + 1),
      );
      expect(controller.showResult, isTrue);

      controller.nextChallenge();

      expect(controller.showResult, isFalse);
      expect(controller.selected, isNull);
    });
  });
}
