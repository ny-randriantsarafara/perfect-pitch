import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/exercises/session_difficulty.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';

extension ExerciseTypeLabels on ExerciseType {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case ExerciseType.ascendingIntervals:
        return l10n.exerciseAscendingLabel;
      case ExerciseType.descendingIntervals:
        return l10n.exerciseDescendingLabel;
      case ExerciseType.harmonicIntervals:
        return l10n.exerciseHarmonicLabel;
      case ExerciseType.mixedIntervals:
        return l10n.exerciseMixedLabel;
    }
  }

  String localizedDescription(AppLocalizations l10n) {
    switch (this) {
      case ExerciseType.ascendingIntervals:
        return l10n.exerciseAscendingDescription;
      case ExerciseType.descendingIntervals:
        return l10n.exerciseDescendingDescription;
      case ExerciseType.harmonicIntervals:
        return l10n.exerciseHarmonicDescription;
      case ExerciseType.mixedIntervals:
        return l10n.exerciseMixedDescription;
    }
  }
}

extension SessionDifficultyLabels on SessionDifficulty {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case SessionDifficulty.beginner:
        return l10n.difficultyBeginner;
      case SessionDifficulty.easy:
        return l10n.difficultyEasy;
      case SessionDifficulty.medium:
        return l10n.difficultyMedium;
      case SessionDifficulty.hard:
        return l10n.difficultyHard;
    }
  }
}

extension TrainingModeLabels on TrainingMode {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case TrainingMode.ascending:
        return l10n.trainingModeAscending;
      case TrainingMode.descending:
        return l10n.trainingModeDescending;
      case TrainingMode.harmonic:
        return l10n.trainingModeHarmonic;
      case TrainingMode.guitar:
        return l10n.trainingModeGuitar;
    }
  }
}

extension IntervalDirectionLabels on IntervalDirection {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case IntervalDirection.ascending:
        return l10n.directionAscending;
      case IntervalDirection.descending:
        return l10n.directionDescending;
      case IntervalDirection.harmonic:
        return l10n.directionHarmonic;
    }
  }
}

extension InstrumentLabels on Instrument {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case Instrument.sine:
        return l10n.instrumentSine;
      case Instrument.warmSynth:
        return l10n.instrumentWarmSynth;
      case Instrument.piano:
        return l10n.instrumentPiano;
      case Instrument.guitar:
        return l10n.instrumentGuitar;
    }
  }
}

extension MusicIntervalLabels on MusicInterval {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case MusicInterval.unison:
        return l10n.intervalUnisonLabel;
      case MusicInterval.minorSecond:
        return l10n.intervalMinorSecondLabel;
      case MusicInterval.majorSecond:
        return l10n.intervalMajorSecondLabel;
      case MusicInterval.minorThird:
        return l10n.intervalMinorThirdLabel;
      case MusicInterval.majorThird:
        return l10n.intervalMajorThirdLabel;
      case MusicInterval.perfectFourth:
        return l10n.intervalPerfectFourthLabel;
      case MusicInterval.tritone:
        return l10n.intervalTritoneLabel;
      case MusicInterval.perfectFifth:
        return l10n.intervalPerfectFifthLabel;
      case MusicInterval.minorSixth:
        return l10n.intervalMinorSixthLabel;
      case MusicInterval.majorSixth:
        return l10n.intervalMajorSixthLabel;
      case MusicInterval.minorSeventh:
        return l10n.intervalMinorSeventhLabel;
      case MusicInterval.majorSeventh:
        return l10n.intervalMajorSeventhLabel;
      case MusicInterval.octave:
        return l10n.intervalOctaveLabel;
    }
  }

  String localizedSensation(AppLocalizations l10n) {
    switch (this) {
      case MusicInterval.unison:
        return l10n.intervalUnisonSensation;
      case MusicInterval.minorSecond:
        return l10n.intervalMinorSecondSensation;
      case MusicInterval.majorSecond:
        return l10n.intervalMajorSecondSensation;
      case MusicInterval.minorThird:
        return l10n.intervalMinorThirdSensation;
      case MusicInterval.majorThird:
        return l10n.intervalMajorThirdSensation;
      case MusicInterval.perfectFourth:
        return l10n.intervalPerfectFourthSensation;
      case MusicInterval.tritone:
        return l10n.intervalTritoneSensation;
      case MusicInterval.perfectFifth:
        return l10n.intervalPerfectFifthSensation;
      case MusicInterval.minorSixth:
        return l10n.intervalMinorSixthSensation;
      case MusicInterval.majorSixth:
        return l10n.intervalMajorSixthSensation;
      case MusicInterval.minorSeventh:
        return l10n.intervalMinorSeventhSensation;
      case MusicInterval.majorSeventh:
        return l10n.intervalMajorSeventhSensation;
      case MusicInterval.octave:
        return l10n.intervalOctaveSensation;
    }
  }
}
