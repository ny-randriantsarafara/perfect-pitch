// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'The Perfect Pitch';

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

  @override
  String get exerciseAscendingLabel => 'Intervalles ascendants';

  @override
  String get exerciseAscendingDescription =>
      'La note grave puis la note aiguë.';

  @override
  String get exerciseDescendingLabel => 'Intervalles descendants';

  @override
  String get exerciseDescendingDescription =>
      'La note aiguë puis la note grave.';

  @override
  String get exerciseHarmonicLabel => 'Intervalles harmoniques';

  @override
  String get exerciseHarmonicDescription => 'Les deux notes jouées ensemble.';

  @override
  String get exerciseMixedLabel => 'Intervalles mixtes';

  @override
  String get exerciseMixedDescription =>
      'Ascendant, descendant ou harmonique à chaque question.';

  @override
  String get difficultyBeginner => 'Débutant';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyMedium => 'Moyen';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get trainingModeAscending => 'Ascendant';

  @override
  String get trainingModeDescending => 'Descendant';

  @override
  String get trainingModeHarmonic => 'Harmonique';

  @override
  String get trainingModeGuitar => 'Guitare';

  @override
  String get directionAscending => 'ASCENDANT';

  @override
  String get directionDescending => 'DESCENDANT';

  @override
  String get directionHarmonic => 'HARMONIQUE';

  @override
  String get instrumentSine => 'Sinus';

  @override
  String get instrumentWarmSynth => 'Synthé';

  @override
  String get instrumentPiano => 'Piano';

  @override
  String get instrumentGuitar => 'Guitare';

  @override
  String get catalogueContinue => 'Continuer';

  @override
  String get catalogueStart => 'Commencer';

  @override
  String masteryLabel(int percentage) {
    return 'Maîtrise $percentage%';
  }

  @override
  String get setupQuestions => 'Questions';

  @override
  String get setupAdvanced => 'Avancé';

  @override
  String get setupIntervals => 'Intervalles';

  @override
  String get setupDirections => 'Directions';

  @override
  String get setupChoicesPerQuestion => 'Choix par question';

  @override
  String get setupUnlimitedReplays => 'Réécoutes illimitées';

  @override
  String get setupReplayLimit => 'Réécoutes max';

  @override
  String get setupLowNoteMidi => 'Note grave (MIDI)';

  @override
  String get setupHighNoteMidi => 'Note aiguë (MIDI)';

  @override
  String get setupAutoPlay => 'Lecture automatique';

  @override
  String get setupImmediateFeedback => 'Correction immédiate';

  @override
  String get setupAnnounceDirection => 'Direction annoncée';

  @override
  String questionProgress(int current, int total) {
    return 'QUESTION $current/$total';
  }

  @override
  String get skipQuestion => 'PASSER';

  @override
  String get replayUnlimited => 'Réécoutes illimitées';

  @override
  String replayCount(int count, int limit) {
    return 'Réécoutes : $count/$limit';
  }

  @override
  String get directionUnknown => 'DIRECTION ?';

  @override
  String resultSkippedAnswer(String expected) {
    return 'Passé — la réponse était $expected.';
  }

  @override
  String resultWrongAnswer(String selected, String expected, int delta) {
    return 'Tu as choisi $selected, c\'était $expected (écart de $delta demi-tons).';
  }

  @override
  String get resultHesitation => 'HÉSITATION ?';

  @override
  String get resultNext => 'Suivant';

  @override
  String get summaryTitle => 'Session terminée';

  @override
  String summaryScore(int correct, int total) {
    return '$correct/$total bonnes réponses';
  }

  @override
  String get summaryReplaySession => 'Rejouer cette session';

  @override
  String get summaryRetryMistakes => 'Revoir mes erreurs';

  @override
  String get summaryIncreaseDifficulty => 'Monter en difficulté';

  @override
  String get summaryBackToExercises => 'Retour aux exercices';

  @override
  String get summaryAccuracy => 'Précision';

  @override
  String get summaryAverageTime => 'Temps moyen';

  @override
  String get summaryReplays => 'Réécoutes';

  @override
  String get summaryBestStreak => 'Meilleure série';

  @override
  String get summarySkipped => 'Passées';

  @override
  String get summaryHardest => 'Plus difficile';

  @override
  String get summaryCommonConfusion => 'Confusion fréquente';

  @override
  String get statsTitle => 'Progrès';

  @override
  String get statsSubtitle => 'Analyse de tes performances';

  @override
  String get statsIntervalDetail => 'Détail par intervalle';

  @override
  String get statsDays => 'Jours';

  @override
  String get statsIntervals => 'Intervalles';

  @override
  String get statsLevels => 'Niveaux';

  @override
  String statsAverage(int percentage) {
    return 'Moy. $percentage%';
  }

  @override
  String get intervalUnisonLabel => 'Unisson';

  @override
  String get intervalUnisonSensation => 'Même identité, même hauteur';

  @override
  String get intervalMinorSecondLabel => 'Seconde Mineure';

  @override
  String get intervalMinorSecondSensation => 'Très serrée, tendue';

  @override
  String get intervalMajorSecondLabel => 'Seconde Majeure';

  @override
  String get intervalMajorSecondSensation => 'Petit mouvement mélodique';

  @override
  String get intervalMinorThirdLabel => 'Tierce Mineure';

  @override
  String get intervalMinorThirdSensation => 'Couleur mineure';

  @override
  String get intervalMajorThirdLabel => 'Tierce Majeure';

  @override
  String get intervalMajorThirdSensation => 'Couleur majeure';

  @override
  String get intervalPerfectFourthLabel => 'Quarte Juste';

  @override
  String get intervalPerfectFourthSensation => 'Ouverte, suspendue';

  @override
  String get intervalTritoneLabel => 'Triton';

  @override
  String get intervalTritoneSensation => 'Instable, très tendu';

  @override
  String get intervalPerfectFifthLabel => 'Quinte Juste';

  @override
  String get intervalPerfectFifthSensation => 'Stable, puissante';

  @override
  String get intervalMinorSixthLabel => 'Sixte Mineure';

  @override
  String get intervalMinorSixthSensation => 'Nostalgique, douce';

  @override
  String get intervalMajorSixthLabel => 'Sixte Majeure';

  @override
  String get intervalMajorSixthSensation => 'Ouverte, lumineuse';

  @override
  String get intervalMinorSeventhLabel => 'Septième Mineure';

  @override
  String get intervalMinorSeventhSensation => 'Tendue, en attente';

  @override
  String get intervalMajorSeventhLabel => 'Septième Majeure';

  @override
  String get intervalMajorSeventhSensation => 'Très tendue, brillante';

  @override
  String get intervalOctaveLabel => 'Octave';

  @override
  String get intervalOctaveSensation => 'Même identité, autre hauteur';
}
