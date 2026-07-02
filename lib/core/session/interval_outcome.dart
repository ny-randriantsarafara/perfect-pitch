import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/session/interval_question.dart';

/// The result of answering one [IntervalQuestion].
///
/// [hesitated] captures the "I knew it but hesitated" signal from the spec: a
/// correct-but-slow answer is weaker than a fast confident one.
class IntervalOutcome {
  const IntervalOutcome({
    required this.question,
    required this.selected,
    required this.responseTime,
    required this.hesitated,
  });

  final IntervalQuestion question;
  final MusicInterval selected;
  final Duration responseTime;
  final bool hesitated;

  MusicInterval get expected {
    return question.interval;
  }

  IntervalDirection get direction {
    return question.direction;
  }

  bool get isCorrect {
    return expected == selected;
  }
}
