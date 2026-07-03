// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Intervals.pro';

  @override
  String get navHome => 'Início';

  @override
  String get navExercises => 'Exercícios';

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
}
