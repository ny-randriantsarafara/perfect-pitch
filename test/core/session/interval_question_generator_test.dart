import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/session/interval_question_generator.dart';

void main() {
  group('IntervalQuestionGenerator', () {
    test('always includes the correct interval in the choices', () {
      final generator = IntervalQuestionGenerator(random: Random(1));
      final pool = MusicInterval.upToStage(3);

      for (var i = 0; i < 30; i += 1) {
        final question = generator.next(pool: pool, instrument: Instrument.piano);

        expect(question.choices, contains(question.interval));
      }
    });

    test('offers at most four unique choices from the pool', () {
      final generator = IntervalQuestionGenerator(random: Random(2));
      final pool = MusicInterval.values;

      final question = generator.next(pool: pool, instrument: Instrument.piano);

      expect(question.choices.length, 4);
      expect(question.choices.toSet().length, 4);
      expect(pool, containsAll(question.choices));
    });

    test('does not repeat the same interval twice in a row', () {
      final generator = IntervalQuestionGenerator(random: Random(3));
      final pool = MusicInterval.upToStage(3);
      var previous = generator
          .next(pool: pool, instrument: Instrument.piano)
          .interval;

      for (var i = 0; i < 40; i += 1) {
        final current = generator
            .next(pool: pool, instrument: Instrument.piano)
            .interval;

        expect(current, isNot(previous));
        previous = current;
      }
    });

    test('uses all choices when the pool is small', () {
      final generator = IntervalQuestionGenerator(random: Random(4));
      final pool = [MusicInterval.unison, MusicInterval.octave];

      final question = generator.next(pool: pool, instrument: Instrument.piano);

      expect(question.choices.length, 2);
    });
  });
}
