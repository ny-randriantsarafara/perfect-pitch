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

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

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

  /// No description provided for @coursePrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get coursePrevious;

  /// No description provided for @courseNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get courseNext;

  /// No description provided for @courseStartDrill.
  ///
  /// In en, this message translates to:
  /// **'Start drill'**
  String get courseStartDrill;

  /// No description provided for @courseRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get courseRecommended;

  /// No description provided for @courseCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get courseCompleted;

  /// No description provided for @courseLearnFirst.
  ///
  /// In en, this message translates to:
  /// **'Learn first'**
  String get courseLearnFirst;

  /// No description provided for @coursePlayDemo.
  ///
  /// In en, this message translates to:
  /// **'Play example'**
  String get coursePlayDemo;

  /// No description provided for @courseEstimatedMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String courseEstimatedMinutes(int minutes);

  /// No description provided for @learnTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learnTabTitle;

  /// No description provided for @learnTabSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Short lessons before each drill.'**
  String get learnTabSubtitle;

  /// No description provided for @courseEarTrainingBasicsTitle.
  ///
  /// In en, this message translates to:
  /// **'How to train your ear'**
  String get courseEarTrainingBasicsTitle;

  /// No description provided for @courseEarTrainingBasicsGoal.
  ///
  /// In en, this message translates to:
  /// **'Learn the app routine before the first exercise.'**
  String get courseEarTrainingBasicsGoal;

  /// No description provided for @courseEarTrainingBasicsCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseEarTrainingBasicsCard1Title;

  /// No description provided for @courseEarTrainingBasicsCard1Body.
  ///
  /// In en, this message translates to:
  /// **'An interval is the distance between two notes. In this app, your job is to name that distance by ear.'**
  String get courseEarTrainingBasicsCard1Body;

  /// No description provided for @courseEarTrainingBasicsCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseEarTrainingBasicsCard2Title;

  /// No description provided for @courseEarTrainingBasicsCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Do not hunt for the note names. Listen for size, color, and stability: small/large, tense/calm, dark/bright.'**
  String get courseEarTrainingBasicsCard2Body;

  /// No description provided for @courseEarTrainingBasicsCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseEarTrainingBasicsCard3Title;

  /// No description provided for @courseEarTrainingBasicsCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Play the example, pause, then say whether it feels same, close, open, or far before choosing an answer.'**
  String get courseEarTrainingBasicsCard3Body;

  /// No description provided for @courseIntervalDirectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Ascending, descending, harmonic'**
  String get courseIntervalDirectionTitle;

  /// No description provided for @courseIntervalDirectionGoal.
  ///
  /// In en, this message translates to:
  /// **'Know the three ways the same interval can be played.'**
  String get courseIntervalDirectionGoal;

  /// No description provided for @courseIntervalDirectionCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseIntervalDirectionCard1Title;

  /// No description provided for @courseIntervalDirectionCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Ascending goes low to high. Descending goes high to low. Harmonic plays both notes together.'**
  String get courseIntervalDirectionCard1Body;

  /// No description provided for @courseIntervalDirectionCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseIntervalDirectionCard2Title;

  /// No description provided for @courseIntervalDirectionCard2Body.
  ///
  /// In en, this message translates to:
  /// **'The interval name stays the same even when the direction changes. Direction changes the feeling, not the distance.'**
  String get courseIntervalDirectionCard2Body;

  /// No description provided for @courseIntervalDirectionCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseIntervalDirectionCard3Title;

  /// No description provided for @courseIntervalDirectionCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Play the same interval in all three directions and answer only the direction first, then the interval.'**
  String get courseIntervalDirectionCard3Body;

  /// No description provided for @coursePracticeStrategyTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice without guessing'**
  String get coursePracticeStrategyTitle;

  /// No description provided for @coursePracticeStrategyGoal.
  ///
  /// In en, this message translates to:
  /// **'Use replay and hesitation markers the right way.'**
  String get coursePracticeStrategyGoal;

  /// No description provided for @coursePracticeStrategyCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get coursePracticeStrategyCard1Title;

  /// No description provided for @coursePracticeStrategyCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Accuracy matters more than speed. A slow correct answer builds the map; a fast guess adds noise.'**
  String get coursePracticeStrategyCard1Body;

  /// No description provided for @coursePracticeStrategyCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get coursePracticeStrategyCard2Title;

  /// No description provided for @coursePracticeStrategyCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Replay once for the shape, once for the feeling. After that, answer and learn from the comparison.'**
  String get coursePracticeStrategyCard2Body;

  /// No description provided for @coursePracticeStrategyCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get coursePracticeStrategyCard3Title;

  /// No description provided for @coursePracticeStrategyCard3Body.
  ///
  /// In en, this message translates to:
  /// **'When unsure, mark hesitation after answering. This keeps correct-but-fragile intervals visible in progress.'**
  String get coursePracticeStrategyCard3Body;

  /// No description provided for @courseUnisonTitle.
  ///
  /// In en, this message translates to:
  /// **'Unison'**
  String get courseUnisonTitle;

  /// No description provided for @courseUnisonGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Unison by its sound.'**
  String get courseUnisonGoal;

  /// No description provided for @courseUnisonCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseUnisonCard1Title;

  /// No description provided for @courseUnisonCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: same note, no distance'**
  String get courseUnisonCard1Body;

  /// No description provided for @courseUnisonCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseUnisonCard2Title;

  /// No description provided for @courseUnisonCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Unison with Octave. Name the size first, then the color.'**
  String get courseUnisonCard2Body;

  /// No description provided for @courseUnisonCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseUnisonCard3Title;

  /// No description provided for @courseUnisonCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseUnisonCard3Body;

  /// No description provided for @courseOctaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Octave'**
  String get courseOctaveTitle;

  /// No description provided for @courseOctaveGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Octave by its sound.'**
  String get courseOctaveGoal;

  /// No description provided for @courseOctaveCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseOctaveCard1Title;

  /// No description provided for @courseOctaveCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: same identity, different height'**
  String get courseOctaveCard1Body;

  /// No description provided for @courseOctaveCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseOctaveCard2Title;

  /// No description provided for @courseOctaveCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Octave with Unison. Name the size first, then the color.'**
  String get courseOctaveCard2Body;

  /// No description provided for @courseOctaveCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseOctaveCard3Title;

  /// No description provided for @courseOctaveCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseOctaveCard3Body;

  /// No description provided for @coursePerfectFifthTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfect fifth'**
  String get coursePerfectFifthTitle;

  /// No description provided for @coursePerfectFifthGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Perfect fifth by its sound.'**
  String get coursePerfectFifthGoal;

  /// No description provided for @coursePerfectFifthCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get coursePerfectFifthCard1Title;

  /// No description provided for @coursePerfectFifthCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: stable, open, powerful'**
  String get coursePerfectFifthCard1Body;

  /// No description provided for @coursePerfectFifthCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get coursePerfectFifthCard2Title;

  /// No description provided for @coursePerfectFifthCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Perfect fifth with Perfect fourth. Name the size first, then the color.'**
  String get coursePerfectFifthCard2Body;

  /// No description provided for @coursePerfectFifthCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get coursePerfectFifthCard3Title;

  /// No description provided for @coursePerfectFifthCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get coursePerfectFifthCard3Body;

  /// No description provided for @courseMinorThirdTitle.
  ///
  /// In en, this message translates to:
  /// **'Minor third'**
  String get courseMinorThirdTitle;

  /// No description provided for @courseMinorThirdGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Minor third by its sound.'**
  String get courseMinorThirdGoal;

  /// No description provided for @courseMinorThirdCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMinorThirdCard1Title;

  /// No description provided for @courseMinorThirdCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: small leap, darker color'**
  String get courseMinorThirdCard1Body;

  /// No description provided for @courseMinorThirdCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMinorThirdCard2Title;

  /// No description provided for @courseMinorThirdCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Minor third with Major third. Name the size first, then the color.'**
  String get courseMinorThirdCard2Body;

  /// No description provided for @courseMinorThirdCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMinorThirdCard3Title;

  /// No description provided for @courseMinorThirdCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMinorThirdCard3Body;

  /// No description provided for @courseMajorThirdTitle.
  ///
  /// In en, this message translates to:
  /// **'Major third'**
  String get courseMajorThirdTitle;

  /// No description provided for @courseMajorThirdGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Major third by its sound.'**
  String get courseMajorThirdGoal;

  /// No description provided for @courseMajorThirdCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMajorThirdCard1Title;

  /// No description provided for @courseMajorThirdCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: small leap, brighter color'**
  String get courseMajorThirdCard1Body;

  /// No description provided for @courseMajorThirdCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMajorThirdCard2Title;

  /// No description provided for @courseMajorThirdCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Major third with Minor third. Name the size first, then the color.'**
  String get courseMajorThirdCard2Body;

  /// No description provided for @courseMajorThirdCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMajorThirdCard3Title;

  /// No description provided for @courseMajorThirdCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMajorThirdCard3Body;

  /// No description provided for @coursePerfectFourthTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfect fourth'**
  String get coursePerfectFourthTitle;

  /// No description provided for @coursePerfectFourthGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Perfect fourth by its sound.'**
  String get coursePerfectFourthGoal;

  /// No description provided for @coursePerfectFourthCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get coursePerfectFourthCard1Title;

  /// No description provided for @coursePerfectFourthCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: open, suspended, waiting'**
  String get coursePerfectFourthCard1Body;

  /// No description provided for @coursePerfectFourthCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get coursePerfectFourthCard2Title;

  /// No description provided for @coursePerfectFourthCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Perfect fourth with Perfect fifth. Name the size first, then the color.'**
  String get coursePerfectFourthCard2Body;

  /// No description provided for @coursePerfectFourthCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get coursePerfectFourthCard3Title;

  /// No description provided for @coursePerfectFourthCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get coursePerfectFourthCard3Body;

  /// No description provided for @courseMinorSecondTitle.
  ///
  /// In en, this message translates to:
  /// **'Minor second'**
  String get courseMinorSecondTitle;

  /// No description provided for @courseMinorSecondGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Minor second by its sound.'**
  String get courseMinorSecondGoal;

  /// No description provided for @courseMinorSecondCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMinorSecondCard1Title;

  /// No description provided for @courseMinorSecondCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: very close and tense'**
  String get courseMinorSecondCard1Body;

  /// No description provided for @courseMinorSecondCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMinorSecondCard2Title;

  /// No description provided for @courseMinorSecondCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Minor second with Major second. Name the size first, then the color.'**
  String get courseMinorSecondCard2Body;

  /// No description provided for @courseMinorSecondCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMinorSecondCard3Title;

  /// No description provided for @courseMinorSecondCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMinorSecondCard3Body;

  /// No description provided for @courseMajorSecondTitle.
  ///
  /// In en, this message translates to:
  /// **'Major second'**
  String get courseMajorSecondTitle;

  /// No description provided for @courseMajorSecondGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Major second by its sound.'**
  String get courseMajorSecondGoal;

  /// No description provided for @courseMajorSecondCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMajorSecondCard1Title;

  /// No description provided for @courseMajorSecondCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: small natural movement'**
  String get courseMajorSecondCard1Body;

  /// No description provided for @courseMajorSecondCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMajorSecondCard2Title;

  /// No description provided for @courseMajorSecondCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Major second with Minor second. Name the size first, then the color.'**
  String get courseMajorSecondCard2Body;

  /// No description provided for @courseMajorSecondCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMajorSecondCard3Title;

  /// No description provided for @courseMajorSecondCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMajorSecondCard3Body;

  /// No description provided for @courseMinorSixthTitle.
  ///
  /// In en, this message translates to:
  /// **'Minor sixth'**
  String get courseMinorSixthTitle;

  /// No description provided for @courseMinorSixthGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Minor sixth by its sound.'**
  String get courseMinorSixthGoal;

  /// No description provided for @courseMinorSixthCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMinorSixthCard1Title;

  /// No description provided for @courseMinorSixthCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: wide, soft, nostalgic'**
  String get courseMinorSixthCard1Body;

  /// No description provided for @courseMinorSixthCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMinorSixthCard2Title;

  /// No description provided for @courseMinorSixthCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Minor sixth with Major sixth. Name the size first, then the color.'**
  String get courseMinorSixthCard2Body;

  /// No description provided for @courseMinorSixthCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMinorSixthCard3Title;

  /// No description provided for @courseMinorSixthCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMinorSixthCard3Body;

  /// No description provided for @courseMajorSixthTitle.
  ///
  /// In en, this message translates to:
  /// **'Major sixth'**
  String get courseMajorSixthTitle;

  /// No description provided for @courseMajorSixthGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Major sixth by its sound.'**
  String get courseMajorSixthGoal;

  /// No description provided for @courseMajorSixthCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMajorSixthCard1Title;

  /// No description provided for @courseMajorSixthCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: wide, bright, open'**
  String get courseMajorSixthCard1Body;

  /// No description provided for @courseMajorSixthCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMajorSixthCard2Title;

  /// No description provided for @courseMajorSixthCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Major sixth with Minor sixth. Name the size first, then the color.'**
  String get courseMajorSixthCard2Body;

  /// No description provided for @courseMajorSixthCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMajorSixthCard3Title;

  /// No description provided for @courseMajorSixthCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMajorSixthCard3Body;

  /// No description provided for @courseMinorSeventhTitle.
  ///
  /// In en, this message translates to:
  /// **'Minor seventh'**
  String get courseMinorSeventhTitle;

  /// No description provided for @courseMinorSeventhGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Minor seventh by its sound.'**
  String get courseMinorSeventhGoal;

  /// No description provided for @courseMinorSeventhCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMinorSeventhCard1Title;

  /// No description provided for @courseMinorSeventhCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: wide, tense, unresolved'**
  String get courseMinorSeventhCard1Body;

  /// No description provided for @courseMinorSeventhCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMinorSeventhCard2Title;

  /// No description provided for @courseMinorSeventhCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Minor seventh with Major seventh. Name the size first, then the color.'**
  String get courseMinorSeventhCard2Body;

  /// No description provided for @courseMinorSeventhCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMinorSeventhCard3Title;

  /// No description provided for @courseMinorSeventhCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMinorSeventhCard3Body;

  /// No description provided for @courseMajorSeventhTitle.
  ///
  /// In en, this message translates to:
  /// **'Major seventh'**
  String get courseMajorSeventhTitle;

  /// No description provided for @courseMajorSeventhGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Major seventh by its sound.'**
  String get courseMajorSeventhGoal;

  /// No description provided for @courseMajorSeventhCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseMajorSeventhCard1Title;

  /// No description provided for @courseMajorSeventhCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: almost octave, very tense'**
  String get courseMajorSeventhCard1Body;

  /// No description provided for @courseMajorSeventhCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseMajorSeventhCard2Title;

  /// No description provided for @courseMajorSeventhCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Major seventh with Octave. Name the size first, then the color.'**
  String get courseMajorSeventhCard2Body;

  /// No description provided for @courseMajorSeventhCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMajorSeventhCard3Title;

  /// No description provided for @courseMajorSeventhCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseMajorSeventhCard3Body;

  /// No description provided for @courseTritoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Tritone'**
  String get courseTritoneTitle;

  /// No description provided for @courseTritoneGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize Tritone by its sound.'**
  String get courseTritoneGoal;

  /// No description provided for @courseTritoneCard1Title.
  ///
  /// In en, this message translates to:
  /// **'What to hear'**
  String get courseTritoneCard1Title;

  /// No description provided for @courseTritoneCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Focus on the feeling: unstable, strange, split'**
  String get courseTritoneCard1Body;

  /// No description provided for @courseTritoneCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Compare it'**
  String get courseTritoneCard2Title;

  /// No description provided for @courseTritoneCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Compare Tritone with Perfect fifth. Name the size first, then the color.'**
  String get courseTritoneCard2Body;

  /// No description provided for @courseTritoneCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseTritoneCard3Title;

  /// No description provided for @courseTritoneCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.'**
  String get courseTritoneCard3Body;

  /// No description provided for @courseAscendingIntervalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Master ascending intervals'**
  String get courseAscendingIntervalsTitle;

  /// No description provided for @courseAscendingIntervalsGoal.
  ///
  /// In en, this message translates to:
  /// **'Hear the distance when the melody goes upward.'**
  String get courseAscendingIntervalsGoal;

  /// No description provided for @courseAscendingIntervalsCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseAscendingIntervalsCard1Title;

  /// No description provided for @courseAscendingIntervalsCard1Body.
  ///
  /// In en, this message translates to:
  /// **'The first note is the root. The second note tells you the interval size upward.'**
  String get courseAscendingIntervalsCard1Body;

  /// No description provided for @courseAscendingIntervalsCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseAscendingIntervalsCard2Title;

  /// No description provided for @courseAscendingIntervalsCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Sing the first note in your head, then feel how far the second note climbs.'**
  String get courseAscendingIntervalsCard2Body;

  /// No description provided for @courseAscendingIntervalsCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseAscendingIntervalsCard3Title;

  /// No description provided for @courseAscendingIntervalsCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Start with unison, octave, fifth, and thirds before adding seconds and sevenths.'**
  String get courseAscendingIntervalsCard3Body;

  /// No description provided for @courseDescendingIntervalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Master descending intervals'**
  String get courseDescendingIntervalsTitle;

  /// No description provided for @courseDescendingIntervalsGoal.
  ///
  /// In en, this message translates to:
  /// **'Recognize the same distance when the melody falls.'**
  String get courseDescendingIntervalsGoal;

  /// No description provided for @courseDescendingIntervalsCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseDescendingIntervalsCard1Title;

  /// No description provided for @courseDescendingIntervalsCard1Body.
  ///
  /// In en, this message translates to:
  /// **'The first note is high, then the sound falls to the root. The interval name is still the distance.'**
  String get courseDescendingIntervalsCard1Body;

  /// No description provided for @courseDescendingIntervalsCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseDescendingIntervalsCard2Title;

  /// No description provided for @courseDescendingIntervalsCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Do not answer “lower” automatically. Keep the first note in memory and measure the fall.'**
  String get courseDescendingIntervalsCard2Body;

  /// No description provided for @courseDescendingIntervalsCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseDescendingIntervalsCard3Title;

  /// No description provided for @courseDescendingIntervalsCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Practice the same interval ascending then descending until the distance feels identical.'**
  String get courseDescendingIntervalsCard3Body;

  /// No description provided for @courseHarmonicIntervalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Hear two notes together'**
  String get courseHarmonicIntervalsTitle;

  /// No description provided for @courseHarmonicIntervalsGoal.
  ///
  /// In en, this message translates to:
  /// **'Identify intervals when both notes sound at the same time.'**
  String get courseHarmonicIntervalsGoal;

  /// No description provided for @courseHarmonicIntervalsCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseHarmonicIntervalsCard1Title;

  /// No description provided for @courseHarmonicIntervalsCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Both notes arrive together, so you hear color more than melody.'**
  String get courseHarmonicIntervalsCard1Body;

  /// No description provided for @courseHarmonicIntervalsCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseHarmonicIntervalsCard2Title;

  /// No description provided for @courseHarmonicIntervalsCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Listen for stability and tension: calm, open, bright, dark, rubbing, unresolved.'**
  String get courseHarmonicIntervalsCard2Body;

  /// No description provided for @courseHarmonicIntervalsCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseHarmonicIntervalsCard3Title;

  /// No description provided for @courseHarmonicIntervalsCard3Body.
  ///
  /// In en, this message translates to:
  /// **'After a wrong answer, replay the correct interval and name its color before moving on.'**
  String get courseHarmonicIntervalsCard3Body;

  /// No description provided for @courseMixedIntervalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Mixed interval survival'**
  String get courseMixedIntervalsTitle;

  /// No description provided for @courseMixedIntervalsGoal.
  ///
  /// In en, this message translates to:
  /// **'Answer by distance, even when the direction changes every question.'**
  String get courseMixedIntervalsGoal;

  /// No description provided for @courseMixedIntervalsCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseMixedIntervalsCard1Title;

  /// No description provided for @courseMixedIntervalsCard1Body.
  ///
  /// In en, this message translates to:
  /// **'Mixed mode removes the training wheels. Every question can change direction.'**
  String get courseMixedIntervalsCard1Body;

  /// No description provided for @courseMixedIntervalsCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseMixedIntervalsCard2Title;

  /// No description provided for @courseMixedIntervalsCard2Body.
  ///
  /// In en, this message translates to:
  /// **'First identify direction, then distance. Do not let direction steal the answer.'**
  String get courseMixedIntervalsCard2Body;

  /// No description provided for @courseMixedIntervalsCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMixedIntervalsCard3Title;

  /// No description provided for @courseMixedIntervalsCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Use easier intervals first, then unlock the full set when accuracy is stable.'**
  String get courseMixedIntervalsCard3Body;

  /// No description provided for @courseMistakeReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn mistakes into training'**
  String get courseMistakeReviewTitle;

  /// No description provided for @courseMistakeReviewGoal.
  ///
  /// In en, this message translates to:
  /// **'Use the summary screen to attack your real weak spots.'**
  String get courseMistakeReviewGoal;

  /// No description provided for @courseMistakeReviewCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get courseMistakeReviewCard1Title;

  /// No description provided for @courseMistakeReviewCard1Body.
  ///
  /// In en, this message translates to:
  /// **'A wrong answer is a clue. The confusion tells you which two sounds your ear merges.'**
  String get courseMistakeReviewCard1Body;

  /// No description provided for @courseMistakeReviewCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Ear clue'**
  String get courseMistakeReviewCard2Title;

  /// No description provided for @courseMistakeReviewCard2Body.
  ///
  /// In en, this message translates to:
  /// **'Use “Review my mistakes” while the sound is still fresh in memory.'**
  String get courseMistakeReviewCard2Body;

  /// No description provided for @courseMistakeReviewCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Mini drill'**
  String get courseMistakeReviewCard3Title;

  /// No description provided for @courseMistakeReviewCard3Body.
  ///
  /// In en, this message translates to:
  /// **'Train only the missed intervals for one short session, then return to mixed practice.'**
  String get courseMistakeReviewCard3Body;
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
