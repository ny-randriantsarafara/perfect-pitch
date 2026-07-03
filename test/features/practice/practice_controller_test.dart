import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/session/interval_outcome.dart';
import 'package:perfect_pitch/core/session/interval_question_generator.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';

PracticeController _buildController({
  required void Function(List<IntervalOutcome>) onCompleted,
  int questionCount = 3,
}) {
  return PracticeController(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    onSessionCompleted: onCompleted,
    generator: IntervalQuestionGenerator(random: Random(7)),
    pool: MusicInterval.upToStage(3),
    questionCount: questionCount,
  );
}

void main() {
  group('PracticeController', () {
    test('clears the playing state when audio playback fails', () async {
      final controller = PracticeController(
        audioEngine: const AudioEngine(player: _ThrowingAudioPlayer()),
        onSessionCompleted: (_) {},
        generator: IntervalQuestionGenerator(random: Random(7)),
        pool: MusicInterval.upToStage(3),
        questionCount: 1,
      );
      controller.startSession();

      await controller.playCurrent();

      expect(controller.isPlaying, isFalse);
    });

    test('reveals the result after answering', () {
      final controller = _buildController(onCompleted: (_) {});
      controller.startSession();

      expect(controller.question, isNotNull);
      expect(controller.showResult, isFalse);

      controller.selectAnswer(controller.question!.interval);

      expect(controller.showResult, isTrue);
      expect(controller.isCorrect, isTrue);
    });

    test('flags a wrong answer as incorrect', () {
      final controller = _buildController(onCompleted: (_) {});
      controller.startSession();

      final wrong = controller.question!.choices.firstWhere(
        (choice) => choice != controller.question!.interval,
      );
      controller.selectAnswer(wrong);

      expect(controller.isCorrect, isFalse);
    });

    test('records hesitation on the current answer', () {
      final controller = _buildController(onCompleted: (_) {});
      controller.startSession();
      controller.selectAnswer(controller.question!.interval);

      expect(controller.hesitated, isFalse);
      controller.markHesitation();
      expect(controller.hesitated, isTrue);
    });

    test('ignores answers once the result is shown', () {
      final controller = _buildController(onCompleted: (_) {});
      controller.startSession();
      final answer = controller.question!.interval;
      controller.selectAnswer(answer);

      final other = controller.question!.choices.firstWhere(
        (choice) => choice != answer,
      );
      controller.selectAnswer(other);

      expect(controller.selected, answer);
    });

    test('completes a session after the configured number of questions', () {
      List<IntervalOutcome>? completed;
      final controller = _buildController(
        onCompleted: (outcomes) => completed = outcomes,
        questionCount: 3,
      );
      controller.startSession();

      for (var i = 0; i < 3; i += 1) {
        controller.selectAnswer(controller.question!.interval);
        controller.next();
      }

      expect(completed, isNotNull);
      expect(completed!.length, 3);
      expect(controller.questionNumber, 1);
    });
  });
}

class _ThrowingAudioPlayer implements AudioPlayer {
  const _ThrowingAudioPlayer();

  @override
  Future<void> playChord(List<ToneRequest> requests) {
    throw StateError('audio failed');
  }

  @override
  Future<void> playTone(ToneRequest request) {
    throw StateError('audio failed');
  }
}
