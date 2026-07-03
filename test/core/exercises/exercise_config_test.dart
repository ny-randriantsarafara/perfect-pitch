import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

void main() {
  group('ExerciseConfig.defaults', () {
    test('creates a valid config for every exercise type', () {
      for (final type in ExerciseType.values) {
        final config = ExerciseConfig.defaults(type);

        expect(config.type, type);
        expect(config.intervals, isNotEmpty);
        expect(config.directions, isNotEmpty);
        expect(config.questionCount, greaterThan(0));
        expect(config.choiceCount, lessThanOrEqualTo(config.intervals.length));
        expect(
          config.minimumRootMidi,
          lessThanOrEqualTo(config.maximumRootMidi),
        );
        expect(config.directions, equals(type.defaultDirections));
      }
    });

    test('descending default excludes unison', () {
      final config = ExerciseConfig.defaults(ExerciseType.descendingIntervals);

      expect(config.intervals, isNot(contains(MusicInterval.unison)));
      expect(config.directions, equals({IntervalDirection.descending}));
    });

    test('mixed default has all three playback directions', () {
      final config = ExerciseConfig.defaults(ExerciseType.mixedIntervals);

      expect(
        config.directions,
        equals({
          IntervalDirection.ascending,
          IntervalDirection.descending,
          IntervalDirection.harmonic,
        }),
      );
    });

    test('ascending default keeps unison and stays ascending', () {
      final config = ExerciseConfig.defaults(ExerciseType.ascendingIntervals);

      expect(config.intervals, contains(MusicInterval.unison));
      expect(config.directions, equals({IntervalDirection.ascending}));
    });
  });

  group('ExerciseConfig.copyWith', () {
    test('overrides only the provided fields', () {
      final config = ExerciseConfig.defaults(ExerciseType.ascendingIntervals);

      final updated = config.copyWith(questionCount: 20, choiceCount: 3);

      expect(updated.questionCount, 20);
      expect(updated.choiceCount, 3);
      expect(updated.type, config.type);
      expect(updated.directions, config.directions);
    });

    test('clears the replay limit for unlimited replays', () {
      final config = ExerciseConfig.defaults(ExerciseType.ascendingIntervals);

      final updated = config.copyWith(clearReplayLimit: true);

      expect(updated.replayLimit, isNull);
      expect(updated.allowsUnlimitedReplays, isTrue);
    });
  });
}
