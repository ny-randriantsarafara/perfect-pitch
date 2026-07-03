// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Intervals.pro';

  @override
  String get navHome => 'Accueil';

  @override
  String get navExercises => 'Exercices';

  @override
  String get navGuitar => 'Guitare';

  @override
  String get navProgress => 'Progrès';

  @override
  String streakDays(int days) {
    return '$days jours';
  }

  @override
  String get streakLabel => 'Série en cours';

  @override
  String streakDaysUppercase(int days) {
    return '$days Jours';
  }

  @override
  String get homeGreeting => 'Bonjour !';

  @override
  String get homeSubtitle => 'L\'oreille absolue t\'attend.';

  @override
  String get homeTodaySession => 'SESSION DU JOUR';

  @override
  String get homeSessionTitle => 'Quinte Juste\n& Comparaison';

  @override
  String get homeSessionSubtitle =>
      'Échauffement, nouvel intervalle et mise en pratique.';

  @override
  String get homeStartFiveMinutes => 'Démarrer (5 min)';

  @override
  String get homeRepertoire => 'Ton répertoire';

  @override
  String get homeSeeAll => 'VOIR TOUT';

  @override
  String get discover => 'À découvrir';

  @override
  String get learning => 'En apprentissage';

  @override
  String masteredAt(int percentage) {
    return 'Maîtrisé à $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Unisson\n& Octave';

  @override
  String get repertoirePerfectFifth => 'Quinte\nJuste';

  @override
  String get practiceMode => 'MODE PRATIQUE';

  @override
  String get guitarTitle => 'Le Manche';

  @override
  String get guitarPromptPrefix => 'Trouve la ';

  @override
  String get guitarPromptSuffix =>
      ' par rapport à la note fondamentale lumineuse.';

  @override
  String get guitarNextInterval => 'Intervalle suivant';

  @override
  String get exercisesTitle => 'Exercices';

  @override
  String get exercisesSubtitle => 'Choisis un entraînement de reconnaissance.';

  @override
  String get startSession => 'Démarrer la session';

  @override
  String get settings => 'RÉGLAGES';

  @override
  String get intervalQuestionPrompt => 'Quel est cet intervalle ?';

  @override
  String get languagePickerTooltip => 'Choisir la langue';
}
