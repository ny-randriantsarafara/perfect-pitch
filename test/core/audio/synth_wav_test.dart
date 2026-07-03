import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/audio/synth_wav.dart';

void main() {
  group('SynthWav', () {
    test('encodes a mono 16-bit PCM wav file for a tone', () {
      final bytes = SynthWav.encodeTone(
        frequency: 440,
        instrument: Instrument.sine,
        duration: const Duration(milliseconds: 250),
      );
      final data = ByteData.sublistView(bytes);

      expect(ascii.decode(bytes.sublist(0, 4)), 'RIFF');
      expect(ascii.decode(bytes.sublist(8, 12)), 'WAVE');
      expect(ascii.decode(bytes.sublist(12, 16)), 'fmt ');
      expect(ascii.decode(bytes.sublist(36, 40)), 'data');
      expect(data.getUint16(20, Endian.little), 1);
      expect(data.getUint16(22, Endian.little), 1);
      expect(data.getUint32(24, Endian.little), SynthWav.sampleRate);
      expect(data.getUint16(34, Endian.little), 16);

      final sampleCount = SynthWav.sampleRate ~/ 4;
      final dataSize = sampleCount * 2;
      expect(data.getUint32(40, Endian.little), dataSize);
      expect(bytes.length, 44 + dataSize);
    });

    test('uses different waveforms for different instruments', () {
      final sine = SynthWav.encodeTone(
        frequency: 220,
        instrument: Instrument.sine,
        duration: const Duration(milliseconds: 100),
      );
      final guitar = SynthWav.encodeTone(
        frequency: 220,
        instrument: Instrument.guitar,
        duration: const Duration(milliseconds: 100),
      );

      expect(guitar, isNot(sine));
    });
  });
}
