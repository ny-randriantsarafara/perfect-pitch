import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/question_generator.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';

void main() {
  group('QuestionGenerator', () {
    test('uses only the configured notes and octaves', () {
      final settings = SessionSettings.beginner(
        notes: [MusicNote.doNote, MusicNote.sol],
      );
      final generator = QuestionGenerator(seed: 7);

      final questions = generator.generate(settings);

      expect(questions, hasLength(settings.questionCount));
      expect(
        questions.every(
          (question) =>
              settings.enabledNotes.contains(question.note) &&
              settings.enabledOctaves.contains(question.octave),
        ),
        isTrue,
      );
    });

    test(
      'avoids immediate repetition when more than one note is available',
      () {
        final settings = SessionSettings.custom(
          enabledNotes: [MusicNote.doNote, MusicNote.re],
          enabledOctaves: [4],
          questionCount: 12,
          replayLimit: null,
          referenceMode: ReferenceMode.none,
        );
        final generator = QuestionGenerator(seed: 11);

        final questions = generator.generate(settings);

        for (var index = 1; index < questions.length; index += 1) {
          expect(questions[index].note, isNot(questions[index - 1].note));
        }
      },
    );

    test('does not produce long ascending scale fragments', () {
      final settings = SessionSettings.custom(
        enabledNotes: MusicNote.naturalNotes,
        enabledOctaves: [4],
        questionCount: 24,
        replayLimit: 2,
        referenceMode: ReferenceMode.none,
      );
      final generator = QuestionGenerator(seed: 23);

      final questions = generator.generate(settings);

      for (var index = 2; index < questions.length; index += 1) {
        final previous = questions[index - 2].note.naturalIndex;
        final middle = questions[index - 1].note.naturalIndex;
        final current = questions[index].note.naturalIndex;

        expect(middle == previous + 1 && current == middle + 1, isFalse);
      }
    });
  });
}
