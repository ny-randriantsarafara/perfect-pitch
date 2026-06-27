import 'dart:math';

import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_result.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';

class QuestionGenerator {
  QuestionGenerator({int? seed}) : _random = Random(seed);

  final Random _random;

  List<TrainingQuestion> generate(SessionSettings settings) {
    final questions = <TrainingQuestion>[];

    for (var index = 0; index < settings.questionCount; index += 1) {
      final note = _pickNote(settings.enabledNotes, questions);
      final octave = _pickOctave(settings.enabledOctaves);

      questions.add(TrainingQuestion(note: note, octave: octave));
    }

    return List.unmodifiable(questions);
  }

  MusicNote _pickNote(
    List<MusicNote> enabledNotes,
    List<TrainingQuestion> previousQuestions,
  ) {
    final candidates = _candidateNotes(enabledNotes, previousQuestions);
    final selectedIndex = _random.nextInt(candidates.length);

    return candidates[selectedIndex];
  }

  List<MusicNote> _candidateNotes(
    List<MusicNote> enabledNotes,
    List<TrainingQuestion> previousQuestions,
  ) {
    final filtered = enabledNotes.where((note) {
      return !_isImmediateRepeat(note, enabledNotes, previousQuestions) &&
          !_continuesScaleFragment(note, previousQuestions);
    }).toList();

    if (filtered.isNotEmpty) {
      return filtered;
    }

    final withoutImmediateRepeat = enabledNotes.where((note) {
      return !_isImmediateRepeat(note, enabledNotes, previousQuestions);
    }).toList();

    if (withoutImmediateRepeat.isNotEmpty) {
      return withoutImmediateRepeat;
    }

    return enabledNotes;
  }

  bool _isImmediateRepeat(
    MusicNote note,
    List<MusicNote> enabledNotes,
    List<TrainingQuestion> previousQuestions,
  ) {
    if (enabledNotes.length < 2 || previousQuestions.isEmpty) {
      return false;
    }

    return previousQuestions.last.note == note;
  }

  bool _continuesScaleFragment(
    MusicNote note,
    List<TrainingQuestion> previousQuestions,
  ) {
    if (previousQuestions.length < 2) {
      return false;
    }

    final beforePrevious = previousQuestions[previousQuestions.length - 2].note;
    final previous = previousQuestions.last.note;
    final ascending =
        previous.naturalIndex == beforePrevious.naturalIndex + 1 &&
        note.naturalIndex == previous.naturalIndex + 1;
    final descending =
        previous.naturalIndex == beforePrevious.naturalIndex - 1 &&
        note.naturalIndex == previous.naturalIndex - 1;

    return ascending || descending;
  }

  int _pickOctave(List<int> enabledOctaves) {
    final selectedIndex = _random.nextInt(enabledOctaves.length);

    return enabledOctaves[selectedIndex];
  }
}
