// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'The Perfect Pitch';

  @override
  String get navHome => 'Start';

  @override
  String get navExercises => 'Übungen';

  @override
  String get navLearn => 'Lernen';

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
  String get coursePrevious => 'Zurück';

  @override
  String get courseNext => 'Weiter';

  @override
  String get courseStartDrill => 'Übung starten';

  @override
  String get courseRecommended => 'Empfohlen';

  @override
  String get courseCompleted => 'Abgeschlossen';

  @override
  String get courseLearnFirst => 'Zuerst lernen';

  @override
  String get coursePlayDemo => 'Beispiel abspielen';

  @override
  String courseEstimatedMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String get learnTabTitle => 'Lernen';

  @override
  String get learnTabSubtitle => 'Kurze Lektionen vor jeder Übung.';

  @override
  String get courseEarTrainingBasicsTitle => 'So trainierst du dein Gehör';

  @override
  String get courseEarTrainingBasicsGoal =>
      'Lerne die Routine vor der ersten Übung.';

  @override
  String get courseEarTrainingBasicsCard1Title => 'Konzept';

  @override
  String get courseEarTrainingBasicsCard1Body =>
      'Ein Intervall ist der Abstand zwischen zwei Tönen. Hier benennst du diesen Abstand nach Gehör.';

  @override
  String get courseEarTrainingBasicsCard2Title => 'Hörhinweis';

  @override
  String get courseEarTrainingBasicsCard2Body =>
      'Suche nicht nach Notennamen. Höre auf Größe, Farbe und Stabilität: klein/groß, gespannt/ruhig, dunkel/hell.';

  @override
  String get courseEarTrainingBasicsCard3Title => 'Mini-Übung';

  @override
  String get courseEarTrainingBasicsCard3Body =>
      'Spiele das Beispiel, pausiere und sage erst, ob es gleich, nah, offen oder weit klingt.';

  @override
  String get courseIntervalDirectionTitle => 'Aufwärts, abwärts, harmonisch';

  @override
  String get courseIntervalDirectionGoal =>
      'Erkenne die drei Spielweisen desselben Intervalls.';

  @override
  String get courseIntervalDirectionCard1Title => 'Konzept';

  @override
  String get courseIntervalDirectionCard1Body =>
      'Aufwärts geht von tief nach hoch. Abwärts geht von hoch nach tief. Harmonisch spielt beide Töne zusammen.';

  @override
  String get courseIntervalDirectionCard2Title => 'Hörhinweis';

  @override
  String get courseIntervalDirectionCard2Body =>
      'Der Intervallname bleibt gleich, auch wenn die Richtung wechselt. Die Richtung ändert das Gefühl, nicht den Abstand.';

  @override
  String get courseIntervalDirectionCard3Title => 'Mini-Übung';

  @override
  String get courseIntervalDirectionCard3Body =>
      'Spiele dasselbe Intervall in allen drei Richtungen: erkenne zuerst die Richtung, dann das Intervall.';

  @override
  String get coursePracticeStrategyTitle => 'Üben ohne zu raten';

  @override
  String get coursePracticeStrategyGoal =>
      'Nutze Wiederholungen und Zögern sinnvoll.';

  @override
  String get coursePracticeStrategyCard1Title => 'Konzept';

  @override
  String get coursePracticeStrategyCard1Body =>
      'Genauigkeit ist wichtiger als Tempo. Eine langsame richtige Antwort baut die Karte auf; schnelles Raten stört sie.';

  @override
  String get coursePracticeStrategyCard2Title => 'Hörhinweis';

  @override
  String get coursePracticeStrategyCard2Body =>
      'Höre einmal für die Form, einmal für das Gefühl. Danach antworte und lerne aus dem Vergleich.';

  @override
  String get coursePracticeStrategyCard3Title => 'Mini-Übung';

  @override
  String get coursePracticeStrategyCard3Body =>
      'Wenn du unsicher bist, markiere nach der Antwort das Zögern. So bleiben fragile Treffer sichtbar.';

  @override
  String get courseUnisonTitle => 'Prime';

  @override
  String get courseUnisonGoal => 'Prime am Klang erkennen.';

  @override
  String get courseUnisonCard1Title => 'Worauf hören';

  @override
  String get courseUnisonCard1Body =>
      'Achte auf das Gefühl: gleicher Ton, kein Abstand';

  @override
  String get courseUnisonCard2Title => 'Vergleiche es';

  @override
  String get courseUnisonCard2Body =>
      'Vergleiche Prime mit Oktave. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseUnisonCard3Title => 'Mini-Übung';

  @override
  String get courseUnisonCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseOctaveTitle => 'Oktave';

  @override
  String get courseOctaveGoal => 'Oktave am Klang erkennen.';

  @override
  String get courseOctaveCard1Title => 'Worauf hören';

  @override
  String get courseOctaveCard1Body =>
      'Achte auf das Gefühl: gleiche Identität, andere Höhe';

  @override
  String get courseOctaveCard2Title => 'Vergleiche es';

  @override
  String get courseOctaveCard2Body =>
      'Vergleiche Oktave mit Prime. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseOctaveCard3Title => 'Mini-Übung';

  @override
  String get courseOctaveCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get coursePerfectFifthTitle => 'Reine Quinte';

  @override
  String get coursePerfectFifthGoal => 'Reine Quinte am Klang erkennen.';

  @override
  String get coursePerfectFifthCard1Title => 'Worauf hören';

  @override
  String get coursePerfectFifthCard1Body =>
      'Achte auf das Gefühl: stabil, offen, kraftvoll';

  @override
  String get coursePerfectFifthCard2Title => 'Vergleiche es';

  @override
  String get coursePerfectFifthCard2Body =>
      'Vergleiche Reine Quinte mit Reine Quarte. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get coursePerfectFifthCard3Title => 'Mini-Übung';

  @override
  String get coursePerfectFifthCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMinorThirdTitle => 'Kleine Terz';

  @override
  String get courseMinorThirdGoal => 'Kleine Terz am Klang erkennen.';

  @override
  String get courseMinorThirdCard1Title => 'Worauf hören';

  @override
  String get courseMinorThirdCard1Body =>
      'Achte auf das Gefühl: kleiner Sprung, dunklere Farbe';

  @override
  String get courseMinorThirdCard2Title => 'Vergleiche es';

  @override
  String get courseMinorThirdCard2Body =>
      'Vergleiche Kleine Terz mit Große Terz. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMinorThirdCard3Title => 'Mini-Übung';

  @override
  String get courseMinorThirdCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMajorThirdTitle => 'Große Terz';

  @override
  String get courseMajorThirdGoal => 'Große Terz am Klang erkennen.';

  @override
  String get courseMajorThirdCard1Title => 'Worauf hören';

  @override
  String get courseMajorThirdCard1Body =>
      'Achte auf das Gefühl: kleiner Sprung, hellere Farbe';

  @override
  String get courseMajorThirdCard2Title => 'Vergleiche es';

  @override
  String get courseMajorThirdCard2Body =>
      'Vergleiche Große Terz mit Kleine Terz. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMajorThirdCard3Title => 'Mini-Übung';

  @override
  String get courseMajorThirdCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get coursePerfectFourthTitle => 'Reine Quarte';

  @override
  String get coursePerfectFourthGoal => 'Reine Quarte am Klang erkennen.';

  @override
  String get coursePerfectFourthCard1Title => 'Worauf hören';

  @override
  String get coursePerfectFourthCard1Body =>
      'Achte auf das Gefühl: offen, schwebend, wartend';

  @override
  String get coursePerfectFourthCard2Title => 'Vergleiche es';

  @override
  String get coursePerfectFourthCard2Body =>
      'Vergleiche Reine Quarte mit Reine Quinte. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get coursePerfectFourthCard3Title => 'Mini-Übung';

  @override
  String get coursePerfectFourthCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMinorSecondTitle => 'Kleine Sekunde';

  @override
  String get courseMinorSecondGoal => 'Kleine Sekunde am Klang erkennen.';

  @override
  String get courseMinorSecondCard1Title => 'Worauf hören';

  @override
  String get courseMinorSecondCard1Body =>
      'Achte auf das Gefühl: sehr nah und gespannt';

  @override
  String get courseMinorSecondCard2Title => 'Vergleiche es';

  @override
  String get courseMinorSecondCard2Body =>
      'Vergleiche Kleine Sekunde mit Große Sekunde. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMinorSecondCard3Title => 'Mini-Übung';

  @override
  String get courseMinorSecondCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMajorSecondTitle => 'Große Sekunde';

  @override
  String get courseMajorSecondGoal => 'Große Sekunde am Klang erkennen.';

  @override
  String get courseMajorSecondCard1Title => 'Worauf hören';

  @override
  String get courseMajorSecondCard1Body =>
      'Achte auf das Gefühl: kleine natürliche Bewegung';

  @override
  String get courseMajorSecondCard2Title => 'Vergleiche es';

  @override
  String get courseMajorSecondCard2Body =>
      'Vergleiche Große Sekunde mit Kleine Sekunde. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMajorSecondCard3Title => 'Mini-Übung';

  @override
  String get courseMajorSecondCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMinorSixthTitle => 'Kleine Sexte';

  @override
  String get courseMinorSixthGoal => 'Kleine Sexte am Klang erkennen.';

  @override
  String get courseMinorSixthCard1Title => 'Worauf hören';

  @override
  String get courseMinorSixthCard1Body =>
      'Achte auf das Gefühl: weit, weich, nostalgisch';

  @override
  String get courseMinorSixthCard2Title => 'Vergleiche es';

  @override
  String get courseMinorSixthCard2Body =>
      'Vergleiche Kleine Sexte mit Große Sexte. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMinorSixthCard3Title => 'Mini-Übung';

  @override
  String get courseMinorSixthCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMajorSixthTitle => 'Große Sexte';

  @override
  String get courseMajorSixthGoal => 'Große Sexte am Klang erkennen.';

  @override
  String get courseMajorSixthCard1Title => 'Worauf hören';

  @override
  String get courseMajorSixthCard1Body =>
      'Achte auf das Gefühl: weit, hell, offen';

  @override
  String get courseMajorSixthCard2Title => 'Vergleiche es';

  @override
  String get courseMajorSixthCard2Body =>
      'Vergleiche Große Sexte mit Kleine Sexte. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMajorSixthCard3Title => 'Mini-Übung';

  @override
  String get courseMajorSixthCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMinorSeventhTitle => 'Kleine Septime';

  @override
  String get courseMinorSeventhGoal => 'Kleine Septime am Klang erkennen.';

  @override
  String get courseMinorSeventhCard1Title => 'Worauf hören';

  @override
  String get courseMinorSeventhCard1Body =>
      'Achte auf das Gefühl: weit, gespannt, ungelöst';

  @override
  String get courseMinorSeventhCard2Title => 'Vergleiche es';

  @override
  String get courseMinorSeventhCard2Body =>
      'Vergleiche Kleine Septime mit Große Septime. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMinorSeventhCard3Title => 'Mini-Übung';

  @override
  String get courseMinorSeventhCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseMajorSeventhTitle => 'Große Septime';

  @override
  String get courseMajorSeventhGoal => 'Große Septime am Klang erkennen.';

  @override
  String get courseMajorSeventhCard1Title => 'Worauf hören';

  @override
  String get courseMajorSeventhCard1Body =>
      'Achte auf das Gefühl: fast Oktave, sehr gespannt';

  @override
  String get courseMajorSeventhCard2Title => 'Vergleiche es';

  @override
  String get courseMajorSeventhCard2Body =>
      'Vergleiche Große Septime mit Oktave. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseMajorSeventhCard3Title => 'Mini-Übung';

  @override
  String get courseMajorSeventhCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseTritoneTitle => 'Tritonus';

  @override
  String get courseTritoneGoal => 'Tritonus am Klang erkennen.';

  @override
  String get courseTritoneCard1Title => 'Worauf hören';

  @override
  String get courseTritoneCard1Body =>
      'Achte auf das Gefühl: instabil, fremd, gespalten';

  @override
  String get courseTritoneCard2Title => 'Vergleiche es';

  @override
  String get courseTritoneCard2Body =>
      'Vergleiche Tritonus mit Reine Quinte. Benenne zuerst die Größe, dann die Farbe.';

  @override
  String get courseTritoneCard3Title => 'Mini-Übung';

  @override
  String get courseTritoneCard3Body =>
      'Beginne mit 5 Fragen nur zu diesem Intervall und seiner nächsten Verwechslung. Danach zurück in die normale Übung.';

  @override
  String get courseAscendingIntervalsTitle =>
      'Aufsteigende Intervalle meistern';

  @override
  String get courseAscendingIntervalsGoal =>
      'Den Abstand hören, wenn die Melodie aufwärts geht.';

  @override
  String get courseAscendingIntervalsCard1Title => 'Konzept';

  @override
  String get courseAscendingIntervalsCard1Body =>
      'Der erste Ton ist der Grundton. Der zweite zeigt die Intervallgröße nach oben.';

  @override
  String get courseAscendingIntervalsCard2Title => 'Hörhinweis';

  @override
  String get courseAscendingIntervalsCard2Body =>
      'Singe den ersten Ton innerlich und spüre, wie weit der zweite steigt.';

  @override
  String get courseAscendingIntervalsCard3Title => 'Mini-Übung';

  @override
  String get courseAscendingIntervalsCard3Body =>
      'Beginne mit Prime, Oktave, Quinte und Terzen, bevor Sekunden und Septimen dazukommen.';

  @override
  String get courseDescendingIntervalsTitle =>
      'Absteigende Intervalle meistern';

  @override
  String get courseDescendingIntervalsGoal =>
      'Denselben Abstand erkennen, wenn die Melodie fällt.';

  @override
  String get courseDescendingIntervalsCard1Title => 'Konzept';

  @override
  String get courseDescendingIntervalsCard1Body =>
      'Der erste Ton ist hoch, dann fällt der Klang zum Grundton. Der Name bleibt der Abstand.';

  @override
  String get courseDescendingIntervalsCard2Title => 'Hörhinweis';

  @override
  String get courseDescendingIntervalsCard2Body =>
      'Antworte nicht automatisch „tiefer“. Behalte den ersten Ton und miss den Fall.';

  @override
  String get courseDescendingIntervalsCard3Title => 'Mini-Übung';

  @override
  String get courseDescendingIntervalsCard3Body =>
      'Übe dasselbe Intervall aufwärts und abwärts, bis der Abstand gleich wirkt.';

  @override
  String get courseHarmonicIntervalsTitle => 'Zwei Töne zusammen hören';

  @override
  String get courseHarmonicIntervalsGoal =>
      'Intervalle erkennen, wenn beide Töne gleichzeitig klingen.';

  @override
  String get courseHarmonicIntervalsCard1Title => 'Konzept';

  @override
  String get courseHarmonicIntervalsCard1Body =>
      'Beide Töne kommen zusammen: Du hörst mehr Farbe als Melodie.';

  @override
  String get courseHarmonicIntervalsCard2Title => 'Hörhinweis';

  @override
  String get courseHarmonicIntervalsCard2Body =>
      'Höre auf Stabilität und Spannung: ruhig, offen, hell, dunkel, reibend, ungelöst.';

  @override
  String get courseHarmonicIntervalsCard3Title => 'Mini-Übung';

  @override
  String get courseHarmonicIntervalsCard3Body =>
      'Nach einem Fehler: Spiele die richtige Antwort erneut und benenne ihre Farbe.';

  @override
  String get courseMixedIntervalsTitle => 'Gemischte Intervalle meistern';

  @override
  String get courseMixedIntervalsGoal =>
      'Nach Abstand antworten, auch wenn die Richtung jede Frage wechselt.';

  @override
  String get courseMixedIntervalsCard1Title => 'Konzept';

  @override
  String get courseMixedIntervalsCard1Body =>
      'Der gemischte Modus nimmt die Stützräder weg. Jede Frage kann die Richtung ändern.';

  @override
  String get courseMixedIntervalsCard2Title => 'Hörhinweis';

  @override
  String get courseMixedIntervalsCard2Body =>
      'Erkenne zuerst die Richtung, dann den Abstand. Lass die Richtung nicht die Antwort stehlen.';

  @override
  String get courseMixedIntervalsCard3Title => 'Mini-Übung';

  @override
  String get courseMixedIntervalsCard3Body =>
      'Nutze zuerst einfache Intervalle und schalte alle frei, wenn die Genauigkeit stabil ist.';

  @override
  String get courseMistakeReviewTitle => 'Fehler in Training verwandeln';

  @override
  String get courseMistakeReviewGoal =>
      'Nutze die Zusammenfassung für deine echten Schwachstellen.';

  @override
  String get courseMistakeReviewCard1Title => 'Konzept';

  @override
  String get courseMistakeReviewCard1Body =>
      'Eine falsche Antwort ist ein Hinweis. Die Verwechslung zeigt, welche zwei Klänge dein Ohr vermischt.';

  @override
  String get courseMistakeReviewCard2Title => 'Hörhinweis';

  @override
  String get courseMistakeReviewCard2Body =>
      'Nutze „Fehler üben“, solange der Klang noch frisch ist.';

  @override
  String get courseMistakeReviewCard3Title => 'Mini-Übung';

  @override
  String get courseMistakeReviewCard3Body =>
      'Übe nur die verpassten Intervalle in einer kurzen Sitzung und kehre dann zum Mix zurück.';
}
