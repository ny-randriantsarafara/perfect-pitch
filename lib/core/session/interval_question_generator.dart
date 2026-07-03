import 'dart:math';

import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';
import 'package:perfect_pitch/core/session/interval_question.dart';

/// An interval paired with the way it will be played, the unit the generator
/// varies so mixed-direction sessions cannot be answered by pattern.
typedef _IntervalPair = ({MusicInterval interval, IntervalDirection direction});

/// Builds interval questions while keeping the sequence unpredictable: it
/// avoids repeating a recently asked interval-and-direction pair so learners
/// cannot answer by pattern rather than by ear.
class IntervalQuestionGenerator {
  IntervalQuestionGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;
  final List<_IntervalPair> _recent = [];

  static const int _recentMemory = 2;
  static const int _defaultRootMidiMin = 55; // G3
  static const int _defaultRootMidiMax = 64; // E4
  static const int _defaultChoiceCount = 4;
  static const Set<IntervalDirection> _defaultDirections = {
    IntervalDirection.ascending,
  };

  IntervalQuestion next({
    required List<MusicInterval> pool,
    required Instrument instrument,
    Set<IntervalDirection> allowedDirections = _defaultDirections,
    int choiceCount = _defaultChoiceCount,
    int minimumRootMidi = _defaultRootMidiMin,
    int maximumRootMidi = _defaultRootMidiMax,
  }) {
    if (pool.isEmpty) {
      throw ArgumentError.value(pool, 'pool', 'must not be empty');
    }

    if (allowedDirections.isEmpty) {
      throw ArgumentError.value(
        allowedDirections,
        'allowedDirections',
        'must not be empty',
      );
    }

    final pair = _pickPair(pool, allowedDirections);
    _remember(pair);

    return IntervalQuestion(
      root: _pickRoot(minimumRootMidi, maximumRootMidi),
      interval: pair.interval,
      direction: pair.direction,
      instrument: instrument,
      choices: _buildChoices(pool, pair.interval, choiceCount),
    );
  }

  _IntervalPair _pickPair(
    List<MusicInterval> pool,
    Set<IntervalDirection> allowedDirections,
  ) {
    final allPairs = <_IntervalPair>[
      for (final interval in pool)
        for (final direction in allowedDirections)
          (interval: interval, direction: direction),
    ];
    final candidates = allPairs
        .where((pair) => !_recent.contains(pair))
        .toList();
    final effectivePairs = candidates.isEmpty ? allPairs : candidates;

    return effectivePairs[_random.nextInt(effectivePairs.length)];
  }

  void _remember(_IntervalPair pair) {
    _recent.add(pair);

    while (_recent.length > _recentMemory) {
      _recent.removeAt(0);
    }
  }

  Pitch _pickRoot(int minimumRootMidi, int maximumRootMidi) {
    final span = maximumRootMidi - minimumRootMidi;
    final rootMidi = minimumRootMidi + _random.nextInt(span + 1);

    return Pitch(rootMidi);
  }

  List<MusicInterval> _buildChoices(
    List<MusicInterval> pool,
    MusicInterval correct,
    int choiceCount,
  ) {
    final distractors = pool.where((interval) => interval != correct).toList()
      ..shuffle(_random);
    final count = min(choiceCount, pool.length);
    final choices = <MusicInterval>[
      correct,
      ...distractors.take(count - 1),
    ]..sort((a, b) => a.semitones.compareTo(b.semitones));

    return List.unmodifiable(choices);
  }
}
