import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({required this.controller, super.key});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final note = controller.learnNote;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: controller.showHome,
                child: const Text('Retour'),
              ),
            ),
            const SizedBox(height: 12),
            Text('Mode Apprendre', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(
              'Écoute librement, puis essaie de chanter la note avant de la rejouer.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    Text(
                      note.solfegeName,
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 76,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note.internationalName,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Octave ${controller.settings.enabledOctaves.first}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 28),
                    FilledButton(
                      onPressed: controller.playLearnNote,
                      child: Text('Écouter ${note.solfegeName}'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: controller.nextLearnNote,
                      child: const Text('Note suivante'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
