// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'The Perfect Pitch';

  @override
  String get navHome => 'Início';

  @override
  String get navExercises => 'Exercícios';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navGuitar => 'Guitarra';

  @override
  String get navProgress => 'Progresso';

  @override
  String streakDays(int days) {
    return '$days dias';
  }

  @override
  String get streakLabel => 'Sequência atual';

  @override
  String streakDaysUppercase(int days) {
    return '$days Dias';
  }

  @override
  String get homeGreeting => 'Olá!';

  @override
  String get homeSubtitle => 'O teu treino auditivo espera-te.';

  @override
  String get homeTodaySession => 'SESSÃO DE HOJE';

  @override
  String get homeSessionTitle => 'Quinta Perfeita\n& Comparação';

  @override
  String get homeSessionSubtitle => 'Aquecimento, novo intervalo e prática.';

  @override
  String get homeStartFiveMinutes => 'Iniciar (5 min)';

  @override
  String get homeRepertoire => 'O teu repertório';

  @override
  String get homeSeeAll => 'VER TUDO';

  @override
  String get discover => 'Por descobrir';

  @override
  String get learning => 'Em aprendizagem';

  @override
  String masteredAt(int percentage) {
    return 'Dominado a $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Uníssono\n& Oitava';

  @override
  String get repertoirePerfectFifth => 'Quinta\nPerfeita';

  @override
  String get practiceMode => 'MODO PRÁTICA';

  @override
  String get guitarTitle => 'O Braço';

  @override
  String get guitarPromptPrefix => 'Encontra a ';

  @override
  String get guitarPromptSuffix => ' a partir da nota fundamental iluminada.';

  @override
  String get guitarNextInterval => 'Próximo intervalo';

  @override
  String get exercisesTitle => 'Exercícios';

  @override
  String get exercisesSubtitle => 'Escolhe um treino de reconhecimento.';

  @override
  String get startSession => 'Iniciar sessão';

  @override
  String get settings => 'DEFINIÇÕES';

  @override
  String get intervalQuestionPrompt => 'Que intervalo é este?';

  @override
  String get languagePickerTooltip => 'Escolher idioma';

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
  String get coursePrevious => 'Anterior';

  @override
  String get courseNext => 'Próximo';

  @override
  String get courseStartDrill => 'Iniciar exercício';

  @override
  String get courseRecommended => 'Recomendado';

  @override
  String get courseCompleted => 'Concluído';

  @override
  String get courseLearnFirst => 'Aprender primeiro';

  @override
  String get coursePlayDemo => 'Ouvir exemplo';

  @override
  String courseEstimatedMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get learnTabTitle => 'Aprender';

  @override
  String get learnTabSubtitle => 'Lições curtas antes de cada exercício.';

  @override
  String get courseEarTrainingBasicsTitle => 'Como treinar o ouvido';

  @override
  String get courseEarTrainingBasicsGoal =>
      'Aprende a rotina antes do primeiro exercício.';

  @override
  String get courseEarTrainingBasicsCard1Title => 'Conceito';

  @override
  String get courseEarTrainingBasicsCard1Body =>
      'Um intervalo é a distância entre duas notas. Aqui, o objetivo é nomear essa distância de ouvido.';

  @override
  String get courseEarTrainingBasicsCard2Title => 'Pista auditiva';

  @override
  String get courseEarTrainingBasicsCard2Body =>
      'Não procures o nome das notas. Ouve tamanho, cor e estabilidade: pequeno/grande, tenso/calmo, escuro/brilhante.';

  @override
  String get courseEarTrainingBasicsCard3Title => 'Mini exercício';

  @override
  String get courseEarTrainingBasicsCard3Body =>
      'Toca o exemplo, faz uma pausa e diz se soa igual, próximo, aberto ou distante antes de responder.';

  @override
  String get courseIntervalDirectionTitle =>
      'Ascendente, descendente, harmónico';

  @override
  String get courseIntervalDirectionGoal =>
      'Reconhece as três formas de tocar o mesmo intervalo.';

  @override
  String get courseIntervalDirectionCard1Title => 'Conceito';

  @override
  String get courseIntervalDirectionCard1Body =>
      'Ascendente vai do grave ao agudo. Descendente vai do agudo ao grave. Harmónico toca as duas notas juntas.';

  @override
  String get courseIntervalDirectionCard2Title => 'Pista auditiva';

  @override
  String get courseIntervalDirectionCard2Body =>
      'O nome do intervalo não muda com a direção. A direção muda a sensação, não a distância.';

  @override
  String get courseIntervalDirectionCard3Title => 'Mini exercício';

  @override
  String get courseIntervalDirectionCard3Body =>
      'Toca o mesmo intervalo nas três direções: identifica primeiro a direção e depois o intervalo.';

  @override
  String get coursePracticeStrategyTitle => 'Praticar sem adivinhar';

  @override
  String get coursePracticeStrategyGoal =>
      'Usa repetições e hesitações da forma certa.';

  @override
  String get coursePracticeStrategyCard1Title => 'Conceito';

  @override
  String get coursePracticeStrategyCard1Body =>
      'A precisão vale mais que a velocidade. Uma resposta lenta e certa constrói o mapa; um palpite rápido cria ruído.';

  @override
  String get coursePracticeStrategyCard2Title => 'Pista auditiva';

  @override
  String get coursePracticeStrategyCard2Body =>
      'Ouve uma vez pela forma e outra pela sensação. Depois responde e aprende com a comparação.';

  @override
  String get coursePracticeStrategyCard3Title => 'Mini exercício';

  @override
  String get coursePracticeStrategyCard3Body =>
      'Quando houver dúvida, marca hesitação depois de responder. Assim os acertos frágeis continuam visíveis no progresso.';

  @override
  String get courseUnisonTitle => 'Uníssono';

  @override
  String get courseUnisonGoal => 'Reconhecer Uníssono pelo som.';

  @override
  String get courseUnisonCard1Title => 'O que ouvir';

  @override
  String get courseUnisonCard1Body =>
      'Concentra-te na sensação: mesma nota, nenhuma distância';

  @override
  String get courseUnisonCard2Title => 'Compara';

  @override
  String get courseUnisonCard2Body =>
      'Compara Uníssono com Oitava. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseUnisonCard3Title => 'Mini exercício';

  @override
  String get courseUnisonCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseOctaveTitle => 'Oitava';

  @override
  String get courseOctaveGoal => 'Reconhecer Oitava pelo som.';

  @override
  String get courseOctaveCard1Title => 'O que ouvir';

  @override
  String get courseOctaveCard1Body =>
      'Concentra-te na sensação: mesma identidade, outra altura';

  @override
  String get courseOctaveCard2Title => 'Compara';

  @override
  String get courseOctaveCard2Body =>
      'Compara Oitava com Uníssono. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseOctaveCard3Title => 'Mini exercício';

  @override
  String get courseOctaveCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get coursePerfectFifthTitle => 'Quinta perfeita';

  @override
  String get coursePerfectFifthGoal => 'Reconhecer Quinta perfeita pelo som.';

  @override
  String get coursePerfectFifthCard1Title => 'O que ouvir';

  @override
  String get coursePerfectFifthCard1Body =>
      'Concentra-te na sensação: estável, aberta, poderosa';

  @override
  String get coursePerfectFifthCard2Title => 'Compara';

  @override
  String get coursePerfectFifthCard2Body =>
      'Compara Quinta perfeita com Quarta perfeita. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get coursePerfectFifthCard3Title => 'Mini exercício';

  @override
  String get coursePerfectFifthCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMinorThirdTitle => 'Terça menor';

  @override
  String get courseMinorThirdGoal => 'Reconhecer Terça menor pelo som.';

  @override
  String get courseMinorThirdCard1Title => 'O que ouvir';

  @override
  String get courseMinorThirdCard1Body =>
      'Concentra-te na sensação: salto pequeno, cor escura';

  @override
  String get courseMinorThirdCard2Title => 'Compara';

  @override
  String get courseMinorThirdCard2Body =>
      'Compara Terça menor com Terça maior. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMinorThirdCard3Title => 'Mini exercício';

  @override
  String get courseMinorThirdCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMajorThirdTitle => 'Terça maior';

  @override
  String get courseMajorThirdGoal => 'Reconhecer Terça maior pelo som.';

  @override
  String get courseMajorThirdCard1Title => 'O que ouvir';

  @override
  String get courseMajorThirdCard1Body =>
      'Concentra-te na sensação: salto pequeno, cor luminosa';

  @override
  String get courseMajorThirdCard2Title => 'Compara';

  @override
  String get courseMajorThirdCard2Body =>
      'Compara Terça maior com Terça menor. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMajorThirdCard3Title => 'Mini exercício';

  @override
  String get courseMajorThirdCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get coursePerfectFourthTitle => 'Quarta perfeita';

  @override
  String get coursePerfectFourthGoal => 'Reconhecer Quarta perfeita pelo som.';

  @override
  String get coursePerfectFourthCard1Title => 'O que ouvir';

  @override
  String get coursePerfectFourthCard1Body =>
      'Concentra-te na sensação: aberta, suspensa, em espera';

  @override
  String get coursePerfectFourthCard2Title => 'Compara';

  @override
  String get coursePerfectFourthCard2Body =>
      'Compara Quarta perfeita com Quinta perfeita. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get coursePerfectFourthCard3Title => 'Mini exercício';

  @override
  String get coursePerfectFourthCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMinorSecondTitle => 'Segunda menor';

  @override
  String get courseMinorSecondGoal => 'Reconhecer Segunda menor pelo som.';

  @override
  String get courseMinorSecondCard1Title => 'O que ouvir';

  @override
  String get courseMinorSecondCard1Body =>
      'Concentra-te na sensação: muito próxima e tensa';

  @override
  String get courseMinorSecondCard2Title => 'Compara';

  @override
  String get courseMinorSecondCard2Body =>
      'Compara Segunda menor com Segunda maior. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMinorSecondCard3Title => 'Mini exercício';

  @override
  String get courseMinorSecondCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMajorSecondTitle => 'Segunda maior';

  @override
  String get courseMajorSecondGoal => 'Reconhecer Segunda maior pelo som.';

  @override
  String get courseMajorSecondCard1Title => 'O que ouvir';

  @override
  String get courseMajorSecondCard1Body =>
      'Concentra-te na sensação: pequeno movimento natural';

  @override
  String get courseMajorSecondCard2Title => 'Compara';

  @override
  String get courseMajorSecondCard2Body =>
      'Compara Segunda maior com Segunda menor. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMajorSecondCard3Title => 'Mini exercício';

  @override
  String get courseMajorSecondCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMinorSixthTitle => 'Sexta menor';

  @override
  String get courseMinorSixthGoal => 'Reconhecer Sexta menor pelo som.';

  @override
  String get courseMinorSixthCard1Title => 'O que ouvir';

  @override
  String get courseMinorSixthCard1Body =>
      'Concentra-te na sensação: ampla, suave, nostálgica';

  @override
  String get courseMinorSixthCard2Title => 'Compara';

  @override
  String get courseMinorSixthCard2Body =>
      'Compara Sexta menor com Sexta maior. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMinorSixthCard3Title => 'Mini exercício';

  @override
  String get courseMinorSixthCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMajorSixthTitle => 'Sexta maior';

  @override
  String get courseMajorSixthGoal => 'Reconhecer Sexta maior pelo som.';

  @override
  String get courseMajorSixthCard1Title => 'O que ouvir';

  @override
  String get courseMajorSixthCard1Body =>
      'Concentra-te na sensação: ampla, luminosa, aberta';

  @override
  String get courseMajorSixthCard2Title => 'Compara';

  @override
  String get courseMajorSixthCard2Body =>
      'Compara Sexta maior com Sexta menor. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMajorSixthCard3Title => 'Mini exercício';

  @override
  String get courseMajorSixthCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMinorSeventhTitle => 'Sétima menor';

  @override
  String get courseMinorSeventhGoal => 'Reconhecer Sétima menor pelo som.';

  @override
  String get courseMinorSeventhCard1Title => 'O que ouvir';

  @override
  String get courseMinorSeventhCard1Body =>
      'Concentra-te na sensação: ampla, tensa, por resolver';

  @override
  String get courseMinorSeventhCard2Title => 'Compara';

  @override
  String get courseMinorSeventhCard2Body =>
      'Compara Sétima menor com Sétima maior. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMinorSeventhCard3Title => 'Mini exercício';

  @override
  String get courseMinorSeventhCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseMajorSeventhTitle => 'Sétima maior';

  @override
  String get courseMajorSeventhGoal => 'Reconhecer Sétima maior pelo som.';

  @override
  String get courseMajorSeventhCard1Title => 'O que ouvir';

  @override
  String get courseMajorSeventhCard1Body =>
      'Concentra-te na sensação: quase oitava, muito tensa';

  @override
  String get courseMajorSeventhCard2Title => 'Compara';

  @override
  String get courseMajorSeventhCard2Body =>
      'Compara Sétima maior com Oitava. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseMajorSeventhCard3Title => 'Mini exercício';

  @override
  String get courseMajorSeventhCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseTritoneTitle => 'Trítono';

  @override
  String get courseTritoneGoal => 'Reconhecer Trítono pelo som.';

  @override
  String get courseTritoneCard1Title => 'O que ouvir';

  @override
  String get courseTritoneCard1Body =>
      'Concentra-te na sensação: instável, estranha, dividida';

  @override
  String get courseTritoneCard2Title => 'Compara';

  @override
  String get courseTritoneCard2Body =>
      'Compara Trítono com Quinta perfeita. Nomeia primeiro o tamanho e depois a cor.';

  @override
  String get courseTritoneCard3Title => 'Mini exercício';

  @override
  String get courseTritoneCard3Body =>
      'Começa com 5 perguntas usando só este intervalo e a confusão mais próxima. Depois volta ao exercício normal.';

  @override
  String get courseAscendingIntervalsTitle => 'Dominar intervalos ascendentes';

  @override
  String get courseAscendingIntervalsGoal =>
      'Ouvir a distância quando a melodia sobe.';

  @override
  String get courseAscendingIntervalsCard1Title => 'Conceito';

  @override
  String get courseAscendingIntervalsCard1Body =>
      'A primeira nota é a fundamental. A segunda indica o tamanho do intervalo para cima.';

  @override
  String get courseAscendingIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseAscendingIntervalsCard2Body =>
      'Canta a primeira nota na cabeça e sente quanto a segunda sobe.';

  @override
  String get courseAscendingIntervalsCard3Title => 'Mini exercício';

  @override
  String get courseAscendingIntervalsCard3Body =>
      'Começa com uníssono, oitava, quinta e terças antes de acrescentar segundas e sétimas.';

  @override
  String get courseDescendingIntervalsTitle =>
      'Dominar intervalos descendentes';

  @override
  String get courseDescendingIntervalsGoal =>
      'Reconhecer a mesma distância quando a melodia desce.';

  @override
  String get courseDescendingIntervalsCard1Title => 'Conceito';

  @override
  String get courseDescendingIntervalsCard1Body =>
      'A primeira nota é aguda e depois desce até à fundamental. O nome continua a ser a distância.';

  @override
  String get courseDescendingIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseDescendingIntervalsCard2Body =>
      'Não respondas “mais baixo” automaticamente. Guarda a primeira nota e mede a descida.';

  @override
  String get courseDescendingIntervalsCard3Title => 'Mini exercício';

  @override
  String get courseDescendingIntervalsCard3Body =>
      'Pratica o mesmo intervalo ascendente e descendente até a distância parecer igual.';

  @override
  String get courseHarmonicIntervalsTitle => 'Ouvir duas notas juntas';

  @override
  String get courseHarmonicIntervalsGoal =>
      'Identificar intervalos quando as duas notas soam ao mesmo tempo.';

  @override
  String get courseHarmonicIntervalsCard1Title => 'Conceito';

  @override
  String get courseHarmonicIntervalsCard1Body =>
      'As duas notas chegam juntas: ouves mais a cor do que a melodia.';

  @override
  String get courseHarmonicIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseHarmonicIntervalsCard2Body =>
      'Ouve estabilidade e tensão: calmo, aberto, luminoso, escuro, roçante, por resolver.';

  @override
  String get courseHarmonicIntervalsCard3Title => 'Mini exercício';

  @override
  String get courseHarmonicIntervalsCard3Body =>
      'Depois de um erro, repete o intervalo correto e nomeia a sua cor antes de continuar.';

  @override
  String get courseMixedIntervalsTitle => 'Sobreviver aos intervalos mistos';

  @override
  String get courseMixedIntervalsGoal =>
      'Responder pela distância, mesmo quando a direção muda a cada pergunta.';

  @override
  String get courseMixedIntervalsCard1Title => 'Conceito';

  @override
  String get courseMixedIntervalsCard1Body =>
      'O modo misto tira as rodinhas. Cada pergunta pode mudar de direção.';

  @override
  String get courseMixedIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseMixedIntervalsCard2Body =>
      'Identifica primeiro a direção e depois a distância. Não deixes a direção roubar a resposta.';

  @override
  String get courseMixedIntervalsCard3Title => 'Mini exercício';

  @override
  String get courseMixedIntervalsCard3Body =>
      'Usa primeiro intervalos fáceis e desbloqueia todos quando a precisão estiver estável.';

  @override
  String get courseMistakeReviewTitle => 'Transformar erros em treino';

  @override
  String get courseMistakeReviewGoal =>
      'Usa o resumo para atacar os teus verdadeiros pontos fracos.';

  @override
  String get courseMistakeReviewCard1Title => 'Conceito';

  @override
  String get courseMistakeReviewCard1Body =>
      'Um erro é uma pista. A confusão mostra que dois sons o teu ouvido mistura.';

  @override
  String get courseMistakeReviewCard2Title => 'Pista auditiva';

  @override
  String get courseMistakeReviewCard2Body =>
      'Usa “Rever os meus erros” enquanto o som ainda está fresco.';

  @override
  String get courseMistakeReviewCard3Title => 'Mini exercício';

  @override
  String get courseMistakeReviewCard3Body =>
      'Treina só os intervalos falhados numa sessão curta e depois volta ao modo misto.';
}
