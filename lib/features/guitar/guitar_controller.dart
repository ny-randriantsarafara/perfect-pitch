import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/music/pitch.dart';

/// A cell on the fretboard, addressed by string row (0 = high e at the top,
/// matching the visual order) and fret column (0 = first fret after the nut).
@immutable
class FretPosition {
  const FretPosition({required this.string, required this.fret});

  final int string;
  final int fret;

  @override
  bool operator ==(Object other) {
    return other is FretPosition &&
        other.string == string &&
        other.fret == fret;
  }

  @override
  int get hashCode {
    return Object.hash(string, fret);
  }
}

/// Reports a graded fretboard answer so guitar mastery can be persisted.
typedef GuitarAttemptRecorded =
    void Function({required MusicInterval interval, required bool correct});

/// Drives the guitar tab: light up a root note, ask the learner to find a given
/// interval above it on the neck, then grade the tapped position with real
/// fretboard math (standard tuning).
class GuitarController extends ChangeNotifier {
  GuitarController({
    required this.audioEngine,
    required this.onAttemptRecorded,
    Random? random,
  }) : _random = random ?? Random();

  final AudioEngine audioEngine;
  final GuitarAttemptRecorded onAttemptRecorded;
  final Random _random;

  /// Standard tuning MIDI notes, top row (high e) to bottom row (low E), so the
  /// index matches the on-screen string order.
  static const List<int> openStringMidi = [64, 59, 55, 50, 45, 40];

  /// Frets used when generating challenges. Kept within the mobile fret count
  /// so answers are always reachable on both layouts.
  static const int _maxGenerationFret = 8;

  static const List<MusicInterval> _intervalPool = [
    MusicInterval.majorThird,
    MusicInterval.perfectFourth,
    MusicInterval.perfectFifth,
    MusicInterval.octave,
  ];

  late FretPosition _root = _pickRoot();
  late MusicInterval _interval = MusicInterval.perfectFifth;
  FretPosition? _selected;
  bool _showResult = false;
  bool _lastAnswerCorrect = false;

  FretPosition get root {
    return _root;
  }

  MusicInterval get interval {
    return _interval;
  }

  FretPosition? get selected {
    return _selected;
  }

  bool get showResult {
    return _showResult;
  }

  bool get lastAnswerCorrect {
    return _lastAnswerCorrect;
  }

  int midiAt(FretPosition position) {
    return openStringMidi[position.string] + position.fret;
  }

  bool isRoot(FretPosition position) {
    return position == _root;
  }

  bool isCorrectTarget(FretPosition position) {
    if (position == _root) {
      return false;
    }

    return midiAt(position) - midiAt(_root) == _interval.semitones;
  }

  /// The correct answer revealed after a wrong guess: the nearest valid target.
  FretPosition? revealedTarget({required int fretCount}) {
    FretPosition? best;
    var bestDistance = 1 << 30;

    for (var string = 0; string < openStringMidi.length; string += 1) {
      for (var fret = 0; fret < fretCount; fret += 1) {
        final candidate = FretPosition(string: string, fret: fret);

        if (!isCorrectTarget(candidate)) {
          continue;
        }

        final distance =
            (string - _root.string).abs() + (fret - _root.fret).abs();

        if (distance < bestDistance) {
          bestDistance = distance;
          best = candidate;
        }
      }
    }

    return best;
  }

  Future<void> selectPosition(FretPosition position) async {
    if (_showResult || position == _root) {
      return;
    }

    _selected = position;
    _lastAnswerCorrect = isCorrectTarget(position);
    _showResult = true;
    notifyListeners();

    onAttemptRecorded(interval: _interval, correct: _lastAnswerCorrect);
    await _playFrom(position);
  }

  Future<void> playRoot() async {
    await _playFrom(_root);
  }

  void nextChallenge() {
    _root = _pickRoot();
    _interval = _intervalPool[_random.nextInt(_intervalPool.length)];
    _selected = null;
    _showResult = false;
    _lastAnswerCorrect = false;
    notifyListeners();
  }

  Future<void> _playFrom(FretPosition position) {
    return audioEngine.playPitch(
      Pitch(midiAt(position)),
      instrument: Instrument.guitar,
    );
  }

  FretPosition _pickRoot() {
    final string = _random.nextInt(openStringMidi.length);
    final fret = _random.nextInt(_maxGenerationFret);

    return FretPosition(string: string, fret: fret);
  }
}
