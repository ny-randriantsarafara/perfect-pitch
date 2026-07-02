import 'dart:math';

import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';
import 'package:perfect_pitch/core/session/interval_question.dart';

/// Builds interval questions while keeping the sequence unpredictable: it
/// avoids repeating a recently asked interval so learners cannot answer by
/// pattern rather than by ear.
class IntervalQuestionGenerator {
  IntervalQuestionGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;
  final List<MusicInterval> _recent = [];

  static const int _recentMemory = 2;
  static const int _rootMidiMin = 55; // G3
  static const int _rootMidiMax = 64; // E4
  static const int _maxChoices = 4;

  IntervalQuestion next({
    required List<MusicInterval> pool,
    required Instrument instrument,
    IntervalDirection direction = IntervalDirection.ascending,
  }) {
    if (pool.isEmpty) {
      throw ArgumentError.value(pool, 'pool', 'must not be empty');
    }

    final interval = _pickInterval(pool);
    _remember(interval);

    return IntervalQuestion(
      root: _pickRoot(interval),
      interval: interval,
      direction: direction,
      instrument: instrument,
      choices: _buildChoices(pool, interval),
    );
  }

  MusicInterval _pickInterval(List<MusicInterval> pool) {
    final candidates = pool
        .where((interval) => !_recent.contains(interval))
        .toList();
    final effectivePool = candidates.isEmpty ? pool : candidates;

    return effectivePool[_random.nextInt(effectivePool.length)];
  }

  void _remember(MusicInterval interval) {
    _recent.add(interval);

    while (_recent.length > _recentMemory) {
      _recent.removeAt(0);
    }
  }

  Pitch _pickRoot(MusicInterval interval) {
    final span = _rootMidiMax - _rootMidiMin;
    final rootMidi = _rootMidiMin + _random.nextInt(span + 1);

    return Pitch(rootMidi);
  }

  List<MusicInterval> _buildChoices(
    List<MusicInterval> pool,
    MusicInterval correct,
  ) {
    final distractors = pool.where((interval) => interval != correct).toList()
      ..shuffle(_random);
    final choiceCount = min(_maxChoices, pool.length);
    final choices = <MusicInterval>[
      correct,
      ...distractors.take(choiceCount - 1),
    ]..sort((a, b) => a.semitones.compareTo(b.semitones));

    return List.unmodifiable(choices);
  }
}
