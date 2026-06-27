import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_result.dart';
import 'package:perfect_pitch/core/session/session_stats.dart';

void main() {
  group('SessionStats', () {
    test(
      'summarizes score, timing, replay count, streak and note difficulty',
      () {
        final outcomes = [
          QuestionOutcome.correct(
            note: MusicNote.doNote,
            octave: 4,
            responseTime: const Duration(milliseconds: 1600),
            replayCount: 0,
          ),
          QuestionOutcome.incorrect(
            note: MusicNote.re,
            selectedNote: MusicNote.mi,
            octave: 4,
            responseTime: const Duration(milliseconds: 4200),
            replayCount: 2,
          ),
          QuestionOutcome.correct(
            note: MusicNote.doNote,
            octave: 4,
            responseTime: const Duration(milliseconds: 1400),
            replayCount: 1,
          ),
        ];

        final summary = SessionStats.fromOutcomes(outcomes);

        expect(summary.correctAnswers, 2);
        expect(summary.totalQuestions, 3);
        expect(summary.successRate, closeTo(2 / 3, 0.001));
        expect(summary.averageResponseTime.inMilliseconds, 2400);
        expect(summary.averageReplayCount, 1);
        expect(summary.bestStreak, 1);
        expect(summary.strongestNote, MusicNote.doNote);
        expect(summary.weakestNote, MusicNote.re);
        expect(summary.mainConfusion?.expectedNote, MusicNote.re);
        expect(summary.mainConfusion?.selectedNote, MusicNote.mi);
      },
    );
  });
}
