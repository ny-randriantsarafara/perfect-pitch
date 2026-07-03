import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/exercises/exercise_attempt.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/session/interval_question.dart';
import 'package:perfect_pitch/core/session/interval_question_generator.dart';

/// Reports the attempts of a finished session so progress can be persisted.
typedef PracticeSessionCompleted =
    void Function(List<ExerciseAttempt> attempts);

/// The screen the Exercises tab is currently showing.
enum PracticeStage { catalogue, setup, active, summary }

/// Drives the whole Exercises flow: choose an exercise, configure it, run the
/// ear-recognition loop question by question, then show a summary.
///
/// Every session is described by an [ExerciseConfig], so ascending, descending,
/// harmonic, and mixed exercises all reuse this one controller. The first
/// playback of each question is automatic and is never counted as a replay; the
/// response timer only starts once that playback finishes.
class PracticeController extends ChangeNotifier {
  PracticeController({
    required this.audioEngine,
    required this.onSessionCompleted,
    IntervalQuestionGenerator? generator,
  }) : _generator = generator ?? IntervalQuestionGenerator();

  final AudioEngine audioEngine;
  final PracticeSessionCompleted onSessionCompleted;
  final IntervalQuestionGenerator _generator;

  PracticeStage _stage = PracticeStage.catalogue;
  ExerciseConfig? _draftConfig;
  ExerciseConfig? _config;

  IntervalQuestion? _question;
  int _questionNumber = 0;
  bool _isPlaying = false;
  MusicInterval? _selected;
  ExerciseAttempt? _currentAttempt;
  bool _hesitated = false;
  int _replayCount = 0;
  DateTime? _questionStartedAt;
  List<ExerciseAttempt> _attempts = const [];

  PracticeStage get stage {
    return _stage;
  }

  ExerciseConfig? get draftConfig {
    return _draftConfig;
  }

  ExerciseConfig? get config {
    return _config;
  }

  IntervalQuestion? get question {
    return _question;
  }

  int get questionNumber {
    return _questionNumber;
  }

  int get questionCount {
    return _config?.questionCount ?? 0;
  }

  bool get isPlaying {
    return _isPlaying;
  }

  MusicInterval? get selected {
    return _selected;
  }

  bool get showResult {
    return _currentAttempt != null;
  }

  bool get isCorrect {
    return _currentAttempt?.correct ?? false;
  }

  bool get hesitated {
    return _hesitated;
  }

  int get replayCount {
    return _replayCount;
  }

  /// Whether a manual replay is still allowed for the current question.
  bool get canReplay {
    final config = _config;

    if (config == null || _stage != PracticeStage.active || _isPlaying) {
      return false;
    }

    if (config.allowsUnlimitedReplays) {
      return true;
    }

    return _replayCount < config.replayLimit!;
  }

  List<ExerciseAttempt> get attempts {
    return _attempts;
  }

  // --- Catalogue and setup navigation ---

  /// Returns to the exercise catalogue and clears any finished session.
  void returnToExercises() {
    _stage = PracticeStage.catalogue;
    _resetSessionState();
    notifyListeners();
  }

  /// Opens the shared setup screen for [type] with its default configuration.
  void configureExercise(ExerciseType type) {
    _draftConfig = ExerciseConfig.defaults(type);
    _stage = PracticeStage.setup;
    notifyListeners();
  }

  /// Replaces the setup draft while the learner edits the configuration.
  void updateDraftConfig(ExerciseConfig config) {
    _draftConfig = config;
    notifyListeners();
  }

  // --- Session lifecycle ---

  /// Starts a session from [config], or from the current [draftConfig].
  Future<void> startExercise([ExerciseConfig? config]) async {
    final resolved = config ?? _draftConfig;

    if (resolved == null) {
      return;
    }

    _config = resolved;
    _stage = PracticeStage.active;
    _attempts = const [];
    _questionNumber = 0;
    await _loadNextQuestion();
  }

  /// Replays the same configuration from the summary screen.
  Future<void> repeatSession() async {
    final config = _config;

    if (config == null) {
      return;
    }

    await startExercise(config);
  }

  /// Builds a focused session from the intervals missed or skipped this run.
  Future<void> retryMistakes() async {
    final config = _config;

    if (config == null) {
      return;
    }

    final missed = _missedIntervals();

    if (missed.isEmpty) {
      return;
    }

    await startExercise(
      config.copyWith(intervals: missed, questionCount: missed.length),
    );
  }

  /// Restarts with a harder configuration: every interval, more choices, fewer
  /// replays, and no direction hint.
  Future<void> increaseDifficulty() async {
    final config = _config;

    if (config == null) {
      return;
    }

    final harder = config.copyWith(
      intervals: MusicInterval.values,
      choiceCount: min(6, MusicInterval.values.length),
      replayLimit: config.replayLimit == null
          ? 2
          : max(0, config.replayLimit! - 1),
      showDirectionBeforeAnswer: false,
    );

    await startExercise(harder);
  }

  // --- In-session actions ---

  /// Plays the current interval. [isReplay] false marks the automatic first
  /// playback, which never counts against the replay limit.
  Future<void> playCurrent({bool isReplay = true}) async {
    final question = _question;

    if (question == null || _isPlaying) {
      return;
    }

    if (isReplay) {
      if (!canReplay) {
        return;
      }

      _replayCount += 1;
    }

    _isPlaying = true;
    notifyListeners();

    try {
      await audioEngine.playInterval(question.playback);
    } catch (error) {
      debugPrint('Audio playback failed: $error');
    } finally {
      _isPlaying = false;
      notifyListeners();
    }
  }

  void selectAnswer(MusicInterval choice) {
    final question = _question;
    final startedAt = _questionStartedAt;

    if (question == null ||
        startedAt == null ||
        _currentAttempt != null ||
        _isPlaying ||
        _stage != PracticeStage.active) {
      return;
    }

    _selected = choice;
    _currentAttempt = _buildAttempt(selected: choice, startedAt: startedAt);
    notifyListeners();

    if (_config!.immediateFeedback && !_currentAttempt!.correct) {
      unawaited(compareAnswer());
    }
  }

  /// Flags the current answer as "I knew it but hesitated" (spec section 3).
  void markHesitation() {
    final attempt = _currentAttempt;

    if (attempt == null || _hesitated) {
      return;
    }

    _hesitated = true;
    _currentAttempt = _copyAttempt(attempt, hesitated: true);
    notifyListeners();
  }

  Future<void> compareAnswer() async {
    final question = _question;
    final selected = _selected;

    if (question == null || selected == null) {
      return;
    }

    _isPlaying = true;
    notifyListeners();

    try {
      await audioEngine.playComparison(
        correct: question.playback,
        selected: question.playbackFor(selected),
      );
    } catch (error) {
      debugPrint('Audio playback failed: $error');
    } finally {
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> skip() async {
    final startedAt = _questionStartedAt;

    if (startedAt == null ||
        _currentAttempt != null ||
        _isPlaying ||
        _stage != PracticeStage.active) {
      return;
    }

    _currentAttempt = _buildAttempt(selected: null, startedAt: startedAt);
    await _advance();
  }

  Future<void> next() async {
    if (_currentAttempt == null || _isPlaying || _stage != PracticeStage.active) {
      return;
    }

    await _advance();
  }

  // --- Internals ---

  Future<void> _advance() async {
    final attempt = _currentAttempt;

    if (attempt != null) {
      _attempts = List.unmodifiable([..._attempts, attempt]);
    }

    _currentAttempt = null;

    if (_questionNumber >= questionCount) {
      _finishSession();

      return;
    }

    await _loadNextQuestion();
  }

  void _finishSession() {
    _stage = PracticeStage.summary;
    _question = null;
    _selected = null;
    _questionStartedAt = null;
    onSessionCompleted(_attempts);
    notifyListeners();
  }

  Future<void> _loadNextQuestion() async {
    final config = _config!;

    _question = _generator.next(
      pool: config.intervals,
      instrument: config.instrument,
      allowedDirections: config.directions,
      choiceCount: config.choiceCount,
      minimumRootMidi: config.minimumRootMidi,
      maximumRootMidi: config.maximumRootMidi,
    );
    _questionNumber += 1;
    _selected = null;
    _currentAttempt = null;
    _hesitated = false;
    _replayCount = 0;
    _questionStartedAt = null;
    notifyListeners();

    if (config.autoPlay) {
      await playCurrent(isReplay: false);
    }

    _questionStartedAt = DateTime.now();
    notifyListeners();
  }

  ExerciseAttempt _buildAttempt({
    required MusicInterval? selected,
    required DateTime startedAt,
  }) {
    final question = _question!;

    return ExerciseAttempt(
      type: _config!.type,
      expected: question.interval,
      selected: selected,
      direction: question.direction,
      instrument: question.instrument,
      replayCount: _replayCount,
      hesitated: _hesitated,
      responseTime: DateTime.now().difference(startedAt),
      occurredAt: DateTime.now(),
    );
  }

  ExerciseAttempt _copyAttempt(
    ExerciseAttempt attempt, {
    required bool hesitated,
  }) {
    return ExerciseAttempt(
      type: attempt.type,
      expected: attempt.expected,
      selected: attempt.selected,
      direction: attempt.direction,
      instrument: attempt.instrument,
      replayCount: attempt.replayCount,
      hesitated: hesitated,
      responseTime: attempt.responseTime,
      occurredAt: attempt.occurredAt,
    );
  }

  List<MusicInterval> _missedIntervals() {
    final missed = <MusicInterval>[];

    for (final attempt in _attempts) {
      if (attempt.correct) {
        continue;
      }

      if (!missed.contains(attempt.expected)) {
        missed.add(attempt.expected);
      }
    }

    return missed;
  }

  void _resetSessionState() {
    _config = null;
    _question = null;
    _questionNumber = 0;
    _selected = null;
    _currentAttempt = null;
    _hesitated = false;
    _replayCount = 0;
    _questionStartedAt = null;
    _attempts = const [];
  }
}
