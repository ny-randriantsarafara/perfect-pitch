import 'package:perfect_pitch/core/music/music_note.dart';

class TrainingQuestion {
  const TrainingQuestion({required this.note, required this.octave});

  final MusicNote note;
  final int octave;
}

class QuestionOutcome {
  const QuestionOutcome({
    required this.note,
    required this.selectedNote,
    required this.octave,
    required this.responseTime,
    required this.replayCount,
  });

  factory QuestionOutcome.correct({
    required MusicNote note,
    required int octave,
    required Duration responseTime,
    required int replayCount,
  }) {
    return QuestionOutcome(
      note: note,
      selectedNote: note,
      octave: octave,
      responseTime: responseTime,
      replayCount: replayCount,
    );
  }

  factory QuestionOutcome.incorrect({
    required MusicNote note,
    required MusicNote selectedNote,
    required int octave,
    required Duration responseTime,
    required int replayCount,
  }) {
    return QuestionOutcome(
      note: note,
      selectedNote: selectedNote,
      octave: octave,
      responseTime: responseTime,
      replayCount: replayCount,
    );
  }

  final MusicNote note;
  final MusicNote selectedNote;
  final int octave;
  final Duration responseTime;
  final int replayCount;

  bool get isCorrect {
    return note == selectedNote;
  }
}
