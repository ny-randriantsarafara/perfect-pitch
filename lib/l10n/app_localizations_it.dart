// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Intervals.pro';

  @override
  String get navHome => 'Home';

  @override
  String get navExercises => 'Esercizi';

  @override
  String get navGuitar => 'Chitarra';

  @override
  String get navProgress => 'Progressi';

  @override
  String streakDays(int days) {
    return '$days giorni';
  }

  @override
  String get streakLabel => 'Serie attuale';

  @override
  String streakDaysUppercase(int days) {
    return '$days Giorni';
  }

  @override
  String get homeGreeting => 'Ciao!';

  @override
  String get homeSubtitle => 'Il tuo allenamento uditivo ti aspetta.';

  @override
  String get homeTodaySession => 'SESSIONE DI OGGI';

  @override
  String get homeSessionTitle => 'Quinta Giusta\n& Confronto';

  @override
  String get homeSessionSubtitle =>
      'Riscaldamento, nuovo intervallo e pratica.';

  @override
  String get homeStartFiveMinutes => 'Avvia (5 min)';

  @override
  String get homeRepertoire => 'Il tuo repertorio';

  @override
  String get homeSeeAll => 'VEDI TUTTO';

  @override
  String get discover => 'Da scoprire';

  @override
  String get learning => 'In apprendimento';

  @override
  String masteredAt(int percentage) {
    return 'Padroneggiato al $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Unisono\n& Ottava';

  @override
  String get repertoirePerfectFifth => 'Quinta\nGiusta';

  @override
  String get practiceMode => 'MODALITÀ PRATICA';

  @override
  String get guitarTitle => 'Il Manico';

  @override
  String get guitarPromptPrefix => 'Trova la ';

  @override
  String get guitarPromptSuffix =>
      ' a partire dalla nota fondamentale illuminata.';

  @override
  String get guitarNextInterval => 'Intervallo successivo';

  @override
  String get exercisesTitle => 'Esercizi';

  @override
  String get exercisesSubtitle => 'Scegli un allenamento di riconoscimento.';

  @override
  String get startSession => 'Avvia sessione';

  @override
  String get settings => 'IMPOSTAZIONI';

  @override
  String get intervalQuestionPrompt => 'Che intervallo è questo?';

  @override
  String get languagePickerTooltip => 'Scegli la lingua';
}
