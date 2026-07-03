import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

ExerciseAttempt _attempt({required MusicInterval? selected}) {
  return ExerciseAttempt(
    type: ExerciseType.ascendingIntervals,
    expected: MusicInterval.perfectFifth,
    selected: selected,
    direction: IntervalDirection.ascending,
    instrument: Instrument.piano,
    replayCount: 0,
    hesitated: false,
    responseTime: const Duration(seconds: 1),
    occurredAt: DateTime(2026, 7, 3),
  );
}

void main() {
  group('ExerciseAttempt', () {
    test('a matching selection is correct and not skipped', () {
      final attempt = _attempt(selected: MusicInterval.perfectFifth);

      expect(attempt.correct, isTrue);
      expect(attempt.skipped, isFalse);
      expect(attempt.semitoneDelta, 0);
    });

    test('a null selection is a skip and is incorrect', () {
      final attempt = _attempt(selected: null);

      expect(attempt.skipped, isTrue);
      expect(attempt.correct, isFalse);
      expect(attempt.semitoneDelta, isNull);
    });

    test('a wrong selection reports the signed semitone gap', () {
      final attempt = _attempt(selected: MusicInterval.perfectFourth);

      expect(attempt.correct, isFalse);
      expect(attempt.skipped, isFalse);
      expect(
        attempt.semitoneDelta,
        MusicInterval.perfectFourth.semitones -
            MusicInterval.perfectFifth.semitones,
      );
    });
  });
}
