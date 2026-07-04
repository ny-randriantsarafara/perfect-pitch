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
  String get navLearn => 'Apprendre';

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

  @override
  String get coursePrevious => 'Précédent';

  @override
  String get courseNext => 'Suivant';

  @override
  String get courseStartDrill => 'Lancer l\'exercice';

  @override
  String get courseRecommended => 'Recommandé';

  @override
  String get courseCompleted => 'Terminé';

  @override
  String get courseLearnFirst => 'Apprendre d\'abord';

  @override
  String get coursePlayDemo => 'Écouter l\'exemple';

  @override
  String courseEstimatedMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get learnTabTitle => 'Apprendre';

  @override
  String get learnTabSubtitle => 'Des leçons courtes avant chaque exercice.';

  @override
  String get courseEarTrainingBasicsTitle => 'Comment entraîner ton oreille';

  @override
  String get courseEarTrainingBasicsGoal =>
      'Comprendre la routine avant le premier exercice.';

  @override
  String get courseEarTrainingBasicsCard1Title => 'Concept';

  @override
  String get courseEarTrainingBasicsCard1Body =>
      'Un intervalle est la distance entre deux notes. Ici, ton but est de nommer cette distance à l’oreille.';

  @override
  String get courseEarTrainingBasicsCard2Title => 'Indice d’oreille';

  @override
  String get courseEarTrainingBasicsCard2Body =>
      'Ne cherche pas le nom des notes. Écoute la taille, la couleur et la stabilité : petit/grand, tendu/calme, sombre/lumineux.';

  @override
  String get courseEarTrainingBasicsCard3Title => 'Mini exercice';

  @override
  String get courseEarTrainingBasicsCard3Body =>
      'Lance l’exemple, fais une pause, puis dis si ça sonne identique, proche, ouvert ou lointain avant de répondre.';

  @override
  String get courseIntervalDirectionTitle =>
      'Ascendant, descendant, harmonique';

  @override
  String get courseIntervalDirectionGoal =>
      'Reconnaître les trois façons de jouer un même intervalle.';

  @override
  String get courseIntervalDirectionCard1Title => 'Concept';

  @override
  String get courseIntervalDirectionCard1Body =>
      'Ascendant va du grave vers l’aigu. Descendant va de l’aigu vers le grave. Harmonique joue les deux notes ensemble.';

  @override
  String get courseIntervalDirectionCard2Title => 'Indice d’oreille';

  @override
  String get courseIntervalDirectionCard2Body =>
      'Le nom de l’intervalle reste le même quand la direction change. La direction change la sensation, pas la distance.';

  @override
  String get courseIntervalDirectionCard3Title => 'Mini exercice';

  @override
  String get courseIntervalDirectionCard3Body =>
      'Joue le même intervalle dans les trois directions : trouve d’abord la direction, puis l’intervalle.';

  @override
  String get coursePracticeStrategyTitle => 'Travailler sans deviner';

  @override
  String get coursePracticeStrategyGoal =>
      'Utiliser les réécoutes et l’hésitation proprement.';

  @override
  String get coursePracticeStrategyCard1Title => 'Concept';

  @override
  String get coursePracticeStrategyCard1Body =>
      'La précision compte plus que la vitesse. Une bonne réponse lente construit la carte ; une réponse au hasard ajoute du bruit.';

  @override
  String get coursePracticeStrategyCard2Title => 'Indice d’oreille';

  @override
  String get coursePracticeStrategyCard2Body =>
      'Réécoute une fois pour la forme, une fois pour la sensation. Ensuite, réponds et apprends avec la comparaison.';

  @override
  String get coursePracticeStrategyCard3Title => 'Mini exercice';

  @override
  String get coursePracticeStrategyCard3Body =>
      'Si tu doutes, marque l’hésitation après la réponse. Les intervalles corrects mais fragiles restent visibles dans tes progrès.';

  @override
  String get courseUnisonTitle => 'Unisson';

  @override
  String get courseUnisonGoal => 'Reconnaître Unisson à l’oreille.';

  @override
  String get courseUnisonCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseUnisonCard1Body =>
      'Concentre-toi sur la sensation : même note, aucune distance';

  @override
  String get courseUnisonCard2Title => 'Compare-le';

  @override
  String get courseUnisonCard2Body =>
      'Compare Unisson avec Octave. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseUnisonCard3Title => 'Mini exercice';

  @override
  String get courseUnisonCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseOctaveTitle => 'Octave';

  @override
  String get courseOctaveGoal => 'Reconnaître Octave à l’oreille.';

  @override
  String get courseOctaveCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseOctaveCard1Body =>
      'Concentre-toi sur la sensation : même identité, autre hauteur';

  @override
  String get courseOctaveCard2Title => 'Compare-le';

  @override
  String get courseOctaveCard2Body =>
      'Compare Octave avec Unisson. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseOctaveCard3Title => 'Mini exercice';

  @override
  String get courseOctaveCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get coursePerfectFifthTitle => 'Quinte juste';

  @override
  String get coursePerfectFifthGoal => 'Reconnaître Quinte juste à l’oreille.';

  @override
  String get coursePerfectFifthCard1Title => 'Ce qu’il faut entendre';

  @override
  String get coursePerfectFifthCard1Body =>
      'Concentre-toi sur la sensation : stable, ouverte, puissante';

  @override
  String get coursePerfectFifthCard2Title => 'Compare-le';

  @override
  String get coursePerfectFifthCard2Body =>
      'Compare Quinte juste avec Quarte juste. Nomme d’abord la taille, puis la couleur.';

  @override
  String get coursePerfectFifthCard3Title => 'Mini exercice';

  @override
  String get coursePerfectFifthCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMinorThirdTitle => 'Tierce mineure';

  @override
  String get courseMinorThirdGoal => 'Reconnaître Tierce mineure à l’oreille.';

  @override
  String get courseMinorThirdCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMinorThirdCard1Body =>
      'Concentre-toi sur la sensation : petit saut, couleur sombre';

  @override
  String get courseMinorThirdCard2Title => 'Compare-le';

  @override
  String get courseMinorThirdCard2Body =>
      'Compare Tierce mineure avec Tierce majeure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMinorThirdCard3Title => 'Mini exercice';

  @override
  String get courseMinorThirdCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMajorThirdTitle => 'Tierce majeure';

  @override
  String get courseMajorThirdGoal => 'Reconnaître Tierce majeure à l’oreille.';

  @override
  String get courseMajorThirdCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMajorThirdCard1Body =>
      'Concentre-toi sur la sensation : petit saut, couleur lumineuse';

  @override
  String get courseMajorThirdCard2Title => 'Compare-le';

  @override
  String get courseMajorThirdCard2Body =>
      'Compare Tierce majeure avec Tierce mineure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMajorThirdCard3Title => 'Mini exercice';

  @override
  String get courseMajorThirdCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get coursePerfectFourthTitle => 'Quarte juste';

  @override
  String get coursePerfectFourthGoal => 'Reconnaître Quarte juste à l’oreille.';

  @override
  String get coursePerfectFourthCard1Title => 'Ce qu’il faut entendre';

  @override
  String get coursePerfectFourthCard1Body =>
      'Concentre-toi sur la sensation : ouverte, suspendue, en attente';

  @override
  String get coursePerfectFourthCard2Title => 'Compare-le';

  @override
  String get coursePerfectFourthCard2Body =>
      'Compare Quarte juste avec Quinte juste. Nomme d’abord la taille, puis la couleur.';

  @override
  String get coursePerfectFourthCard3Title => 'Mini exercice';

  @override
  String get coursePerfectFourthCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMinorSecondTitle => 'Seconde mineure';

  @override
  String get courseMinorSecondGoal =>
      'Reconnaître Seconde mineure à l’oreille.';

  @override
  String get courseMinorSecondCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMinorSecondCard1Body =>
      'Concentre-toi sur la sensation : très proche et tendue';

  @override
  String get courseMinorSecondCard2Title => 'Compare-le';

  @override
  String get courseMinorSecondCard2Body =>
      'Compare Seconde mineure avec Seconde majeure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMinorSecondCard3Title => 'Mini exercice';

  @override
  String get courseMinorSecondCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMajorSecondTitle => 'Seconde majeure';

  @override
  String get courseMajorSecondGoal =>
      'Reconnaître Seconde majeure à l’oreille.';

  @override
  String get courseMajorSecondCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMajorSecondCard1Body =>
      'Concentre-toi sur la sensation : petit mouvement naturel';

  @override
  String get courseMajorSecondCard2Title => 'Compare-le';

  @override
  String get courseMajorSecondCard2Body =>
      'Compare Seconde majeure avec Seconde mineure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMajorSecondCard3Title => 'Mini exercice';

  @override
  String get courseMajorSecondCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMinorSixthTitle => 'Sixte mineure';

  @override
  String get courseMinorSixthGoal => 'Reconnaître Sixte mineure à l’oreille.';

  @override
  String get courseMinorSixthCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMinorSixthCard1Body =>
      'Concentre-toi sur la sensation : large, douce, nostalgique';

  @override
  String get courseMinorSixthCard2Title => 'Compare-le';

  @override
  String get courseMinorSixthCard2Body =>
      'Compare Sixte mineure avec Sixte majeure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMinorSixthCard3Title => 'Mini exercice';

  @override
  String get courseMinorSixthCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMajorSixthTitle => 'Sixte majeure';

  @override
  String get courseMajorSixthGoal => 'Reconnaître Sixte majeure à l’oreille.';

  @override
  String get courseMajorSixthCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMajorSixthCard1Body =>
      'Concentre-toi sur la sensation : large, lumineuse, ouverte';

  @override
  String get courseMajorSixthCard2Title => 'Compare-le';

  @override
  String get courseMajorSixthCard2Body =>
      'Compare Sixte majeure avec Sixte mineure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMajorSixthCard3Title => 'Mini exercice';

  @override
  String get courseMajorSixthCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMinorSeventhTitle => 'Septième mineure';

  @override
  String get courseMinorSeventhGoal =>
      'Reconnaître Septième mineure à l’oreille.';

  @override
  String get courseMinorSeventhCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMinorSeventhCard1Body =>
      'Concentre-toi sur la sensation : large, tendue, non résolue';

  @override
  String get courseMinorSeventhCard2Title => 'Compare-le';

  @override
  String get courseMinorSeventhCard2Body =>
      'Compare Septième mineure avec Septième majeure. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMinorSeventhCard3Title => 'Mini exercice';

  @override
  String get courseMinorSeventhCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseMajorSeventhTitle => 'Septième majeure';

  @override
  String get courseMajorSeventhGoal =>
      'Reconnaître Septième majeure à l’oreille.';

  @override
  String get courseMajorSeventhCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseMajorSeventhCard1Body =>
      'Concentre-toi sur la sensation : presque octave, très tendue';

  @override
  String get courseMajorSeventhCard2Title => 'Compare-le';

  @override
  String get courseMajorSeventhCard2Body =>
      'Compare Septième majeure avec Octave. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseMajorSeventhCard3Title => 'Mini exercice';

  @override
  String get courseMajorSeventhCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseTritoneTitle => 'Triton';

  @override
  String get courseTritoneGoal => 'Reconnaître Triton à l’oreille.';

  @override
  String get courseTritoneCard1Title => 'Ce qu’il faut entendre';

  @override
  String get courseTritoneCard1Body =>
      'Concentre-toi sur la sensation : instable, étrange, coupée';

  @override
  String get courseTritoneCard2Title => 'Compare-le';

  @override
  String get courseTritoneCard2Body =>
      'Compare Triton avec Quinte juste. Nomme d’abord la taille, puis la couleur.';

  @override
  String get courseTritoneCard3Title => 'Mini exercice';

  @override
  String get courseTritoneCard3Body =>
      'Commence par 5 questions avec cet intervalle et sa confusion la plus proche. Puis remets-le dans l’exercice normal.';

  @override
  String get courseAscendingIntervalsTitle =>
      'Maîtriser les intervalles ascendants';

  @override
  String get courseAscendingIntervalsGoal =>
      'Entendre la distance quand la mélodie monte.';

  @override
  String get courseAscendingIntervalsCard1Title => 'Concept';

  @override
  String get courseAscendingIntervalsCard1Body =>
      'La première note est la fondamentale. La deuxième indique la taille de l’intervalle vers le haut.';

  @override
  String get courseAscendingIntervalsCard2Title => 'Indice d’oreille';

  @override
  String get courseAscendingIntervalsCard2Body =>
      'Chante la première note dans ta tête, puis sens jusqu’où la deuxième monte.';

  @override
  String get courseAscendingIntervalsCard3Title => 'Mini exercice';

  @override
  String get courseAscendingIntervalsCard3Body =>
      'Commence avec unisson, octave, quinte et tierces avant d’ajouter secondes et septièmes.';

  @override
  String get courseDescendingIntervalsTitle =>
      'Maîtriser les intervalles descendants';

  @override
  String get courseDescendingIntervalsGoal =>
      'Reconnaître la même distance quand la mélodie descend.';

  @override
  String get courseDescendingIntervalsCard1Title => 'Concept';

  @override
  String get courseDescendingIntervalsCard1Body =>
      'La première note est aiguë, puis le son descend vers la fondamentale. Le nom reste la distance.';

  @override
  String get courseDescendingIntervalsCard2Title => 'Indice d’oreille';

  @override
  String get courseDescendingIntervalsCard2Body =>
      'Ne réponds pas juste “plus bas”. Garde la première note en mémoire et mesure la chute.';

  @override
  String get courseDescendingIntervalsCard3Title => 'Mini exercice';

  @override
  String get courseDescendingIntervalsCard3Body =>
      'Travaille le même intervalle ascendant puis descendant jusqu’à sentir la même distance.';

  @override
  String get courseHarmonicIntervalsTitle => 'Entendre deux notes ensemble';

  @override
  String get courseHarmonicIntervalsGoal =>
      'Identifier les intervalles quand les deux notes sonnent en même temps.';

  @override
  String get courseHarmonicIntervalsCard1Title => 'Concept';

  @override
  String get courseHarmonicIntervalsCard1Body =>
      'Les deux notes arrivent ensemble : tu entends plus la couleur que la mélodie.';

  @override
  String get courseHarmonicIntervalsCard2Title => 'Indice d’oreille';

  @override
  String get courseHarmonicIntervalsCard2Body =>
      'Écoute la stabilité et la tension : calme, ouvert, lumineux, sombre, frotté, non résolu.';

  @override
  String get courseHarmonicIntervalsCard3Title => 'Mini exercice';

  @override
  String get courseHarmonicIntervalsCard3Body =>
      'Après une erreur, rejoue la bonne réponse et nomme sa couleur avant de continuer.';

  @override
  String get courseMixedIntervalsTitle => 'Survivre aux intervalles mixtes';

  @override
  String get courseMixedIntervalsGoal =>
      'Répondre par distance, même quand la direction change à chaque question.';

  @override
  String get courseMixedIntervalsCard1Title => 'Concept';

  @override
  String get courseMixedIntervalsCard1Body =>
      'Le mode mixte enlève les petites roues. Chaque question peut changer de direction.';

  @override
  String get courseMixedIntervalsCard2Title => 'Indice d’oreille';

  @override
  String get courseMixedIntervalsCard2Body =>
      'Identifie d’abord la direction, puis la distance. Ne laisse pas la direction voler la réponse.';

  @override
  String get courseMixedIntervalsCard3Title => 'Mini exercice';

  @override
  String get courseMixedIntervalsCard3Body =>
      'Commence avec des intervalles faciles, puis débloque toute la liste quand la précision est stable.';

  @override
  String get courseMistakeReviewTitle =>
      'Transformer les erreurs en entraînement';

  @override
  String get courseMistakeReviewGoal =>
      'Utiliser le résumé pour cibler tes vraies faiblesses.';

  @override
  String get courseMistakeReviewCard1Title => 'Concept';

  @override
  String get courseMistakeReviewCard1Body =>
      'Une mauvaise réponse est un indice. La confusion montre quels deux sons ton oreille mélange.';

  @override
  String get courseMistakeReviewCard2Title => 'Indice d’oreille';

  @override
  String get courseMistakeReviewCard2Body =>
      'Utilise “Revoir mes erreurs” pendant que le son est encore frais.';

  @override
  String get courseMistakeReviewCard3Title => 'Mini exercice';

  @override
  String get courseMistakeReviewCard3Body =>
      'Travaille seulement les intervalles ratés pendant une courte session, puis reviens au mixte.';
}
