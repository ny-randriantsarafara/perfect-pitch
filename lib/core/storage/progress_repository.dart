import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProgressSnapshot {
  const LocalProgressSnapshot({
    required this.guidedPathStep,
    required this.completedSessions,
    required this.totalTrainingTime,
    required this.noteProgress,
  });

  factory LocalProgressSnapshot.empty() {
    return const LocalProgressSnapshot(
      guidedPathStep: 1,
      completedSessions: 0,
      totalTrainingTime: Duration.zero,
      noteProgress: {},
    );
  }

  final int guidedPathStep;
  final int completedSessions;
  final Duration totalTrainingTime;
  final Map<MusicNote, NoteProgress> noteProgress;
}

class NoteProgress {
  const NoteProgress({
    required this.note,
    required this.playedCount,
    required this.correctCount,
    required this.totalResponseTime,
    required this.totalReplayCount,
    required this.confusions,
  });

  final MusicNote note;
  final int playedCount;
  final int correctCount;
  final Duration totalResponseTime;
  final int totalReplayCount;
  final Map<MusicNote, int> confusions;

  double get successRate {
    if (playedCount == 0) {
      return 0;
    }

    return correctCount / playedCount;
  }

  Duration get averageResponseTime {
    if (playedCount == 0) {
      return Duration.zero;
    }

    return Duration(
      milliseconds: totalResponseTime.inMilliseconds ~/ playedCount,
    );
  }

  double get averageReplayCount {
    if (playedCount == 0) {
      return 0;
    }

    return totalReplayCount / playedCount;
  }

  MusicNote? get mainConfusion {
    MusicNote? mostFrequentNote;
    var mostFrequentCount = 0;

    for (final entry in confusions.entries) {
      if (entry.value <= mostFrequentCount) {
        continue;
      }

      mostFrequentNote = entry.key;
      mostFrequentCount = entry.value;
    }

    return mostFrequentNote;
  }
}

abstract class ProgressRepository {
  Future<LocalProgressSnapshot> load();

  Future<void> saveGuidedPathStep(int step);

  Future<void> recordSession({
    required List<QuestionOutcome> outcomes,
    required Duration trainingTime,
  });
}

class SharedPreferencesProgressRepository implements ProgressRepository {
  const SharedPreferencesProgressRepository();

  static const _guidedPathStepKey = 'perfectPitch.guidedPathStep';
  static const _completedSessionsKey = 'perfectPitch.completedSessions';
  static const _totalTrainingMillisKey = 'perfectPitch.totalTrainingMillis';

  @override
  Future<LocalProgressSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    final noteProgress = <MusicNote, NoteProgress>{};

    for (final note in MusicNote.naturalNotes) {
      final progress = _loadNoteProgress(preferences, note);

      if (progress.playedCount == 0) {
        continue;
      }

      noteProgress[note] = progress;
    }

    return LocalProgressSnapshot(
      guidedPathStep: preferences.getInt(_guidedPathStepKey) ?? 1,
      completedSessions: preferences.getInt(_completedSessionsKey) ?? 0,
      totalTrainingTime: Duration(
        milliseconds: preferences.getInt(_totalTrainingMillisKey) ?? 0,
      ),
      noteProgress: Map.unmodifiable(noteProgress),
    );
  }

  @override
  Future<void> saveGuidedPathStep(int step) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(_guidedPathStepKey, step);
  }

  @override
  Future<void> recordSession({
    required List<QuestionOutcome> outcomes,
    required Duration trainingTime,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final completedSessions = preferences.getInt(_completedSessionsKey) ?? 0;
    final totalTrainingMillis =
        preferences.getInt(_totalTrainingMillisKey) ?? 0;

    await preferences.setInt(_completedSessionsKey, completedSessions + 1);
    await preferences.setInt(
      _totalTrainingMillisKey,
      totalTrainingMillis + trainingTime.inMilliseconds,
    );

    for (final outcome in outcomes) {
      await _recordOutcome(preferences, outcome);
    }
  }

  Future<void> _recordOutcome(
    SharedPreferences preferences,
    QuestionOutcome outcome,
  ) async {
    final prefix = _notePrefix(outcome.note);
    final playedCount = preferences.getInt('$prefix.played') ?? 0;
    final correctCount = preferences.getInt('$prefix.correct') ?? 0;
    final responseMillis = preferences.getInt('$prefix.responseMillis') ?? 0;
    final replayCount = preferences.getInt('$prefix.replays') ?? 0;

    await preferences.setInt('$prefix.played', playedCount + 1);
    await preferences.setInt(
      '$prefix.correct',
      correctCount + (outcome.isCorrect ? 1 : 0),
    );
    await preferences.setInt(
      '$prefix.responseMillis',
      responseMillis + outcome.responseTime.inMilliseconds,
    );
    await preferences.setInt(
      '$prefix.replays',
      replayCount + outcome.replayCount,
    );

    if (outcome.isCorrect) {
      return;
    }

    final confusionKey = _confusionKey(outcome.note, outcome.selectedNote);
    final confusionCount = preferences.getInt(confusionKey) ?? 0;

    await preferences.setInt(confusionKey, confusionCount + 1);
  }

  NoteProgress _loadNoteProgress(
    SharedPreferences preferences,
    MusicNote note,
  ) {
    final prefix = _notePrefix(note);
    final confusions = <MusicNote, int>{};

    for (final selectedNote in MusicNote.naturalNotes) {
      if (selectedNote == note) {
        continue;
      }

      final count = preferences.getInt(_confusionKey(note, selectedNote)) ?? 0;

      if (count == 0) {
        continue;
      }

      confusions[selectedNote] = count;
    }

    return NoteProgress(
      note: note,
      playedCount: preferences.getInt('$prefix.played') ?? 0,
      correctCount: preferences.getInt('$prefix.correct') ?? 0,
      totalResponseTime: Duration(
        milliseconds: preferences.getInt('$prefix.responseMillis') ?? 0,
      ),
      totalReplayCount: preferences.getInt('$prefix.replays') ?? 0,
      confusions: Map.unmodifiable(confusions),
    );
  }

  String _notePrefix(MusicNote note) {
    return 'perfectPitch.note.${note.name}';
  }

  String _confusionKey(MusicNote expectedNote, MusicNote selectedNote) {
    return 'perfectPitch.confusion.${expectedNote.name}.${selectedNote.name}';
  }
}

class InMemoryProgressRepository implements ProgressRepository {
  LocalProgressSnapshot _snapshot = LocalProgressSnapshot.empty();

  @override
  Future<LocalProgressSnapshot> load() async {
    return _snapshot;
  }

  @override
  Future<void> saveGuidedPathStep(int step) async {
    _snapshot = LocalProgressSnapshot(
      guidedPathStep: step,
      completedSessions: _snapshot.completedSessions,
      totalTrainingTime: _snapshot.totalTrainingTime,
      noteProgress: _snapshot.noteProgress,
    );
  }

  @override
  Future<void> recordSession({
    required List<QuestionOutcome> outcomes,
    required Duration trainingTime,
  }) async {
    final updatedProgress = Map<MusicNote, NoteProgress>.from(
      _snapshot.noteProgress,
    );

    for (final outcome in outcomes) {
      final current = updatedProgress[outcome.note];
      final confusions = Map<MusicNote, int>.from(current?.confusions ?? {});

      if (!outcome.isCorrect) {
        final confusionCount = confusions[outcome.selectedNote] ?? 0;
        confusions[outcome.selectedNote] = confusionCount + 1;
      }

      updatedProgress[outcome.note] = NoteProgress(
        note: outcome.note,
        playedCount: (current?.playedCount ?? 0) + 1,
        correctCount:
            (current?.correctCount ?? 0) + (outcome.isCorrect ? 1 : 0),
        totalResponseTime:
            (current?.totalResponseTime ?? Duration.zero) +
            outcome.responseTime,
        totalReplayCount:
            (current?.totalReplayCount ?? 0) + outcome.replayCount,
        confusions: Map.unmodifiable(confusions),
      );
    }

    _snapshot = LocalProgressSnapshot(
      guidedPathStep: _snapshot.guidedPathStep,
      completedSessions: _snapshot.completedSessions + 1,
      totalTrainingTime: _snapshot.totalTrainingTime + trainingTime,
      noteProgress: Map.unmodifiable(updatedProgress),
    );
  }
}
