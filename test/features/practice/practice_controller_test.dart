import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/session/interval_question_generator.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';

PracticeController _buildController({
  void Function(List<ExerciseAttempt>)? onCompleted,
  int seed = 7,
}) {
  return PracticeController(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    onSessionCompleted: onCompleted ?? (_) {},
    generator: IntervalQuestionGenerator(random: Random(seed)),
  );
}

ExerciseConfig _config(
  ExerciseType type, {
  int questionCount = 3,
  bool immediateFeedback = true,
}) {
  return ExerciseConfig.defaults(type).copyWith(
    questionCount: questionCount,
    immediateFeedback: immediateFeedback,
  );
}

void main() {
  group('PracticeController', () {
    test('starts on the catalogue stage', () {
      final controller = _buildController();

      expect(controller.stage, PracticeStage.catalogue);
      expect(controller.question, isNull);
    });

    test('opening a catalogue card moves to setup with defaults', () {
      final controller = _buildController();

      controller.configureExercise(ExerciseType.descendingIntervals);

      expect(controller.stage, PracticeStage.setup);
      expect(controller.draftConfig?.type, ExerciseType.descendingIntervals);
    });

    test('clears the playing state when audio playback fails', () async {
      final controller = PracticeController(
        audioEngine: const AudioEngine(player: _ThrowingAudioPlayer()),
        onSessionCompleted: (_) {},
        generator: IntervalQuestionGenerator(random: Random(7)),
      );

      await controller.startExercise(
        _config(ExerciseType.ascendingIntervals, questionCount: 1),
      );

      expect(controller.isPlaying, isFalse);
    });

    test('an ascending config behaves like the classic practice loop', () async {
      final controller = _buildController();

      await controller.startExercise(_config(ExerciseType.ascendingIntervals));

      expect(controller.stage, PracticeStage.active);
      expect(controller.question, isNotNull);
      expect(controller.question!.direction, IntervalDirection.ascending);
      expect(controller.showResult, isFalse);

      controller.selectAnswer(controller.question!.interval);

      expect(controller.showResult, isTrue);
      expect(controller.isCorrect, isTrue);
    });

    test('descending and harmonic configs match their playback direction', () async {
      final descending = _buildController();
      await descending.startExercise(
        _config(ExerciseType.descendingIntervals),
      );
      expect(descending.question!.direction, IntervalDirection.descending);

      final harmonic = _buildController();
      await harmonic.startExercise(_config(ExerciseType.harmonicIntervals));
      expect(harmonic.question!.direction, IntervalDirection.harmonic);
    });

    test('a mixed config reads the direction from each question', () async {
      final controller = _buildController();
      const allowed = {
        IntervalDirection.ascending,
        IntervalDirection.descending,
        IntervalDirection.harmonic,
      };

      await controller.startExercise(
        _config(
          ExerciseType.mixedIntervals,
          questionCount: 6,
          immediateFeedback: false,
        ),
      );

      for (var i = 0; i < 6; i += 1) {
        expect(allowed, contains(controller.question!.direction));
        controller.selectAnswer(controller.question!.interval);
        await controller.next();
      }
    });

    test('a skip is stored as an incorrect, skipped attempt', () async {
      final controller = _buildController();

      await controller.startExercise(
        _config(ExerciseType.ascendingIntervals, immediateFeedback: false),
      );
      await controller.skip();

      expect(controller.attempts, hasLength(1));
      expect(controller.attempts.first.skipped, isTrue);
      expect(controller.attempts.first.correct, isFalse);
    });

    test('ignores answers once the result is shown', () async {
      final controller = _buildController();

      await controller.startExercise(_config(ExerciseType.ascendingIntervals));

      final answer = controller.question!.interval;
      controller.selectAnswer(answer);

      final other = controller.question!.choices.firstWhere(
        (choice) => choice != answer,
      );
      controller.selectAnswer(other);

      expect(controller.selected, answer);
    });

    test('records hesitation on the current answer', () async {
      final controller = _buildController();

      await controller.startExercise(_config(ExerciseType.ascendingIntervals));
      controller.selectAnswer(controller.question!.interval);

      expect(controller.hesitated, isFalse);
      controller.markHesitation();
      expect(controller.hesitated, isTrue);
      expect(controller.attempts, isEmpty);

      await controller.next();
      expect(controller.attempts.first.hesitated, isTrue);
    });

    test('the final question opens the summary instead of restarting', () async {
      List<ExerciseAttempt>? completed;
      final controller = _buildController(
        onCompleted: (attempts) => completed = attempts,
      );

      await controller.startExercise(
        _config(ExerciseType.ascendingIntervals, questionCount: 3),
      );

      for (var i = 0; i < 3; i += 1) {
        controller.selectAnswer(controller.question!.interval);
        await controller.next();
      }

      expect(controller.stage, PracticeStage.summary);
      expect(controller.question, isNull);
      expect(completed, isNotNull);
      expect(completed, hasLength(3));
    });

    test('retry mistakes builds a session from the missed intervals', () async {
      final controller = _buildController();

      await controller.startExercise(
        _config(
          ExerciseType.ascendingIntervals,
          questionCount: 3,
          immediateFeedback: false,
        ),
      );

      final missed = <MusicInterval>{};
      for (var i = 0; i < 3; i += 1) {
        final question = controller.question!;
        final wrong = question.choices.firstWhere(
          (choice) => choice != question.interval,
        );
        missed.add(question.interval);
        controller.selectAnswer(wrong);
        await controller.next();
      }

      expect(controller.stage, PracticeStage.summary);

      await controller.retryMistakes();

      expect(controller.stage, PracticeStage.active);
      expect(controller.config!.intervals.toSet(), equals(missed));
      expect(controller.config!.questionCount, missed.length);
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
