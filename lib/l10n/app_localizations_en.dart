// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Intervals.pro';

  @override
  String get navHome => 'Home';

  @override
  String get navExercises => 'Exercises';

  @override
  String get navGuitar => 'Guitar';

  @override
  String get navProgress => 'Progress';

  @override
  String streakDays(int days) {
    return '$days days';
  }

  @override
  String get streakLabel => 'Current streak';

  @override
  String streakDaysUppercase(int days) {
    return '$days Days';
  }

  @override
  String get homeGreeting => 'Hello!';

  @override
  String get homeSubtitle => 'Your ear training is waiting.';

  @override
  String get homeTodaySession => 'TODAY\'S SESSION';

  @override
  String get homeSessionTitle => 'Perfect Fifth\n& Comparison';

  @override
  String get homeSessionSubtitle => 'Warm-up, new interval, and practice.';

  @override
  String get homeStartFiveMinutes => 'Start (5 min)';

  @override
  String get homeRepertoire => 'Your repertoire';

  @override
  String get homeSeeAll => 'SEE ALL';

  @override
  String get discover => 'Not started';

  @override
  String get learning => 'Learning';

  @override
  String masteredAt(int percentage) {
    return 'Mastered at $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Unison\n& Octave';

  @override
  String get repertoirePerfectFifth => 'Perfect\nFifth';

  @override
  String get practiceMode => 'PRACTICE MODE';

  @override
  String get guitarTitle => 'Fretboard';

  @override
  String get guitarPromptPrefix => 'Find the ';

  @override
  String get guitarPromptSuffix => ' from the glowing root note.';

  @override
  String get guitarNextInterval => 'Next interval';

  @override
  String get exercisesTitle => 'Exercises';

  @override
  String get exercisesSubtitle => 'Choose an ear-training exercise.';

  @override
  String get startSession => 'Start session';

  @override
  String get settings => 'SETTINGS';

  @override
  String get intervalQuestionPrompt => 'What interval is this?';

  @override
  String get languagePickerTooltip => 'Choose language';
}
