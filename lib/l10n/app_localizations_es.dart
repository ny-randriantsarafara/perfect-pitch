// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'The Perfect Pitch';

  @override
  String get navHome => 'Inicio';

  @override
  String get navExercises => 'Ejercicios';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navGuitar => 'Guitarra';

  @override
  String get navProgress => 'Progreso';

  @override
  String streakDays(int days) {
    return '$days días';
  }

  @override
  String get streakLabel => 'Racha actual';

  @override
  String streakDaysUppercase(int days) {
    return '$days Días';
  }

  @override
  String get homeGreeting => '¡Hola!';

  @override
  String get homeSubtitle => 'Tu entrenamiento auditivo te espera.';

  @override
  String get homeTodaySession => 'SESIÓN DE HOY';

  @override
  String get homeSessionTitle => 'Quinta Justa\n& Comparación';

  @override
  String get homeSessionSubtitle =>
      'Calentamiento, nuevo intervalo y práctica.';

  @override
  String get homeStartFiveMinutes => 'Iniciar (5 min)';

  @override
  String get homeRepertoire => 'Tu repertorio';

  @override
  String get homeSeeAll => 'VER TODO';

  @override
  String get discover => 'Por descubrir';

  @override
  String get learning => 'Aprendiendo';

  @override
  String masteredAt(int percentage) {
    return 'Dominado al $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Unísono\n& Octava';

  @override
  String get repertoirePerfectFifth => 'Quinta\nJusta';

  @override
  String get practiceMode => 'MODO PRÁCTICA';

  @override
  String get guitarTitle => 'El Mástil';

  @override
  String get guitarPromptPrefix => 'Encuentra la ';

  @override
  String get guitarPromptSuffix => ' desde la nota fundamental iluminada.';

  @override
  String get guitarNextInterval => 'Siguiente intervalo';

  @override
  String get exercisesTitle => 'Ejercicios';

  @override
  String get exercisesSubtitle => 'Elige un entrenamiento de reconocimiento.';

  @override
  String get startSession => 'Iniciar sesión';

  @override
  String get settings => 'AJUSTES';

  @override
  String get intervalQuestionPrompt => '¿Qué intervalo es este?';

  @override
  String get languagePickerTooltip => 'Elegir idioma';

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
  String get courseNext => 'Siguiente';

  @override
  String get courseStartDrill => 'Empezar ejercicio';

  @override
  String get courseRecommended => 'Recomendado';

  @override
  String get courseCompleted => 'Completado';

  @override
  String get courseLearnFirst => 'Aprende primero';

  @override
  String get coursePlayDemo => 'Escuchar ejemplo';

  @override
  String courseEstimatedMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get learnTabTitle => 'Aprender';

  @override
  String get learnTabSubtitle => 'Lecciones breves antes de cada ejercicio.';

  @override
  String get courseEarTrainingBasicsTitle => 'Cómo entrenar el oído';

  @override
  String get courseEarTrainingBasicsGoal =>
      'Aprende la rutina antes del primer ejercicio.';

  @override
  String get courseEarTrainingBasicsCard1Title => 'Concepto';

  @override
  String get courseEarTrainingBasicsCard1Body =>
      'Un intervalo es la distancia entre dos notas. Aquí debes nombrar esa distancia de oído.';

  @override
  String get courseEarTrainingBasicsCard2Title => 'Pista auditiva';

  @override
  String get courseEarTrainingBasicsCard2Body =>
      'No busques el nombre de las notas. Escucha tamaño, color y estabilidad: pequeño/grande, tenso/calmado, oscuro/brillante.';

  @override
  String get courseEarTrainingBasicsCard3Title => 'Mini ejercicio';

  @override
  String get courseEarTrainingBasicsCard3Body =>
      'Reproduce el ejemplo, pausa y di si suena igual, cercano, abierto o lejano antes de responder.';

  @override
  String get courseIntervalDirectionTitle =>
      'Ascendente, descendente, armónico';

  @override
  String get courseIntervalDirectionGoal =>
      'Reconoce las tres formas de tocar un mismo intervalo.';

  @override
  String get courseIntervalDirectionCard1Title => 'Concepto';

  @override
  String get courseIntervalDirectionCard1Body =>
      'Ascendente va de grave a agudo. Descendente va de agudo a grave. Armónico toca las dos notas juntas.';

  @override
  String get courseIntervalDirectionCard2Title => 'Pista auditiva';

  @override
  String get courseIntervalDirectionCard2Body =>
      'El nombre del intervalo no cambia con la dirección. Cambia la sensación, no la distancia.';

  @override
  String get courseIntervalDirectionCard3Title => 'Mini ejercicio';

  @override
  String get courseIntervalDirectionCard3Body =>
      'Toca el mismo intervalo en las tres direcciones: identifica primero la dirección y luego el intervalo.';

  @override
  String get coursePracticeStrategyTitle => 'Practicar sin adivinar';

  @override
  String get coursePracticeStrategyGoal =>
      'Usa repeticiones y dudas de forma útil.';

  @override
  String get coursePracticeStrategyCard1Title => 'Concepto';

  @override
  String get coursePracticeStrategyCard1Body =>
      'La precisión importa más que la velocidad. Una respuesta correcta lenta construye el mapa; una suposición rápida añade ruido.';

  @override
  String get coursePracticeStrategyCard2Title => 'Pista auditiva';

  @override
  String get coursePracticeStrategyCard2Body =>
      'Repite una vez por la forma y otra por la sensación. Después responde y aprende con la comparación.';

  @override
  String get coursePracticeStrategyCard3Title => 'Mini ejercicio';

  @override
  String get coursePracticeStrategyCard3Body =>
      'Si dudas, marca la duda después de responder. Así los aciertos frágiles siguen visibles en el progreso.';

  @override
  String get courseUnisonTitle => 'Unísono';

  @override
  String get courseUnisonGoal => 'Reconocer Unísono por su sonido.';

  @override
  String get courseUnisonCard1Title => 'Qué escuchar';

  @override
  String get courseUnisonCard1Body =>
      'Concéntrate en la sensación: misma nota, ninguna distancia';

  @override
  String get courseUnisonCard2Title => 'Compáralo';

  @override
  String get courseUnisonCard2Body =>
      'Compara Unísono con Octava. Nombra primero el tamaño y luego el color.';

  @override
  String get courseUnisonCard3Title => 'Mini ejercicio';

  @override
  String get courseUnisonCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseOctaveTitle => 'Octava';

  @override
  String get courseOctaveGoal => 'Reconocer Octava por su sonido.';

  @override
  String get courseOctaveCard1Title => 'Qué escuchar';

  @override
  String get courseOctaveCard1Body =>
      'Concéntrate en la sensación: misma identidad, otra altura';

  @override
  String get courseOctaveCard2Title => 'Compáralo';

  @override
  String get courseOctaveCard2Body =>
      'Compara Octava con Unísono. Nombra primero el tamaño y luego el color.';

  @override
  String get courseOctaveCard3Title => 'Mini ejercicio';

  @override
  String get courseOctaveCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get coursePerfectFifthTitle => 'Quinta justa';

  @override
  String get coursePerfectFifthGoal => 'Reconocer Quinta justa por su sonido.';

  @override
  String get coursePerfectFifthCard1Title => 'Qué escuchar';

  @override
  String get coursePerfectFifthCard1Body =>
      'Concéntrate en la sensación: estable, abierta, potente';

  @override
  String get coursePerfectFifthCard2Title => 'Compáralo';

  @override
  String get coursePerfectFifthCard2Body =>
      'Compara Quinta justa con Cuarta justa. Nombra primero el tamaño y luego el color.';

  @override
  String get coursePerfectFifthCard3Title => 'Mini ejercicio';

  @override
  String get coursePerfectFifthCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMinorThirdTitle => 'Tercera menor';

  @override
  String get courseMinorThirdGoal => 'Reconocer Tercera menor por su sonido.';

  @override
  String get courseMinorThirdCard1Title => 'Qué escuchar';

  @override
  String get courseMinorThirdCard1Body =>
      'Concéntrate en la sensación: salto pequeño, color oscuro';

  @override
  String get courseMinorThirdCard2Title => 'Compáralo';

  @override
  String get courseMinorThirdCard2Body =>
      'Compara Tercera menor con Tercera mayor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMinorThirdCard3Title => 'Mini ejercicio';

  @override
  String get courseMinorThirdCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMajorThirdTitle => 'Tercera mayor';

  @override
  String get courseMajorThirdGoal => 'Reconocer Tercera mayor por su sonido.';

  @override
  String get courseMajorThirdCard1Title => 'Qué escuchar';

  @override
  String get courseMajorThirdCard1Body =>
      'Concéntrate en la sensación: salto pequeño, color brillante';

  @override
  String get courseMajorThirdCard2Title => 'Compáralo';

  @override
  String get courseMajorThirdCard2Body =>
      'Compara Tercera mayor con Tercera menor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMajorThirdCard3Title => 'Mini ejercicio';

  @override
  String get courseMajorThirdCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get coursePerfectFourthTitle => 'Cuarta justa';

  @override
  String get coursePerfectFourthGoal => 'Reconocer Cuarta justa por su sonido.';

  @override
  String get coursePerfectFourthCard1Title => 'Qué escuchar';

  @override
  String get coursePerfectFourthCard1Body =>
      'Concéntrate en la sensación: abierta, suspendida, en espera';

  @override
  String get coursePerfectFourthCard2Title => 'Compáralo';

  @override
  String get coursePerfectFourthCard2Body =>
      'Compara Cuarta justa con Quinta justa. Nombra primero el tamaño y luego el color.';

  @override
  String get coursePerfectFourthCard3Title => 'Mini ejercicio';

  @override
  String get coursePerfectFourthCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMinorSecondTitle => 'Segunda menor';

  @override
  String get courseMinorSecondGoal => 'Reconocer Segunda menor por su sonido.';

  @override
  String get courseMinorSecondCard1Title => 'Qué escuchar';

  @override
  String get courseMinorSecondCard1Body =>
      'Concéntrate en la sensación: muy cercana y tensa';

  @override
  String get courseMinorSecondCard2Title => 'Compáralo';

  @override
  String get courseMinorSecondCard2Body =>
      'Compara Segunda menor con Segunda mayor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMinorSecondCard3Title => 'Mini ejercicio';

  @override
  String get courseMinorSecondCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMajorSecondTitle => 'Segunda mayor';

  @override
  String get courseMajorSecondGoal => 'Reconocer Segunda mayor por su sonido.';

  @override
  String get courseMajorSecondCard1Title => 'Qué escuchar';

  @override
  String get courseMajorSecondCard1Body =>
      'Concéntrate en la sensación: pequeño movimiento natural';

  @override
  String get courseMajorSecondCard2Title => 'Compáralo';

  @override
  String get courseMajorSecondCard2Body =>
      'Compara Segunda mayor con Segunda menor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMajorSecondCard3Title => 'Mini ejercicio';

  @override
  String get courseMajorSecondCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMinorSixthTitle => 'Sexta menor';

  @override
  String get courseMinorSixthGoal => 'Reconocer Sexta menor por su sonido.';

  @override
  String get courseMinorSixthCard1Title => 'Qué escuchar';

  @override
  String get courseMinorSixthCard1Body =>
      'Concéntrate en la sensación: amplia, suave, nostálgica';

  @override
  String get courseMinorSixthCard2Title => 'Compáralo';

  @override
  String get courseMinorSixthCard2Body =>
      'Compara Sexta menor con Sexta mayor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMinorSixthCard3Title => 'Mini ejercicio';

  @override
  String get courseMinorSixthCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMajorSixthTitle => 'Sexta mayor';

  @override
  String get courseMajorSixthGoal => 'Reconocer Sexta mayor por su sonido.';

  @override
  String get courseMajorSixthCard1Title => 'Qué escuchar';

  @override
  String get courseMajorSixthCard1Body =>
      'Concéntrate en la sensación: amplia, brillante, abierta';

  @override
  String get courseMajorSixthCard2Title => 'Compáralo';

  @override
  String get courseMajorSixthCard2Body =>
      'Compara Sexta mayor con Sexta menor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMajorSixthCard3Title => 'Mini ejercicio';

  @override
  String get courseMajorSixthCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMinorSeventhTitle => 'Séptima menor';

  @override
  String get courseMinorSeventhGoal => 'Reconocer Séptima menor por su sonido.';

  @override
  String get courseMinorSeventhCard1Title => 'Qué escuchar';

  @override
  String get courseMinorSeventhCard1Body =>
      'Concéntrate en la sensación: amplia, tensa, sin resolver';

  @override
  String get courseMinorSeventhCard2Title => 'Compáralo';

  @override
  String get courseMinorSeventhCard2Body =>
      'Compara Séptima menor con Séptima mayor. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMinorSeventhCard3Title => 'Mini ejercicio';

  @override
  String get courseMinorSeventhCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseMajorSeventhTitle => 'Séptima mayor';

  @override
  String get courseMajorSeventhGoal => 'Reconocer Séptima mayor por su sonido.';

  @override
  String get courseMajorSeventhCard1Title => 'Qué escuchar';

  @override
  String get courseMajorSeventhCard1Body =>
      'Concéntrate en la sensación: casi octava, muy tensa';

  @override
  String get courseMajorSeventhCard2Title => 'Compáralo';

  @override
  String get courseMajorSeventhCard2Body =>
      'Compara Séptima mayor con Octava. Nombra primero el tamaño y luego el color.';

  @override
  String get courseMajorSeventhCard3Title => 'Mini ejercicio';

  @override
  String get courseMajorSeventhCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseTritoneTitle => 'Tritono';

  @override
  String get courseTritoneGoal => 'Reconocer Tritono por su sonido.';

  @override
  String get courseTritoneCard1Title => 'Qué escuchar';

  @override
  String get courseTritoneCard1Body =>
      'Concéntrate en la sensación: inestable, extraña, dividida';

  @override
  String get courseTritoneCard2Title => 'Compáralo';

  @override
  String get courseTritoneCard2Body =>
      'Compara Tritono con Quinta justa. Nombra primero el tamaño y luego el color.';

  @override
  String get courseTritoneCard3Title => 'Mini ejercicio';

  @override
  String get courseTritoneCard3Body =>
      'Empieza con 5 preguntas usando solo este intervalo y su confusión más cercana. Luego vuelve al ejercicio normal.';

  @override
  String get courseAscendingIntervalsTitle =>
      'Dominar los intervalos ascendentes';

  @override
  String get courseAscendingIntervalsGoal =>
      'Oír la distancia cuando la melodía sube.';

  @override
  String get courseAscendingIntervalsCard1Title => 'Concepto';

  @override
  String get courseAscendingIntervalsCard1Body =>
      'La primera nota es la fundamental. La segunda indica el tamaño del intervalo hacia arriba.';

  @override
  String get courseAscendingIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseAscendingIntervalsCard2Body =>
      'Canta la primera nota mentalmente y siente cuánto sube la segunda.';

  @override
  String get courseAscendingIntervalsCard3Title => 'Mini ejercicio';

  @override
  String get courseAscendingIntervalsCard3Body =>
      'Empieza con unísono, octava, quinta y terceras antes de añadir segundas y séptimas.';

  @override
  String get courseDescendingIntervalsTitle =>
      'Dominar los intervalos descendentes';

  @override
  String get courseDescendingIntervalsGoal =>
      'Reconocer la misma distancia cuando la melodía baja.';

  @override
  String get courseDescendingIntervalsCard1Title => 'Concepto';

  @override
  String get courseDescendingIntervalsCard1Body =>
      'La primera nota es aguda y luego cae hacia la fundamental. El nombre sigue siendo la distancia.';

  @override
  String get courseDescendingIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseDescendingIntervalsCard2Body =>
      'No respondas “más bajo” automáticamente. Guarda la primera nota y mide la caída.';

  @override
  String get courseDescendingIntervalsCard3Title => 'Mini ejercicio';

  @override
  String get courseDescendingIntervalsCard3Body =>
      'Practica el mismo intervalo ascendente y descendente hasta sentir la misma distancia.';

  @override
  String get courseHarmonicIntervalsTitle => 'Oír dos notas juntas';

  @override
  String get courseHarmonicIntervalsGoal =>
      'Identificar intervalos cuando las dos notas suenan a la vez.';

  @override
  String get courseHarmonicIntervalsCard1Title => 'Concepto';

  @override
  String get courseHarmonicIntervalsCard1Body =>
      'Las dos notas llegan juntas: se oye más el color que la melodía.';

  @override
  String get courseHarmonicIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseHarmonicIntervalsCard2Body =>
      'Escucha estabilidad y tensión: calma, abierto, brillante, oscuro, rozante, sin resolver.';

  @override
  String get courseHarmonicIntervalsCard3Title => 'Mini ejercicio';

  @override
  String get courseHarmonicIntervalsCard3Body =>
      'Tras un error, repite el intervalo correcto y nombra su color antes de seguir.';

  @override
  String get courseMixedIntervalsTitle => 'Sobrevivir a los intervalos mixtos';

  @override
  String get courseMixedIntervalsGoal =>
      'Responder por distancia aunque la dirección cambie en cada pregunta.';

  @override
  String get courseMixedIntervalsCard1Title => 'Concepto';

  @override
  String get courseMixedIntervalsCard1Body =>
      'El modo mixto quita las ruedas de apoyo. Cada pregunta puede cambiar de dirección.';

  @override
  String get courseMixedIntervalsCard2Title => 'Pista auditiva';

  @override
  String get courseMixedIntervalsCard2Body =>
      'Identifica primero la dirección y luego la distancia. No dejes que la dirección robe la respuesta.';

  @override
  String get courseMixedIntervalsCard3Title => 'Mini ejercicio';

  @override
  String get courseMixedIntervalsCard3Body =>
      'Usa intervalos fáciles al principio y desbloquea todos cuando la precisión sea estable.';

  @override
  String get courseMistakeReviewTitle => 'Convertir errores en entrenamiento';

  @override
  String get courseMistakeReviewGoal =>
      'Usar el resumen para atacar tus puntos débiles reales.';

  @override
  String get courseMistakeReviewCard1Title => 'Concepto';

  @override
  String get courseMistakeReviewCard1Body =>
      'Un error es una pista. La confusión muestra qué dos sonidos mezcla tu oído.';

  @override
  String get courseMistakeReviewCard2Title => 'Pista auditiva';

  @override
  String get courseMistakeReviewCard2Body =>
      'Usa “Revisar mis errores” mientras el sonido sigue fresco.';

  @override
  String get courseMistakeReviewCard3Title => 'Mini ejercicio';

  @override
  String get courseMistakeReviewCard3Body =>
      'Entrena solo los intervalos fallados en una sesión corta y vuelve al modo mixto.';
}
