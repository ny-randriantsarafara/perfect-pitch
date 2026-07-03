// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Intervals.pro';

  @override
  String get navHome => 'Start';

  @override
  String get navExercises => 'Übungen';

  @override
  String get navGuitar => 'Gitarre';

  @override
  String get navProgress => 'Fortschritt';

  @override
  String streakDays(int days) {
    return '$days Tage';
  }

  @override
  String get streakLabel => 'Aktuelle Serie';

  @override
  String streakDaysUppercase(int days) {
    return '$days Tage';
  }

  @override
  String get homeGreeting => 'Hallo!';

  @override
  String get homeSubtitle => 'Dein Gehörtraining wartet.';

  @override
  String get homeTodaySession => 'HEUTIGE SITZUNG';

  @override
  String get homeSessionTitle => 'Reine Quinte\n& Vergleich';

  @override
  String get homeSessionSubtitle => 'Aufwärmen, neues Intervall und Übung.';

  @override
  String get homeStartFiveMinutes => 'Starten (5 Min.)';

  @override
  String get homeRepertoire => 'Dein Repertoire';

  @override
  String get homeSeeAll => 'ALLE ANZEIGEN';

  @override
  String get discover => 'Zu entdecken';

  @override
  String get learning => 'Am Lernen';

  @override
  String masteredAt(int percentage) {
    return 'Beherrscht zu $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Prime\n& Oktave';

  @override
  String get repertoirePerfectFifth => 'Reine\nQuinte';

  @override
  String get practiceMode => 'ÜBUNGSMODUS';

  @override
  String get guitarTitle => 'Das Griffbrett';

  @override
  String get guitarPromptPrefix => 'Finde die ';

  @override
  String get guitarPromptSuffix => ' ausgehend vom leuchtenden Grundton.';

  @override
  String get guitarNextInterval => 'Nächstes Intervall';

  @override
  String get exercisesTitle => 'Übungen';

  @override
  String get exercisesSubtitle => 'Wähle ein Erkennungstraining.';

  @override
  String get startSession => 'Training starten';

  @override
  String get settings => 'EINSTELLUNGEN';

  @override
  String get intervalQuestionPrompt => 'Welches Intervall ist das?';

  @override
  String get languagePickerTooltip => 'Sprache wählen';
}
