import 'dart:math' as math;
import 'dart:typed_data';

import 'package:perfect_pitch/core/audio/instrument.dart';

class SynthWav {
  const SynthWav._();

  static const int sampleRate = 44100;
  static const int _channelCount = 1;
  static const int _bitsPerSample = 16;
  static const double _amplitude = 0.22;

  static Uint8List encodeTone({
    required double frequency,
    required Instrument instrument,
    required Duration duration,
  }) {
    final sampleCount = math.max(
      1,
      (sampleRate * duration.inMicroseconds / Duration.microsecondsPerSecond)
          .round(),
    );
    final dataSize = sampleCount * _channelCount * (_bitsPerSample ~/ 8);
    final bytes = Uint8List(44 + dataSize);
    final data = ByteData.sublistView(bytes);

    _writeAscii(bytes, 0, 'RIFF');
    data.setUint32(4, 36 + dataSize, Endian.little);
    _writeAscii(bytes, 8, 'WAVE');
    _writeAscii(bytes, 12, 'fmt ');
    data.setUint32(16, 16, Endian.little);
    data.setUint16(20, 1, Endian.little);
    data.setUint16(22, _channelCount, Endian.little);
    data.setUint32(24, sampleRate, Endian.little);
    data.setUint32(
      28,
      sampleRate * _channelCount * (_bitsPerSample ~/ 8),
      Endian.little,
    );
    data.setUint16(32, _channelCount * (_bitsPerSample ~/ 8), Endian.little);
    data.setUint16(34, _bitsPerSample, Endian.little);
    _writeAscii(bytes, 36, 'data');
    data.setUint32(40, dataSize, Endian.little);

    for (var i = 0; i < sampleCount; i += 1) {
      final seconds = i / sampleRate;
      final sample = _waveform(instrument, frequency, seconds);
      final envelope = _envelope(i, sampleCount);
      final value = (sample * envelope * _amplitude * 32767).round();
      data.setInt16(44 + i * 2, value.clamp(-32768, 32767), Endian.little);
    }

    return bytes;
  }

  static void _writeAscii(Uint8List bytes, int offset, String value) {
    for (var i = 0; i < value.length; i += 1) {
      bytes[offset + i] = value.codeUnitAt(i);
    }
  }

  static double _waveform(
    Instrument instrument,
    double frequency,
    double seconds,
  ) {
    final phase = 2 * math.pi * frequency * seconds;

    switch (instrument) {
      case Instrument.sine:
      case Instrument.piano:
        return math.sin(phase);
      case Instrument.warmSynth:
        return 2 / math.pi * math.asin(math.sin(phase));
      case Instrument.guitar:
        return 2 * (frequency * seconds - (frequency * seconds + 0.5).floor());
    }
  }

  static double _envelope(int index, int sampleCount) {
    final attackSamples = math.max(1, (sampleRate * 0.03).round());
    final releaseSamples = attackSamples;

    final attack = math.min(1.0, index / attackSamples);
    final remaining = sampleCount - index - 1;
    final release = math.min(1.0, remaining / releaseSamples);

    return math.min(attack, release);
  }
}
