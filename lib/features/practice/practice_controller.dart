import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/session/interval_outcome.dart';
import 'package:perfect_pitch/core/session/interval_question.dart';
import 'package:perfect_pitch/core/session/interval_question_generator.dart';

/// Reports the outcomes of a finished practice run so mastery can be persisted.
typedef PracticeSessionCompleted = void Function(List<IntervalOutcome> outcomes);

/// Drives the ear-recognition loop of the Practice tab: play an interval,
/// collect an answer, reveal the result, then move on. Sessions roll over
/// continuously (there is no summary screen in the design), recording mastery
/// each time a run of [questionCount] questions completes.
class PracticeController extends ChangeNotifier {
  PracticeController({
    required this.audioEngine,
    required this.onSessionCompleted,
    IntervalQuestionGenerator? generator,
    List<MusicInterval>? pool,
    this.instrument = Instrument.piano,
    this.direction = IntervalDirection.ascending,
    this.questionCount = 10,
  }) : _generator = generator ?? IntervalQuestionGenerator(),
       _pool = pool ?? MusicInterval.upToStage(3);

  final AudioEngine audioEngine;
  final PracticeSessionCompleted onSessionCompleted;
  final IntervalQuestionGenerator _generator;
  final List<MusicInterval> _pool;
  final Instrument instrument;
  final IntervalDirection direction;
  final int questionCount;

  IntervalQuestion? _question;
  int _questionNumber = 0;
  bool _isPlaying = false;
  MusicInterval? _selected;
  IntervalOutcome? _outcome;
  bool _hesitated = false;
  DateTime? _questionStartedAt;
  List<IntervalOutcome> _outcomes = const [];
  bool _started = false;

  IntervalQuestion? get question {
    return _question;
  }

  int get questionNumber {
    return _questionNumber;
  }

  bool get isPlaying {
    return _isPlaying;
  }

  MusicInterval? get selected {
    return _selected;
  }

  bool get showResult {
    return _outcome != null;
  }

  bool get isCorrect {
    return _outcome?.isCorrect ?? false;
  }

  bool get hesitated {
    return _hesitated;
  }

  bool get hasStarted {
    return _started;
  }

  /// Starts the first session if it has not begun yet.
  void ensureStarted() {
    if (_started) {
      return;
    }

    startSession();
  }

  void startSession() {
    _started = true;
    _outcomes = const [];
    _questionNumber = 0;
    _loadNextQuestion();
  }

  Future<void> playCurrent() async {
    final question = _question;

    if (question == null || _isPlaying) {
      return;
    }

    _isPlaying = true;
    notifyListeners();

    await audioEngine.playInterval(question.playback);

    _isPlaying = false;
    notifyListeners();
  }

  void selectAnswer(MusicInterval choice) {
    final question = _question;
    final startedAt = _questionStartedAt;

    if (question == null || startedAt == null || _outcome != null) {
      return;
    }

    _selected = choice;
    _outcome = IntervalOutcome(
      question: question,
      selected: choice,
      responseTime: DateTime.now().difference(startedAt),
      hesitated: false,
    );
    _outcomes = List.unmodifiable([..._outcomes, _outcome!]);
    notifyListeners();

    if (!_outcome!.isCorrect) {
      unawaited(compareAnswer());
    }
  }

  /// Flags the current answer as "I knew it but hesitated" (spec section 3).
  void markHesitation() {
    final outcome = _outcome;

    if (outcome == null || _hesitated) {
      return;
    }

    _hesitated = true;
    final updated = IntervalOutcome(
      question: outcome.question,
      selected: outcome.selected,
      responseTime: outcome.responseTime,
      hesitated: true,
    );
    _outcomes = List.unmodifiable([
      ..._outcomes.take(_outcomes.length - 1),
      updated,
    ]);
    notifyListeners();
  }

  Future<void> compareAnswer() async {
    final outcome = _outcome;

    if (outcome == null) {
      return;
    }

    await audioEngine.playComparison(
      correct: outcome.question.playback,
      selected: outcome.question.playbackFor(outcome.selected),
    );
  }

  void skip() {
    if (_outcome != null) {
      return;
    }

    _advance();
  }

  void next() {
    _advance();
  }

  void _advance() {
    if (_questionNumber >= questionCount) {
      onSessionCompleted(_outcomes);
      startSession();
      return;
    }

    _loadNextQuestion();
  }

  void _loadNextQuestion() {
    _question = _generator.next(
      pool: _pool,
      instrument: instrument,
      direction: direction,
    );
    _questionNumber += 1;
    _selected = null;
    _outcome = null;
    _hesitated = false;
    _questionStartedAt = DateTime.now();
    notifyListeners();
    unawaited(playCurrent());
  }
}
