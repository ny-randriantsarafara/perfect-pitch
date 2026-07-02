import 'dart:js_interop';

import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:web/web.dart';

AudioPlayer createAudioPlayer() {
  return WebSynthAudioPlayer();
}

/// Renders tones with the Web Audio API oscillator, applying a short attack /
/// release envelope so notes do not click.
class WebSynthAudioPlayer implements AudioPlayer {
  WebSynthAudioPlayer() : _audioContext = AudioContext();

  final AudioContext _audioContext;

  @override
  Future<void> playTone(ToneRequest request) async {
    await _audioContext.resume().toDart;
    _schedule(request, _audioContext.currentTime);
    await Future<void>.delayed(request.duration);
  }

  @override
  Future<void> playChord(List<ToneRequest> requests) async {
    if (requests.isEmpty) {
      return;
    }

    await _audioContext.resume().toDart;
    final startTime = _audioContext.currentTime;

    for (final request in requests) {
      _schedule(request, startTime);
    }

    final longest = requests
        .map((request) => request.duration)
        .reduce((a, b) => a > b ? a : b);

    await Future<void>.delayed(longest);
  }

  void _schedule(ToneRequest request, double startTime) {
    final oscillator = _audioContext.createOscillator();
    final gain = _audioContext.createGain();
    final endTime = startTime + request.duration.inMilliseconds / 1000;

    oscillator.type = request.instrument.waveform;
    oscillator.frequency.setValueAtTime(request.frequency, startTime);
    gain.gain.setValueAtTime(0.0001, startTime);
    gain.gain.exponentialRampToValueAtTime(0.22, startTime + 0.03);
    gain.gain.exponentialRampToValueAtTime(0.0001, endTime);
    oscillator.connect(gain);
    gain.connect(_audioContext.destination);
    oscillator.start(startTime);
    oscillator.stop(endTime);
  }
}
