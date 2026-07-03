// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Intervals.pro';

  @override
  String get navHome => 'Inicio';

  @override
  String get navExercises => 'Ejercicios';

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
}
