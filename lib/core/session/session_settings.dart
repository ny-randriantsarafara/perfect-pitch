import 'package:perfect_pitch/core/music/music_note.dart';

enum ReferenceMode { none, sessionStart, beforeEachQuestion }

enum DifficultyLevel { beginner, easy, medium, difficult, expert, custom }

enum AnswerDisplayMode { solfege, international, piano, guitar }

enum InstrumentId {
  sine,
  warmSynth,
  piano,
  cleanElectricGuitar,
  acousticGuitar,
  synthesizer,
  random,
}

class SessionSettings {
  const SessionSettings({
    required this.enabledNotes,
    required this.enabledOctaves,
    required this.questionCount,
    required this.replayLimit,
    required this.referenceMode,
    required this.difficultyLevel,
    required this.answerDisplayMode,
    required this.instrumentId,
    required this.maxResponseTime,
  });

  factory SessionSettings.beginner({List<MusicNote>? notes}) {
    final enabledNotes = notes ?? const [MusicNote.doNote, MusicNote.sol];

    return SessionSettings(
      enabledNotes: List.unmodifiable(enabledNotes),
      enabledOctaves: const [4],
      questionCount: 10,
      replayLimit: null,
      referenceMode: ReferenceMode.none,
      difficultyLevel: DifficultyLevel.beginner,
      answerDisplayMode: AnswerDisplayMode.solfege,
      instrumentId: InstrumentId.sine,
      maxResponseTime: null,
    );
  }

  factory SessionSettings.easy() {
    return const SessionSettings(
      enabledNotes: [MusicNote.doNote, MusicNote.sol, MusicNote.mi],
      enabledOctaves: [4],
      questionCount: 12,
      replayLimit: 3,
      referenceMode: ReferenceMode.none,
      difficultyLevel: DifficultyLevel.easy,
      answerDisplayMode: AnswerDisplayMode.solfege,
      instrumentId: InstrumentId.sine,
      maxResponseTime: Duration(seconds: 8),
    );
  }

  factory SessionSettings.medium() {
    return const SessionSettings(
      enabledNotes: MusicNote.naturalNotes,
      enabledOctaves: [4, 5],
      questionCount: 15,
      replayLimit: 2,
      referenceMode: ReferenceMode.none,
      difficultyLevel: DifficultyLevel.medium,
      answerDisplayMode: AnswerDisplayMode.solfege,
      instrumentId: InstrumentId.warmSynth,
      maxResponseTime: Duration(seconds: 6),
    );
  }

  factory SessionSettings.custom({
    required List<MusicNote> enabledNotes,
    required List<int> enabledOctaves,
    required int questionCount,
    required int? replayLimit,
    required ReferenceMode referenceMode,
    DifficultyLevel difficultyLevel = DifficultyLevel.custom,
    AnswerDisplayMode answerDisplayMode = AnswerDisplayMode.solfege,
    InstrumentId instrumentId = InstrumentId.sine,
    Duration? maxResponseTime,
  }) {
    return SessionSettings(
      enabledNotes: List.unmodifiable(enabledNotes),
      enabledOctaves: List.unmodifiable(enabledOctaves),
      questionCount: questionCount,
      replayLimit: replayLimit,
      referenceMode: referenceMode,
      difficultyLevel: difficultyLevel,
      answerDisplayMode: answerDisplayMode,
      instrumentId: instrumentId,
      maxResponseTime: maxResponseTime,
    );
  }

  final List<MusicNote> enabledNotes;
  final List<int> enabledOctaves;
  final int questionCount;
  final int? replayLimit;
  final ReferenceMode referenceMode;
  final DifficultyLevel difficultyLevel;
  final AnswerDisplayMode answerDisplayMode;
  final InstrumentId instrumentId;
  final Duration? maxResponseTime;
}
