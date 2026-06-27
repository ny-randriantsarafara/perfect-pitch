import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_result.dart';

class NoteConfusion {
  const NoteConfusion({
    required this.expectedNote,
    required this.selectedNote,
    required this.count,
  });

  final MusicNote expectedNote;
  final MusicNote selectedNote;
  final int count;
}

class SessionStats {
  const SessionStats({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.successRate,
    required this.averageResponseTime,
    required this.averageReplayCount,
    required this.bestStreak,
    required this.strongestNote,
    required this.weakestNote,
    required this.mainConfusion,
  });

  factory SessionStats.fromOutcomes(List<QuestionOutcome> outcomes) {
    if (outcomes.isEmpty) {
      return const SessionStats(
        totalQuestions: 0,
        correctAnswers: 0,
        successRate: 0,
        averageResponseTime: Duration.zero,
        averageReplayCount: 0,
        bestStreak: 0,
        strongestNote: null,
        weakestNote: null,
        mainConfusion: null,
      );
    }

    final correctAnswers = outcomes
        .where((outcome) => outcome.isCorrect)
        .length;
    final totalResponseTime = outcomes.fold<int>(
      0,
      (total, outcome) => total + outcome.responseTime.inMilliseconds,
    );
    final totalReplayCount = outcomes.fold<int>(
      0,
      (total, outcome) => total + outcome.replayCount,
    );
    final totalQuestions = outcomes.length;

    return SessionStats(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      successRate: correctAnswers / totalQuestions,
      averageResponseTime: Duration(
        milliseconds: totalResponseTime ~/ totalQuestions,
      ),
      averageReplayCount: totalReplayCount / totalQuestions,
      bestStreak: _bestStreak(outcomes),
      strongestNote: _strongestNote(outcomes),
      weakestNote: _weakestNote(outcomes),
      mainConfusion: _mainConfusion(outcomes),
    );
  }

  final int totalQuestions;
  final int correctAnswers;
  final double successRate;
  final Duration averageResponseTime;
  final double averageReplayCount;
  final int bestStreak;
  final MusicNote? strongestNote;
  final MusicNote? weakestNote;
  final NoteConfusion? mainConfusion;

  static int _bestStreak(List<QuestionOutcome> outcomes) {
    var currentStreak = 0;
    var bestStreak = 0;

    for (final outcome in outcomes) {
      if (!outcome.isCorrect) {
        currentStreak = 0;
        continue;
      }

      currentStreak += 1;

      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
      }
    }

    return bestStreak;
  }

  static MusicNote? _strongestNote(List<QuestionOutcome> outcomes) {
    final noteSummaries = _noteSummaries(outcomes);
    NotePerformance? strongest;

    for (final summary in noteSummaries) {
      if (strongest == null || summary.successRate > strongest.successRate) {
        strongest = summary;
      }
    }

    return strongest?.note;
  }

  static MusicNote? _weakestNote(List<QuestionOutcome> outcomes) {
    final noteSummaries = _noteSummaries(outcomes);
    NotePerformance? weakest;

    for (final summary in noteSummaries) {
      if (weakest == null || summary.successRate < weakest.successRate) {
        weakest = summary;
      }
    }

    return weakest?.note;
  }

  static List<NotePerformance> _noteSummaries(List<QuestionOutcome> outcomes) {
    return MusicNote.naturalNotes
        .map((note) {
          final noteOutcomes = outcomes.where((outcome) {
            return outcome.note == note;
          }).toList();
          final correctCount = noteOutcomes.where((outcome) {
            return outcome.isCorrect;
          }).length;

          return NotePerformance(
            note: note,
            playedCount: noteOutcomes.length,
            correctCount: correctCount,
          );
        })
        .where((summary) => summary.playedCount > 0)
        .toList();
  }

  static NoteConfusion? _mainConfusion(List<QuestionOutcome> outcomes) {
    final confusions = <NoteConfusion>[];

    for (final expectedNote in MusicNote.naturalNotes) {
      for (final selectedNote in MusicNote.naturalNotes) {
        if (expectedNote == selectedNote) {
          continue;
        }

        final count = outcomes.where((outcome) {
          return outcome.note == expectedNote &&
              outcome.selectedNote == selectedNote;
        }).length;

        if (count == 0) {
          continue;
        }

        confusions.add(
          NoteConfusion(
            expectedNote: expectedNote,
            selectedNote: selectedNote,
            count: count,
          ),
        );
      }
    }

    NoteConfusion? strongestConfusion;

    for (final confusion in confusions) {
      if (strongestConfusion == null ||
          confusion.count > strongestConfusion.count) {
        strongestConfusion = confusion;
      }
    }

    return strongestConfusion;
  }
}

class NotePerformance {
  const NotePerformance({
    required this.note,
    required this.playedCount,
    required this.correctCount,
  });

  final MusicNote note;
  final int playedCount;
  final int correctCount;

  double get successRate {
    if (playedCount == 0) {
      return 0;
    }

    return correctCount / playedCount;
  }
}
