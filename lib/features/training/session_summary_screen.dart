import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';

class SessionSummaryScreen extends StatelessWidget {
  const SessionSummaryScreen({required this.controller, super.key});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stats = controller.sessionStats;
    final successRate = (stats.successRate * 100).round();
    final strongestNote = stats.strongestNote?.solfegeName ?? 'Aucune';
    final weakestNote = stats.weakestNote?.solfegeName ?? 'Aucune';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Bilan de séance', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(
              'La précision compte plus que la vitesse. Reviens surtout sur les confusions.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    _MetricRow(
                      label: 'Bonnes réponses',
                      value: '${stats.correctAnswers}/${stats.totalQuestions}',
                    ),
                    _MetricRow(label: 'Réussite', value: '$successRate %'),
                    _MetricRow(
                      label: 'Temps moyen',
                      value:
                          '${(stats.averageResponseTime.inMilliseconds / 1000).toStringAsFixed(1)} s',
                    ),
                    _MetricRow(
                      label: 'Réécoutes moyennes',
                      value: stats.averageReplayCount.toStringAsFixed(1),
                    ),
                    _MetricRow(
                      label: 'Meilleure série',
                      value: '${stats.bestStreak}',
                    ),
                    _MetricRow(label: 'Note forte', value: strongestNote),
                    _MetricRow(label: 'Note à revoir', value: weakestNote),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: controller.showHome,
              child: const Text('Retour à l’accueil'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
