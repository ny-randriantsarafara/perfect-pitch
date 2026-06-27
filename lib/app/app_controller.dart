import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/question_generator.dart';
import 'package:perfect_pitch/core/session/session_result.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';
import 'package:perfect_pitch/core/session/session_stats.dart';
import 'package:perfect_pitch/core/storage/progress_repository.dart';

enum AppSection { home, learn, training, guidedPath, summary }

class PerfectPitchController extends ChangeNotifier {
  PerfectPitchController({
    required this.audioEngine,
    QuestionGenerator? questionGenerator,
    SessionSettings? initialSettings,
    ProgressRepository? progressRepository,
  }) : _questionGenerator = questionGenerator ?? QuestionGenerator(),
       _progressRepository = progressRepository ?? InMemoryProgressRepository(),
       _settings = initialSettings ?? SessionSettings.beginner();

  final AudioEngine audioEngine;
  final QuestionGenerator _questionGenerator;
  final ProgressRepository _progressRepository;

  AppSection _section = AppSection.home;
  SessionSettings _settings;
  int _learnNoteIndex = 0;
  List<TrainingQuestion> _questions = const [];
  List<QuestionOutcome> _outcomes = const [];
  int _currentQuestionIndex = 0;
  int _currentReplayCount = 0;
  DateTime? _questionStartedAt;
  DateTime? _sessionStartedAt;
  QuestionOutcome? _lastOutcome;
  bool _isGuidedSession = false;

  AppSection get section {
    return _section;
  }

  SessionSettings get settings {
    return _settings;
  }

  MusicNote get learnNote {
    return MusicNote.naturalNotes[_learnNoteIndex];
  }

  TrainingQuestion? get currentQuestion {
    if (_questions.isEmpty || _currentQuestionIndex >= _questions.length) {
      return null;
    }

    return _questions[_currentQuestionIndex];
  }

  QuestionOutcome? get lastOutcome {
    return _lastOutcome;
  }

  SessionStats get sessionStats {
    return SessionStats.fromOutcomes(_outcomes);
  }

  int get questionNumber {
    return _currentQuestionIndex + 1;
  }

  int get totalQuestions {
    return _questions.length;
  }

  bool get isShowingResult {
    return _lastOutcome != null;
  }

  void showHome() {
    _section = AppSection.home;
    notifyListeners();
  }

  void showLearn() {
    _section = AppSection.learn;
    notifyListeners();
  }

  void showGuidedPath() {
    _section = AppSection.guidedPath;
    notifyListeners();
  }

  void nextLearnNote() {
    _learnNoteIndex = (_learnNoteIndex + 1) % MusicNote.naturalNotes.length;
    notifyListeners();
  }

  void playLearnNote() {
    final request = AudioClipRequest(
      note: learnNote,
      octave: _settings.enabledOctaves.first,
      instrumentId: _settings.instrumentId,
    );

    unawaited(audioEngine.play(request));
  }

  void startTraining({SessionSettings? settings}) {
    _settings = settings ?? _settings;
    _section = AppSection.training;
    _questions = _questionGenerator.generate(_settings);
    _outcomes = const [];
    _currentQuestionIndex = 0;
    _currentReplayCount = 0;
    _lastOutcome = null;
    _sessionStartedAt = DateTime.now();
    _questionStartedAt = DateTime.now();
    notifyListeners();
    playCurrentQuestion();
  }

  void startGuidedStep() {
    _isGuidedSession = true;
    startTraining(
      settings: SessionSettings.beginner(notes: const [MusicNote.doNote]),
    );
  }

  void playCurrentQuestion() {
    final question = currentQuestion;

    if (question == null) {
      return;
    }

    final request = AudioClipRequest(
      note: question.note,
      octave: question.octave,
      instrumentId: _settings.instrumentId,
    );
    _currentReplayCount += 1;

    unawaited(audioEngine.play(request));
    notifyListeners();
  }

  void answer(MusicNote selectedNote) {
    final question = currentQuestion;
    final startedAt = _questionStartedAt;

    if (question == null || startedAt == null || _lastOutcome != null) {
      return;
    }

    final responseTime = DateTime.now().difference(startedAt);
    final outcome = _buildOutcome(
      question: question,
      selectedNote: selectedNote,
      responseTime: responseTime,
    );

    _lastOutcome = outcome;
    _outcomes = List.unmodifiable([..._outcomes, outcome]);
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex + 1 >= _questions.length) {
      _completeSession();
      return;
    }

    _currentQuestionIndex += 1;
    _currentReplayCount = 0;
    _lastOutcome = null;
    _questionStartedAt = DateTime.now();
    notifyListeners();
    playCurrentQuestion();
  }

  void replayCorrectNote() {
    final outcome = _lastOutcome;

    if (outcome == null) {
      return;
    }

    unawaited(audioEngine.play(_requestFor(outcome.note, outcome.octave)));
  }

  void replaySelectedNote() {
    final outcome = _lastOutcome;

    if (outcome == null) {
      return;
    }

    unawaited(
      audioEngine.play(_requestFor(outcome.selectedNote, outcome.octave)),
    );
  }

  void compareLastAnswer() {
    final outcome = _lastOutcome;

    if (outcome == null) {
      return;
    }

    final sequence = ComparisonSequence(
      correct: _requestFor(outcome.note, outcome.octave),
      selected: _requestFor(outcome.selectedNote, outcome.octave),
    );

    unawaited(audioEngine.playComparison(sequence));
  }

  AudioClipRequest _requestFor(MusicNote note, int octave) {
    return AudioClipRequest(
      note: note,
      octave: octave,
      instrumentId: _settings.instrumentId,
    );
  }

  QuestionOutcome _buildOutcome({
    required TrainingQuestion question,
    required MusicNote selectedNote,
    required Duration responseTime,
  }) {
    if (question.note == selectedNote) {
      return QuestionOutcome.correct(
        note: question.note,
        octave: question.octave,
        responseTime: responseTime,
        replayCount: _currentReplayCount,
      );
    }

    return QuestionOutcome.incorrect(
      note: question.note,
      selectedNote: selectedNote,
      octave: question.octave,
      responseTime: responseTime,
      replayCount: _currentReplayCount,
    );
  }

  void _completeSession() {
    final startedAt = _sessionStartedAt;
    final trainingTime = startedAt == null
        ? Duration.zero
        : DateTime.now().difference(startedAt);

    _section = AppSection.summary;
    _lastOutcome = null;
    notifyListeners();

    unawaited(
      _progressRepository.recordSession(
        outcomes: _outcomes,
        trainingTime: trainingTime,
      ),
    );

    if (!_isGuidedSession) {
      return;
    }

    _isGuidedSession = false;
    unawaited(_progressRepository.saveGuidedPathStep(2));
  }
}
