import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'The Perfect Pitch'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navExercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get navExercises;

  /// No description provided for @navGuitar.
  ///
  /// In en, this message translates to:
  /// **'Guitar'**
  String get navGuitar;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String streakDays(int days);

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get streakLabel;

  /// No description provided for @streakDaysUppercase.
  ///
  /// In en, this message translates to:
  /// **'{days} Days'**
  String streakDaysUppercase(int days);

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get homeGreeting;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your ear training is waiting.'**
  String get homeSubtitle;

  /// No description provided for @homeTodaySession.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S SESSION'**
  String get homeTodaySession;

  /// No description provided for @homeSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfect Fifth\n& Comparison'**
  String get homeSessionTitle;

  /// No description provided for @homeSessionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Warm-up, new interval, and practice.'**
  String get homeSessionSubtitle;

  /// No description provided for @homeStartFiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'Start (5 min)'**
  String get homeStartFiveMinutes;

  /// No description provided for @homeRepertoire.
  ///
  /// In en, this message translates to:
  /// **'Your repertoire'**
  String get homeRepertoire;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'SEE ALL'**
  String get homeSeeAll;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get discover;

  /// No description provided for @learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learning;

  /// No description provided for @masteredAt.
  ///
  /// In en, this message translates to:
  /// **'Mastered at {percentage}%'**
  String masteredAt(int percentage);

  /// No description provided for @repertoireUnisonOctave.
  ///
  /// In en, this message translates to:
  /// **'Unison\n& Octave'**
  String get repertoireUnisonOctave;

  /// No description provided for @repertoirePerfectFifth.
  ///
  /// In en, this message translates to:
  /// **'Perfect\nFifth'**
  String get repertoirePerfectFifth;

  /// No description provided for @practiceMode.
  ///
  /// In en, this message translates to:
  /// **'PRACTICE MODE'**
  String get practiceMode;

  /// No description provided for @guitarTitle.
  ///
  /// In en, this message translates to:
  /// **'Fretboard'**
  String get guitarTitle;

  /// No description provided for @guitarPromptPrefix.
  ///
  /// In en, this message translates to:
  /// **'Find the '**
  String get guitarPromptPrefix;

  /// No description provided for @guitarPromptSuffix.
  ///
  /// In en, this message translates to:
  /// **' from the glowing root note.'**
  String get guitarPromptSuffix;

  /// No description provided for @guitarNextInterval.
  ///
  /// In en, this message translates to:
  /// **'Next interval'**
  String get guitarNextInterval;

  /// No description provided for @exercisesTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercisesTitle;

  /// No description provided for @exercisesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an ear-training exercise.'**
  String get exercisesSubtitle;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'Start session'**
  String get startSession;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings;

  /// No description provided for @intervalQuestionPrompt.
  ///
  /// In en, this message translates to:
  /// **'What interval is this?'**
  String get intervalQuestionPrompt;

  /// No description provided for @languagePickerTooltip.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get languagePickerTooltip;

  /// No description provided for @exerciseAscendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Ascending intervals'**
  String get exerciseAscendingLabel;

  /// No description provided for @exerciseAscendingDescription.
  ///
  /// In en, this message translates to:
  /// **'Low note, then high note.'**
  String get exerciseAscendingDescription;

  /// No description provided for @exerciseDescendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Descending intervals'**
  String get exerciseDescendingLabel;

  /// No description provided for @exerciseDescendingDescription.
  ///
  /// In en, this message translates to:
  /// **'High note, then low note.'**
  String get exerciseDescendingDescription;

  /// No description provided for @exerciseHarmonicLabel.
  ///
  /// In en, this message translates to:
  /// **'Harmonic intervals'**
  String get exerciseHarmonicLabel;

  /// No description provided for @exerciseHarmonicDescription.
  ///
  /// In en, this message translates to:
  /// **'Both notes played together.'**
  String get exerciseHarmonicDescription;

  /// No description provided for @exerciseMixedLabel.
  ///
  /// In en, this message translates to:
  /// **'Mixed intervals'**
  String get exerciseMixedLabel;

  /// No description provided for @exerciseMixedDescription.
  ///
  /// In en, this message translates to:
  /// **'Ascending, descending, or harmonic on each question.'**
  String get exerciseMixedDescription;

  /// No description provided for @difficultyBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get difficultyBeginner;

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get difficultyMedium;

  /// No description provided for @difficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get difficultyHard;

  /// No description provided for @trainingModeAscending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get trainingModeAscending;

  /// No description provided for @trainingModeDescending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get trainingModeDescending;

  /// No description provided for @trainingModeHarmonic.
  ///
  /// In en, this message translates to:
  /// **'Harmonic'**
  String get trainingModeHarmonic;

  /// No description provided for @trainingModeGuitar.
  ///
  /// In en, this message translates to:
  /// **'Guitar'**
  String get trainingModeGuitar;

  /// No description provided for @directionAscending.
  ///
  /// In en, this message translates to:
  /// **'ASCENDING'**
  String get directionAscending;

  /// No description provided for @directionDescending.
  ///
  /// In en, this message translates to:
  /// **'DESCENDING'**
  String get directionDescending;

  /// No description provided for @directionHarmonic.
  ///
  /// In en, this message translates to:
  /// **'HARMONIC'**
  String get directionHarmonic;

  /// No description provided for @instrumentSine.
  ///
  /// In en, this message translates to:
  /// **'Sine'**
  String get instrumentSine;

  /// No description provided for @instrumentWarmSynth.
  ///
  /// In en, this message translates to:
  /// **'Warm synth'**
  String get instrumentWarmSynth;

  /// No description provided for @instrumentPiano.
  ///
  /// In en, this message translates to:
  /// **'Piano'**
  String get instrumentPiano;

  /// No description provided for @instrumentGuitar.
  ///
  /// In en, this message translates to:
  /// **'Guitar'**
  String get instrumentGuitar;

  /// No description provided for @catalogueContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get catalogueContinue;

  /// No description provided for @catalogueStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get catalogueStart;

  /// No description provided for @masteryLabel.
  ///
  /// In en, this message translates to:
  /// **'Mastery {percentage}%'**
  String masteryLabel(int percentage);

  /// No description provided for @setupQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get setupQuestions;

  /// No description provided for @setupAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get setupAdvanced;

  /// No description provided for @setupIntervals.
  ///
  /// In en, this message translates to:
  /// **'Intervals'**
  String get setupIntervals;

  /// No description provided for @setupDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get setupDirections;

  /// No description provided for @setupChoicesPerQuestion.
  ///
  /// In en, this message translates to:
  /// **'Choices per question'**
  String get setupChoicesPerQuestion;

  /// No description provided for @setupUnlimitedReplays.
  ///
  /// In en, this message translates to:
  /// **'Unlimited replays'**
  String get setupUnlimitedReplays;

  /// No description provided for @setupReplayLimit.
  ///
  /// In en, this message translates to:
  /// **'Replay limit'**
  String get setupReplayLimit;

  /// No description provided for @setupLowNoteMidi.
  ///
  /// In en, this message translates to:
  /// **'Low note (MIDI)'**
  String get setupLowNoteMidi;

  /// No description provided for @setupHighNoteMidi.
  ///
  /// In en, this message translates to:
  /// **'High note (MIDI)'**
  String get setupHighNoteMidi;

  /// No description provided for @setupAutoPlay.
  ///
  /// In en, this message translates to:
  /// **'Auto-play'**
  String get setupAutoPlay;

  /// No description provided for @setupImmediateFeedback.
  ///
  /// In en, this message translates to:
  /// **'Immediate feedback'**
  String get setupImmediateFeedback;

  /// No description provided for @setupAnnounceDirection.
  ///
  /// In en, this message translates to:
  /// **'Announce direction'**
  String get setupAnnounceDirection;

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'QUESTION {current}/{total}'**
  String questionProgress(int current, int total);

  /// No description provided for @skipQuestion.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skipQuestion;

  /// No description provided for @replayUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited replays'**
  String get replayUnlimited;

  /// No description provided for @replayCount.
  ///
  /// In en, this message translates to:
  /// **'Replays: {count}/{limit}'**
  String replayCount(int count, int limit);

  /// No description provided for @directionUnknown.
  ///
  /// In en, this message translates to:
  /// **'DIRECTION?'**
  String get directionUnknown;

  /// No description provided for @resultSkippedAnswer.
  ///
  /// In en, this message translates to:
  /// **'Skipped - the answer was {expected}.'**
  String resultSkippedAnswer(String expected);

  /// No description provided for @resultWrongAnswer.
  ///
  /// In en, this message translates to:
  /// **'You chose {selected}; it was {expected} ({delta} semitones away).'**
  String resultWrongAnswer(String selected, String expected, int delta);

  /// No description provided for @resultHesitation.
  ///
  /// In en, this message translates to:
  /// **'HESITATION?'**
  String get resultHesitation;

  /// No description provided for @resultNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get resultNext;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Session complete'**
  String get summaryTitle;

  /// No description provided for @summaryScore.
  ///
  /// In en, this message translates to:
  /// **'{correct}/{total} correct answers'**
  String summaryScore(int correct, int total);

  /// No description provided for @summaryReplaySession.
  ///
  /// In en, this message translates to:
  /// **'Replay this session'**
  String get summaryReplaySession;

  /// No description provided for @summaryRetryMistakes.
  ///
  /// In en, this message translates to:
  /// **'Review my mistakes'**
  String get summaryRetryMistakes;

  /// No description provided for @summaryIncreaseDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Increase difficulty'**
  String get summaryIncreaseDifficulty;

  /// No description provided for @summaryBackToExercises.
  ///
  /// In en, this message translates to:
  /// **'Back to exercises'**
  String get summaryBackToExercises;

  /// No description provided for @summaryAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get summaryAccuracy;

  /// No description provided for @summaryAverageTime.
  ///
  /// In en, this message translates to:
  /// **'Average time'**
  String get summaryAverageTime;

  /// No description provided for @summaryReplays.
  ///
  /// In en, this message translates to:
  /// **'Replays'**
  String get summaryReplays;

  /// No description provided for @summaryBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best streak'**
  String get summaryBestStreak;

  /// No description provided for @summarySkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get summarySkipped;

  /// No description provided for @summaryHardest.
  ///
  /// In en, this message translates to:
  /// **'Hardest'**
  String get summaryHardest;

  /// No description provided for @summaryCommonConfusion.
  ///
  /// In en, this message translates to:
  /// **'Common confusion'**
  String get summaryCommonConfusion;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get statsTitle;

  /// No description provided for @statsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis of your performance'**
  String get statsSubtitle;

  /// No description provided for @statsIntervalDetail.
  ///
  /// In en, this message translates to:
  /// **'Interval detail'**
  String get statsIntervalDetail;

  /// No description provided for @statsDays.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get statsDays;

  /// No description provided for @statsIntervals.
  ///
  /// In en, this message translates to:
  /// **'Intervals'**
  String get statsIntervals;

  /// No description provided for @statsLevels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get statsLevels;

  /// No description provided for @statsAverage.
  ///
  /// In en, this message translates to:
  /// **'Avg. {percentage}%'**
  String statsAverage(int percentage);

  /// No description provided for @intervalUnisonLabel.
  ///
  /// In en, this message translates to:
  /// **'Unison'**
  String get intervalUnisonLabel;

  /// No description provided for @intervalUnisonSensation.
  ///
  /// In en, this message translates to:
  /// **'Same identity, same pitch'**
  String get intervalUnisonSensation;

  /// No description provided for @intervalMinorSecondLabel.
  ///
  /// In en, this message translates to:
  /// **'Minor Second'**
  String get intervalMinorSecondLabel;

  /// No description provided for @intervalMinorSecondSensation.
  ///
  /// In en, this message translates to:
  /// **'Very close, tense'**
  String get intervalMinorSecondSensation;

  /// No description provided for @intervalMajorSecondLabel.
  ///
  /// In en, this message translates to:
  /// **'Major Second'**
  String get intervalMajorSecondLabel;

  /// No description provided for @intervalMajorSecondSensation.
  ///
  /// In en, this message translates to:
  /// **'Small melodic movement'**
  String get intervalMajorSecondSensation;

  /// No description provided for @intervalMinorThirdLabel.
  ///
  /// In en, this message translates to:
  /// **'Minor Third'**
  String get intervalMinorThirdLabel;

  /// No description provided for @intervalMinorThirdSensation.
  ///
  /// In en, this message translates to:
  /// **'Minor color'**
  String get intervalMinorThirdSensation;

  /// No description provided for @intervalMajorThirdLabel.
  ///
  /// In en, this message translates to:
  /// **'Major Third'**
  String get intervalMajorThirdLabel;

  /// No description provided for @intervalMajorThirdSensation.
  ///
  /// In en, this message translates to:
  /// **'Major color'**
  String get intervalMajorThirdSensation;

  /// No description provided for @intervalPerfectFourthLabel.
  ///
  /// In en, this message translates to:
  /// **'Perfect Fourth'**
  String get intervalPerfectFourthLabel;

  /// No description provided for @intervalPerfectFourthSensation.
  ///
  /// In en, this message translates to:
  /// **'Open, suspended'**
  String get intervalPerfectFourthSensation;

  /// No description provided for @intervalTritoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Tritone'**
  String get intervalTritoneLabel;

  /// No description provided for @intervalTritoneSensation.
  ///
  /// In en, this message translates to:
  /// **'Unstable, very tense'**
  String get intervalTritoneSensation;

  /// No description provided for @intervalPerfectFifthLabel.
  ///
  /// In en, this message translates to:
  /// **'Perfect Fifth'**
  String get intervalPerfectFifthLabel;

  /// No description provided for @intervalPerfectFifthSensation.
  ///
  /// In en, this message translates to:
  /// **'Stable, powerful'**
  String get intervalPerfectFifthSensation;

  /// No description provided for @intervalMinorSixthLabel.
  ///
  /// In en, this message translates to:
  /// **'Minor Sixth'**
  String get intervalMinorSixthLabel;

  /// No description provided for @intervalMinorSixthSensation.
  ///
  /// In en, this message translates to:
  /// **'Nostalgic, soft'**
  String get intervalMinorSixthSensation;

  /// No description provided for @intervalMajorSixthLabel.
  ///
  /// In en, this message translates to:
  /// **'Major Sixth'**
  String get intervalMajorSixthLabel;

  /// No description provided for @intervalMajorSixthSensation.
  ///
  /// In en, this message translates to:
  /// **'Open, bright'**
  String get intervalMajorSixthSensation;

  /// No description provided for @intervalMinorSeventhLabel.
  ///
  /// In en, this message translates to:
  /// **'Minor Seventh'**
  String get intervalMinorSeventhLabel;

  /// No description provided for @intervalMinorSeventhSensation.
  ///
  /// In en, this message translates to:
  /// **'Tense, unresolved'**
  String get intervalMinorSeventhSensation;

  /// No description provided for @intervalMajorSeventhLabel.
  ///
  /// In en, this message translates to:
  /// **'Major Seventh'**
  String get intervalMajorSeventhLabel;

  /// No description provided for @intervalMajorSeventhSensation.
  ///
  /// In en, this message translates to:
  /// **'Very tense, bright'**
  String get intervalMajorSeventhSensation;

  /// No description provided for @intervalOctaveLabel.
  ///
  /// In en, this message translates to:
  /// **'Octave'**
  String get intervalOctaveLabel;

  /// No description provided for @intervalOctaveSensation.
  ///
  /// In en, this message translates to:
  /// **'Same identity, different height'**
  String get intervalOctaveSensation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
