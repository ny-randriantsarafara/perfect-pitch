// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'The Perfect Pitch';

  @override
  String get navHome => 'Home';

  @override
  String get navExercises => 'Esercizi';

  @override
  String get navLearn => 'Impara';

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

  @override
  String get exerciseAscendingLabel => 'Ascending intervals';

  @override
  String get exerciseAscendingDescription => 'Low note, then high note.';

  @override
  String get exerciseDescendingLabel => 'Descending intervals';

  @override
  String get exerciseDescendingDescription => 'High note, then low note.';

  @override
  String get exerciseHarmonicLabel => 'Harmonic intervals';

  @override
  String get exerciseHarmonicDescription => 'Both notes played together.';

  @override
  String get exerciseMixedLabel => 'Mixed intervals';

  @override
  String get exerciseMixedDescription =>
      'Ascending, descending, or harmonic on each question.';

  @override
  String get difficultyBeginner => 'Beginner';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get trainingModeAscending => 'Ascending';

  @override
  String get trainingModeDescending => 'Descending';

  @override
  String get trainingModeHarmonic => 'Harmonic';

  @override
  String get trainingModeGuitar => 'Guitar';

  @override
  String get directionAscending => 'ASCENDING';

  @override
  String get directionDescending => 'DESCENDING';

  @override
  String get directionHarmonic => 'HARMONIC';

  @override
  String get instrumentSine => 'Sine';

  @override
  String get instrumentWarmSynth => 'Warm synth';

  @override
  String get instrumentPiano => 'Piano';

  @override
  String get instrumentGuitar => 'Guitar';

  @override
  String get catalogueContinue => 'Continue';

  @override
  String get catalogueStart => 'Start';

  @override
  String masteryLabel(int percentage) {
    return 'Mastery $percentage%';
  }

  @override
  String get setupQuestions => 'Questions';

  @override
  String get setupAdvanced => 'Advanced';

  @override
  String get setupIntervals => 'Intervals';

  @override
  String get setupDirections => 'Directions';

  @override
  String get setupChoicesPerQuestion => 'Choices per question';

  @override
  String get setupUnlimitedReplays => 'Unlimited replays';

  @override
  String get setupReplayLimit => 'Replay limit';

  @override
  String get setupLowNoteMidi => 'Low note (MIDI)';

  @override
  String get setupHighNoteMidi => 'High note (MIDI)';

  @override
  String get setupAutoPlay => 'Auto-play';

  @override
  String get setupImmediateFeedback => 'Immediate feedback';

  @override
  String get setupAnnounceDirection => 'Announce direction';

  @override
  String questionProgress(int current, int total) {
    return 'QUESTION $current/$total';
  }

  @override
  String get skipQuestion => 'SKIP';

  @override
  String get replayUnlimited => 'Unlimited replays';

  @override
  String replayCount(int count, int limit) {
    return 'Replays: $count/$limit';
  }

  @override
  String get directionUnknown => 'DIRECTION?';

  @override
  String resultSkippedAnswer(String expected) {
    return 'Skipped - the answer was $expected.';
  }

  @override
  String resultWrongAnswer(String selected, String expected, int delta) {
    return 'You chose $selected; it was $expected ($delta semitones away).';
  }

  @override
  String get resultHesitation => 'HESITATION?';

  @override
  String get resultNext => 'Next';

  @override
  String get summaryTitle => 'Session complete';

  @override
  String summaryScore(int correct, int total) {
    return '$correct/$total correct answers';
  }

  @override
  String get summaryReplaySession => 'Replay this session';

  @override
  String get summaryRetryMistakes => 'Review my mistakes';

  @override
  String get summaryIncreaseDifficulty => 'Increase difficulty';

  @override
  String get summaryBackToExercises => 'Back to exercises';

  @override
  String get summaryAccuracy => 'Accuracy';

  @override
  String get summaryAverageTime => 'Average time';

  @override
  String get summaryReplays => 'Replays';

  @override
  String get summaryBestStreak => 'Best streak';

  @override
  String get summarySkipped => 'Skipped';

  @override
  String get summaryHardest => 'Hardest';

  @override
  String get summaryCommonConfusion => 'Common confusion';

  @override
  String get statsTitle => 'Progress';

  @override
  String get statsSubtitle => 'Analysis of your performance';

  @override
  String get statsIntervalDetail => 'Interval detail';

  @override
  String get statsDays => 'Days';

  @override
  String get statsIntervals => 'Intervals';

  @override
  String get statsLevels => 'Levels';

  @override
  String statsAverage(int percentage) {
    return 'Avg. $percentage%';
  }

  @override
  String get intervalUnisonLabel => 'Unison';

  @override
  String get intervalUnisonSensation => 'Same identity, same pitch';

  @override
  String get intervalMinorSecondLabel => 'Minor Second';

  @override
  String get intervalMinorSecondSensation => 'Very close, tense';

  @override
  String get intervalMajorSecondLabel => 'Major Second';

  @override
  String get intervalMajorSecondSensation => 'Small melodic movement';

  @override
  String get intervalMinorThirdLabel => 'Minor Third';

  @override
  String get intervalMinorThirdSensation => 'Minor color';

  @override
  String get intervalMajorThirdLabel => 'Major Third';

  @override
  String get intervalMajorThirdSensation => 'Major color';

  @override
  String get intervalPerfectFourthLabel => 'Perfect Fourth';

  @override
  String get intervalPerfectFourthSensation => 'Open, suspended';

  @override
  String get intervalTritoneLabel => 'Tritone';

  @override
  String get intervalTritoneSensation => 'Unstable, very tense';

  @override
  String get intervalPerfectFifthLabel => 'Perfect Fifth';

  @override
  String get intervalPerfectFifthSensation => 'Stable, powerful';

  @override
  String get intervalMinorSixthLabel => 'Minor Sixth';

  @override
  String get intervalMinorSixthSensation => 'Nostalgic, soft';

  @override
  String get intervalMajorSixthLabel => 'Major Sixth';

  @override
  String get intervalMajorSixthSensation => 'Open, bright';

  @override
  String get intervalMinorSeventhLabel => 'Minor Seventh';

  @override
  String get intervalMinorSeventhSensation => 'Tense, unresolved';

  @override
  String get intervalMajorSeventhLabel => 'Major Seventh';

  @override
  String get intervalMajorSeventhSensation => 'Very tense, bright';

  @override
  String get intervalOctaveLabel => 'Octave';

  @override
  String get intervalOctaveSensation => 'Same identity, different height';

  @override
  String get coursePrevious => 'Indietro';

  @override
  String get courseNext => 'Avanti';

  @override
  String get courseStartDrill => 'Avvia esercizio';

  @override
  String get courseRecommended => 'Consigliato';

  @override
  String get courseCompleted => 'Completato';

  @override
  String get courseLearnFirst => 'Impara prima';

  @override
  String get coursePlayDemo => 'Ascolta l\'esempio';

  @override
  String courseEstimatedMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get learnTabTitle => 'Impara';

  @override
  String get learnTabSubtitle => 'Brevi lezioni prima di ogni esercizio.';

  @override
  String get courseEarTrainingBasicsTitle => 'Come allenare l’orecchio';

  @override
  String get courseEarTrainingBasicsGoal =>
      'Impara la routine prima del primo esercizio.';

  @override
  String get courseEarTrainingBasicsCard1Title => 'Concetto';

  @override
  String get courseEarTrainingBasicsCard1Body =>
      'Un intervallo è la distanza tra due note. Qui devi riconoscere quella distanza a orecchio.';

  @override
  String get courseEarTrainingBasicsCard2Title => 'Indizio d’ascolto';

  @override
  String get courseEarTrainingBasicsCard2Body =>
      'Non cercare i nomi delle note. Ascolta dimensione, colore e stabilità: piccolo/grande, teso/calmo, scuro/luminoso.';

  @override
  String get courseEarTrainingBasicsCard3Title => 'Mini esercizio';

  @override
  String get courseEarTrainingBasicsCard3Body =>
      'Riproduci l’esempio, fai una pausa e di se sembra uguale, vicino, aperto o lontano prima di rispondere.';

  @override
  String get courseIntervalDirectionTitle =>
      'Ascendente, discendente, armonico';

  @override
  String get courseIntervalDirectionGoal =>
      'Riconosci i tre modi di suonare lo stesso intervallo.';

  @override
  String get courseIntervalDirectionCard1Title => 'Concetto';

  @override
  String get courseIntervalDirectionCard1Body =>
      'Ascendente va dal grave all’acuto. Discendente dall’acuto al grave. Armonico suona le due note insieme.';

  @override
  String get courseIntervalDirectionCard2Title => 'Indizio d’ascolto';

  @override
  String get courseIntervalDirectionCard2Body =>
      'Il nome dell’intervallo resta uguale anche se cambia direzione. Cambia la sensazione, non la distanza.';

  @override
  String get courseIntervalDirectionCard3Title => 'Mini esercizio';

  @override
  String get courseIntervalDirectionCard3Body =>
      'Suona lo stesso intervallo nelle tre direzioni: riconosci prima la direzione, poi l’intervallo.';

  @override
  String get coursePracticeStrategyTitle => 'Allenarsi senza indovinare';

  @override
  String get coursePracticeStrategyGoal =>
      'Usa riascolti e esitazioni nel modo giusto.';

  @override
  String get coursePracticeStrategyCard1Title => 'Concetto';

  @override
  String get coursePracticeStrategyCard1Body =>
      'La precisione conta più della velocità. Una risposta lenta ma giusta costruisce la mappa; un tentativo a caso crea rumore.';

  @override
  String get coursePracticeStrategyCard2Title => 'Indizio d’ascolto';

  @override
  String get coursePracticeStrategyCard2Body =>
      'Riascolta una volta per la forma e una per la sensazione. Poi rispondi e impara dal confronto.';

  @override
  String get coursePracticeStrategyCard3Title => 'Mini esercizio';

  @override
  String get coursePracticeStrategyCard3Body =>
      'Se hai dubbi, segna l’esitazione dopo la risposta. Gli intervalli giusti ma fragili restano visibili nei progressi.';

  @override
  String get courseUnisonTitle => 'Unisono';

  @override
  String get courseUnisonGoal => 'Riconoscere Unisono dal suono.';

  @override
  String get courseUnisonCard1Title => 'Cosa ascoltare';

  @override
  String get courseUnisonCard1Body =>
      'Concentrati sulla sensazione: stessa nota, nessuna distanza';

  @override
  String get courseUnisonCard2Title => 'Confrontalo';

  @override
  String get courseUnisonCard2Body =>
      'Confronta Unisono con Ottava. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseUnisonCard3Title => 'Mini esercizio';

  @override
  String get courseUnisonCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseOctaveTitle => 'Ottava';

  @override
  String get courseOctaveGoal => 'Riconoscere Ottava dal suono.';

  @override
  String get courseOctaveCard1Title => 'Cosa ascoltare';

  @override
  String get courseOctaveCard1Body =>
      'Concentrati sulla sensazione: stessa identità, altra altezza';

  @override
  String get courseOctaveCard2Title => 'Confrontalo';

  @override
  String get courseOctaveCard2Body =>
      'Confronta Ottava con Unisono. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseOctaveCard3Title => 'Mini esercizio';

  @override
  String get courseOctaveCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get coursePerfectFifthTitle => 'Quinta giusta';

  @override
  String get coursePerfectFifthGoal => 'Riconoscere Quinta giusta dal suono.';

  @override
  String get coursePerfectFifthCard1Title => 'Cosa ascoltare';

  @override
  String get coursePerfectFifthCard1Body =>
      'Concentrati sulla sensazione: stabile, aperta, potente';

  @override
  String get coursePerfectFifthCard2Title => 'Confrontalo';

  @override
  String get coursePerfectFifthCard2Body =>
      'Confronta Quinta giusta con Quarta giusta. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get coursePerfectFifthCard3Title => 'Mini esercizio';

  @override
  String get coursePerfectFifthCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMinorThirdTitle => 'Terza minore';

  @override
  String get courseMinorThirdGoal => 'Riconoscere Terza minore dal suono.';

  @override
  String get courseMinorThirdCard1Title => 'Cosa ascoltare';

  @override
  String get courseMinorThirdCard1Body =>
      'Concentrati sulla sensazione: salto piccolo, colore scuro';

  @override
  String get courseMinorThirdCard2Title => 'Confrontalo';

  @override
  String get courseMinorThirdCard2Body =>
      'Confronta Terza minore con Terza maggiore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMinorThirdCard3Title => 'Mini esercizio';

  @override
  String get courseMinorThirdCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMajorThirdTitle => 'Terza maggiore';

  @override
  String get courseMajorThirdGoal => 'Riconoscere Terza maggiore dal suono.';

  @override
  String get courseMajorThirdCard1Title => 'Cosa ascoltare';

  @override
  String get courseMajorThirdCard1Body =>
      'Concentrati sulla sensazione: salto piccolo, colore luminoso';

  @override
  String get courseMajorThirdCard2Title => 'Confrontalo';

  @override
  String get courseMajorThirdCard2Body =>
      'Confronta Terza maggiore con Terza minore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMajorThirdCard3Title => 'Mini esercizio';

  @override
  String get courseMajorThirdCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get coursePerfectFourthTitle => 'Quarta giusta';

  @override
  String get coursePerfectFourthGoal => 'Riconoscere Quarta giusta dal suono.';

  @override
  String get coursePerfectFourthCard1Title => 'Cosa ascoltare';

  @override
  String get coursePerfectFourthCard1Body =>
      'Concentrati sulla sensazione: aperta, sospesa, in attesa';

  @override
  String get coursePerfectFourthCard2Title => 'Confrontalo';

  @override
  String get coursePerfectFourthCard2Body =>
      'Confronta Quarta giusta con Quinta giusta. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get coursePerfectFourthCard3Title => 'Mini esercizio';

  @override
  String get coursePerfectFourthCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMinorSecondTitle => 'Seconda minore';

  @override
  String get courseMinorSecondGoal => 'Riconoscere Seconda minore dal suono.';

  @override
  String get courseMinorSecondCard1Title => 'Cosa ascoltare';

  @override
  String get courseMinorSecondCard1Body =>
      'Concentrati sulla sensazione: molto vicina e tesa';

  @override
  String get courseMinorSecondCard2Title => 'Confrontalo';

  @override
  String get courseMinorSecondCard2Body =>
      'Confronta Seconda minore con Seconda maggiore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMinorSecondCard3Title => 'Mini esercizio';

  @override
  String get courseMinorSecondCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMajorSecondTitle => 'Seconda maggiore';

  @override
  String get courseMajorSecondGoal => 'Riconoscere Seconda maggiore dal suono.';

  @override
  String get courseMajorSecondCard1Title => 'Cosa ascoltare';

  @override
  String get courseMajorSecondCard1Body =>
      'Concentrati sulla sensazione: piccolo movimento naturale';

  @override
  String get courseMajorSecondCard2Title => 'Confrontalo';

  @override
  String get courseMajorSecondCard2Body =>
      'Confronta Seconda maggiore con Seconda minore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMajorSecondCard3Title => 'Mini esercizio';

  @override
  String get courseMajorSecondCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMinorSixthTitle => 'Sesta minore';

  @override
  String get courseMinorSixthGoal => 'Riconoscere Sesta minore dal suono.';

  @override
  String get courseMinorSixthCard1Title => 'Cosa ascoltare';

  @override
  String get courseMinorSixthCard1Body =>
      'Concentrati sulla sensazione: ampia, dolce, nostalgica';

  @override
  String get courseMinorSixthCard2Title => 'Confrontalo';

  @override
  String get courseMinorSixthCard2Body =>
      'Confronta Sesta minore con Sesta maggiore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMinorSixthCard3Title => 'Mini esercizio';

  @override
  String get courseMinorSixthCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMajorSixthTitle => 'Sesta maggiore';

  @override
  String get courseMajorSixthGoal => 'Riconoscere Sesta maggiore dal suono.';

  @override
  String get courseMajorSixthCard1Title => 'Cosa ascoltare';

  @override
  String get courseMajorSixthCard1Body =>
      'Concentrati sulla sensazione: ampia, luminosa, aperta';

  @override
  String get courseMajorSixthCard2Title => 'Confrontalo';

  @override
  String get courseMajorSixthCard2Body =>
      'Confronta Sesta maggiore con Sesta minore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMajorSixthCard3Title => 'Mini esercizio';

  @override
  String get courseMajorSixthCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMinorSeventhTitle => 'Settima minore';

  @override
  String get courseMinorSeventhGoal => 'Riconoscere Settima minore dal suono.';

  @override
  String get courseMinorSeventhCard1Title => 'Cosa ascoltare';

  @override
  String get courseMinorSeventhCard1Body =>
      'Concentrati sulla sensazione: ampia, tesa, irrisolta';

  @override
  String get courseMinorSeventhCard2Title => 'Confrontalo';

  @override
  String get courseMinorSeventhCard2Body =>
      'Confronta Settima minore con Settima maggiore. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMinorSeventhCard3Title => 'Mini esercizio';

  @override
  String get courseMinorSeventhCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseMajorSeventhTitle => 'Settima maggiore';

  @override
  String get courseMajorSeventhGoal =>
      'Riconoscere Settima maggiore dal suono.';

  @override
  String get courseMajorSeventhCard1Title => 'Cosa ascoltare';

  @override
  String get courseMajorSeventhCard1Body =>
      'Concentrati sulla sensazione: quasi ottava, molto tesa';

  @override
  String get courseMajorSeventhCard2Title => 'Confrontalo';

  @override
  String get courseMajorSeventhCard2Body =>
      'Confronta Settima maggiore con Ottava. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseMajorSeventhCard3Title => 'Mini esercizio';

  @override
  String get courseMajorSeventhCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseTritoneTitle => 'Tritono';

  @override
  String get courseTritoneGoal => 'Riconoscere Tritono dal suono.';

  @override
  String get courseTritoneCard1Title => 'Cosa ascoltare';

  @override
  String get courseTritoneCard1Body =>
      'Concentrati sulla sensazione: instabile, strana, divisa';

  @override
  String get courseTritoneCard2Title => 'Confrontalo';

  @override
  String get courseTritoneCard2Body =>
      'Confronta Tritono con Quinta giusta. Dai prima un nome alla dimensione, poi al colore.';

  @override
  String get courseTritoneCard3Title => 'Mini esercizio';

  @override
  String get courseTritoneCard3Body =>
      'Inizia con 5 domande usando solo questo intervallo e la confusione più vicina. Poi rimettilo nell’esercizio normale.';

  @override
  String get courseAscendingIntervalsTitle =>
      'Padroneggiare gli intervalli ascendenti';

  @override
  String get courseAscendingIntervalsGoal =>
      'Sentire la distanza quando la melodia sale.';

  @override
  String get courseAscendingIntervalsCard1Title => 'Concetto';

  @override
  String get courseAscendingIntervalsCard1Body =>
      'La prima nota è la fondamentale. La seconda indica la grandezza dell’intervallo verso l’alto.';

  @override
  String get courseAscendingIntervalsCard2Title => 'Indizio d’ascolto';

  @override
  String get courseAscendingIntervalsCard2Body =>
      'Canta mentalmente la prima nota e senti quanto sale la seconda.';

  @override
  String get courseAscendingIntervalsCard3Title => 'Mini esercizio';

  @override
  String get courseAscendingIntervalsCard3Body =>
      'Inizia con unisono, ottava, quinta e terze prima di aggiungere seconde e settime.';

  @override
  String get courseDescendingIntervalsTitle =>
      'Padroneggiare gli intervalli discendenti';

  @override
  String get courseDescendingIntervalsGoal =>
      'Riconoscere la stessa distanza quando la melodia scende.';

  @override
  String get courseDescendingIntervalsCard1Title => 'Concetto';

  @override
  String get courseDescendingIntervalsCard1Body =>
      'La prima nota è acuta, poi il suono scende alla fondamentale. Il nome resta la distanza.';

  @override
  String get courseDescendingIntervalsCard2Title => 'Indizio d’ascolto';

  @override
  String get courseDescendingIntervalsCard2Body =>
      'Non rispondere automaticamente “più basso”. Tieni la prima nota in memoria e misura la discesa.';

  @override
  String get courseDescendingIntervalsCard3Title => 'Mini esercizio';

  @override
  String get courseDescendingIntervalsCard3Body =>
      'Esercitati sullo stesso intervallo ascendente e discendente finché la distanza sembra uguale.';

  @override
  String get courseHarmonicIntervalsTitle => 'Sentire due note insieme';

  @override
  String get courseHarmonicIntervalsGoal =>
      'Identificare intervalli quando le due note suonano insieme.';

  @override
  String get courseHarmonicIntervalsCard1Title => 'Concetto';

  @override
  String get courseHarmonicIntervalsCard1Body =>
      'Le due note arrivano insieme: senti più il colore che la melodia.';

  @override
  String get courseHarmonicIntervalsCard2Title => 'Indizio d’ascolto';

  @override
  String get courseHarmonicIntervalsCard2Body =>
      'Ascolta stabilità e tensione: calma, aperta, luminosa, scura, stridente, irrisolta.';

  @override
  String get courseHarmonicIntervalsCard3Title => 'Mini esercizio';

  @override
  String get courseHarmonicIntervalsCard3Body =>
      'Dopo un errore, riascolta l’intervallo corretto e dai un nome al suo colore.';

  @override
  String get courseMixedIntervalsTitle => 'Sopravvivere agli intervalli misti';

  @override
  String get courseMixedIntervalsGoal =>
      'Rispondere per distanza anche quando la direzione cambia a ogni domanda.';

  @override
  String get courseMixedIntervalsCard1Title => 'Concetto';

  @override
  String get courseMixedIntervalsCard1Body =>
      'La modalità mista toglie le rotelle. Ogni domanda può cambiare direzione.';

  @override
  String get courseMixedIntervalsCard2Title => 'Indizio d’ascolto';

  @override
  String get courseMixedIntervalsCard2Body =>
      'Riconosci prima la direzione, poi la distanza. Non lasciare che la direzione rubi la risposta.';

  @override
  String get courseMixedIntervalsCard3Title => 'Mini esercizio';

  @override
  String get courseMixedIntervalsCard3Body =>
      'Usa prima intervalli facili, poi sblocca tutti quando la precisione è stabile.';

  @override
  String get courseMistakeReviewTitle =>
      'Trasformare gli errori in allenamento';

  @override
  String get courseMistakeReviewGoal =>
      'Usa il riepilogo per colpire i veri punti deboli.';

  @override
  String get courseMistakeReviewCard1Title => 'Concetto';

  @override
  String get courseMistakeReviewCard1Body =>
      'Un errore è un indizio. La confusione mostra quali due suoni il tuo orecchio unisce.';

  @override
  String get courseMistakeReviewCard2Title => 'Indizio d’ascolto';

  @override
  String get courseMistakeReviewCard2Body =>
      'Usa “Rivedi gli errori” finché il suono è ancora fresco.';

  @override
  String get courseMistakeReviewCard3Title => 'Mini esercizio';

  @override
  String get courseMistakeReviewCard3Body =>
      'Allena solo gli intervalli sbagliati per una sessione breve, poi torna al misto.';
}
