import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';

/// One graded answer, rich enough to derive every progress statistic.
///
/// A `null` [selected] means the learner skipped the question. Skips and wrong
/// answers are both incorrect; only [skipped] distinguishes them.
class ExerciseAttempt {
  const ExerciseAttempt({
    required this.type,
    required this.expected,
    required this.selected,
    required this.direction,
    required this.instrument,
    required this.replayCount,
    required this.hesitated,
    required this.responseTime,
    required this.occurredAt,
  });

  final ExerciseType type;
  final MusicInterval expected;
  final MusicInterval? selected;
  final IntervalDirection direction;
  final Instrument instrument;
  final int replayCount;
  final bool hesitated;
  final Duration responseTime;
  final DateTime occurredAt;

  bool get skipped {
    return selected == null;
  }

  bool get correct {
    return selected == expected;
  }

  /// The signed semitone gap between the chosen and correct intervals, or `null`
  /// when the question was skipped. Used by the wrong-answer explanation.
  int? get semitoneDelta {
    final choice = selected;

    if (choice == null) {
      return null;
    }

    return choice.semitones - expected.semitones;
  }
}
