import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.controller, super.key});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B0907), Color(0xFF1B120C), Color(0xFF10201B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text('Perfect Pitch', style: theme.textTheme.displayLarge),
                const SizedBox(height: 12),
                Text(
                  'Un atelier d’oreille musicale pour mémoriser les notes, une couleur sonore à la fois.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.74),
                  ),
                ),
                const SizedBox(height: 32),
                const _SoundPlate(),
                const SizedBox(height: 28),
                _ModeCard(
                  actionKey: const Key('learn-mode-action'),
                  title: 'Apprendre',
                  eyebrow: 'Sans score',
                  description: 'Écoute chaque note, chante-la, puis rejoue-la.',
                  onPressed: controller.showLearn,
                ),
                const SizedBox(height: 14),
                _ModeCard(
                  actionKey: const Key('training-mode-action'),
                  title: 'Entraînement',
                  eyebrow: 'Session libre',
                  description:
                      'Réponds avec de gros boutons et compare tes erreurs.',
                  onPressed: controller.startTraining,
                ),
                const SizedBox(height: 14),
                _ModeCard(
                  actionKey: const Key('guided-path-action'),
                  title: 'Parcours',
                  eyebrow: '5 minutes',
                  description:
                      'Commence par Do, puis ajoute Sol, Mi et les autres notes.',
                  onPressed: controller.showGuidedPath,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoundPlate extends StatelessWidget {
  const _SoundPlate();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final bars = [44.0, 76.0, 54.0, 116.0, 68.0, 94.0, 48.0];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final height in bars)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.22 + height / 460),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.actionKey,
    required this.title,
    required this.eyebrow,
    required this.description,
    required this.onPressed,
  });

  final Key actionKey;
  final String title;
  final String eyebrow;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              key: actionKey,
              onPressed: onPressed,
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
