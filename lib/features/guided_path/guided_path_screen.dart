import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';

class GuidedPathScreen extends StatelessWidget {
  const GuidedPathScreen({required this.controller, super.key});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextButton(
              onPressed: controller.showHome,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text('Retour'),
              ),
            ),
            const SizedBox(height: 18),
            Text('Parcours guidé', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(
              'Une séance courte pour construire la mémoire sonore étape par étape.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Étape 1', style: theme.textTheme.labelLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Reconnaître uniquement Do',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Durée conseillée : cinq minutes, sans pression de vitesse.',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: controller.startGuidedStep,
                      child: const Text('Commencer la séance'),
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
