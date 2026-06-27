import 'dart:async';
import 'dart:js_interop';

import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';
import 'package:web/web.dart';

AudioPlayer createAudioPlayer() {
  return WebSynthAudioPlayer();
}

class WebSynthAudioPlayer implements AudioPlayer {
  WebSynthAudioPlayer() : _audioContext = AudioContext();

  final AudioContext _audioContext;

  @override
  Future<void> play(AudioClipRequest request) async {
    await _audioContext.resume().toDart;

    final oscillator = _audioContext.createOscillator();
    final gain = _audioContext.createGain();
    final startTime = _audioContext.currentTime;
    final endTime = startTime + request.duration.inMilliseconds / 1000;

    oscillator.type = _waveformFor(request.instrumentId);
    oscillator.frequency.setValueAtTime(request.frequency, startTime);
    gain.gain.setValueAtTime(0.0001, startTime);
    gain.gain.exponentialRampToValueAtTime(0.24, startTime + 0.03);
    gain.gain.exponentialRampToValueAtTime(0.0001, endTime);
    oscillator.connect(gain);
    gain.connect(_audioContext.destination);
    oscillator.start(startTime);
    oscillator.stop(endTime);

    await Future<void>.delayed(request.duration);
  }

  String _waveformFor(InstrumentId instrumentId) {
    switch (instrumentId) {
      case InstrumentId.sine:
      case InstrumentId.piano:
      case InstrumentId.cleanElectricGuitar:
      case InstrumentId.acousticGuitar:
        return 'sine';
      case InstrumentId.warmSynth:
      case InstrumentId.synthesizer:
      case InstrumentId.random:
        return 'triangle';
    }
  }
}
