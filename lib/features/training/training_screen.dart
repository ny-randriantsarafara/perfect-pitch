import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/core/music/music_note.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({required this.controller, super.key});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final outcome = controller.lastOutcome;

    if (outcome != null) {
      return _ResultView(controller: controller);
    }

    return _QuestionView(controller: controller);
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({required this.controller});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Question ${controller.questionNumber}/${controller.totalQuestions}',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Quelle note entends-tu ?',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.graphic_eq,
                      size: 88,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: controller.playCurrentQuestion,
                      child: const Text('Réécouter'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final note in MusicNote.naturalNotes)
                  SizedBox(
                    width: 104,
                    height: 64,
                    child: FilledButton.tonal(
                      onPressed: () => controller.answer(note),
                      child: Text(note.solfegeName),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({required this.controller});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outcome = controller.lastOutcome;

    if (outcome == null) {
      return _QuestionView(controller: controller);
    }

    final title = outcome.isCorrect ? 'Réponse correcte' : 'Réponse incorrecte';
    final titleColor = outcome.isCorrect
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: titleColor,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bonne note : ${outcome.note.solfegeName}'),
                    const SizedBox(height: 8),
                    Text('Votre choix : ${outcome.selectedNote.solfegeName}'),
                    const SizedBox(height: 8),
                    Text(
                      'Temps : ${(outcome.responseTime.inMilliseconds / 1000).toStringAsFixed(1)} s',
                    ),
                    const SizedBox(height: 8),
                    Text('Réécoutes : ${outcome.replayCount}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: controller.replayCorrectNote,
              child: const Text('Réécouter la bonne note'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: controller.replaySelectedNote,
              child: const Text('Réécouter votre choix'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: controller.compareLastAnswer,
              child: const Text('Comparer'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: controller.nextQuestion,
              child: const Text('Question suivante'),
            ),
          ],
        ),
      ),
    );
  }
}
