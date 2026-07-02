/// Timbre used to synthesize a tone.
///
/// The MVP relies on browser-local oscillator synthesis, so each instrument
/// maps to an oscillator waveform. The abstraction leaves room for bundled
/// samples later without changing the calling code.
enum Instrument {
  sine,
  warmSynth,
  piano,
  guitar;

  String get waveform {
    switch (this) {
      case Instrument.sine:
      case Instrument.piano:
        return 'sine';
      case Instrument.warmSynth:
        return 'triangle';
      case Instrument.guitar:
        return 'sawtooth';
    }
  }
}
