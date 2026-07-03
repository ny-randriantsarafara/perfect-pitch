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
  /// **'Intervals.pro'**
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
