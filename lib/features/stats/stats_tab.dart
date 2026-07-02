import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({required this.progress, required this.mode, super.key});

  final ProgressSnapshot progress;
  final LayoutMode mode;

  bool get _isDesktop {
    return mode == LayoutMode.desktop;
  }

  List<IntervalProgress> get _detail {
    final attempted = progress.attemptedIntervals;

    if (attempted.isNotEmpty) {
      return attempted;
    }

    return MusicInterval.upToStage(3)
        .map(IntervalProgress.empty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, _isDesktop ? 32 : 16, 24, _isDesktop ? 48 : 128),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progrès',
            style: TextStyle(
              fontSize: _isDesktop ? 48 : 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Analyse de tes performances',
            style: TextStyle(
              fontSize: _isDesktop ? 18 : 14,
              fontWeight: FontWeight.w500,
              color: AppPalette.violet200.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: _isDesktop ? 40 : 28),
          _SummaryRow(progress: progress, isDesktop: _isDesktop),
          SizedBox(height: _isDesktop ? 40 : 28),
          Text(
            'Détail par intervalle',
            style: TextStyle(
              fontSize: _isDesktop ? 24 : 18,
              fontWeight: FontWeight.w700,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 16),
          _DetailGrid(intervals: _detail, isDesktop: _isDesktop),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.progress, required this.isDesktop});

  final ProgressSnapshot progress;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _SummaryCard(
        icon: Icons.local_fire_department_rounded,
        accent: AppPalette.orange400,
        value: '${progress.streakDays}',
        label: 'Jours',
        isDesktop: isDesktop,
      ),
      _SummaryCard(
        icon: Icons.track_changes_rounded,
        accent: AppPalette.violet400,
        value: '${progress.attemptedIntervalCount}',
        label: 'Intervalles',
        isDesktop: isDesktop,
      ),
      _SummaryCard(
        icon: Icons.workspace_premium_rounded,
        accent: AppPalette.green400,
        value: '${progress.masteredIntervalCount}',
        label: 'Niveaux',
        isDesktop: isDesktop,
      ),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cards.length; i += 1) ...[
            Expanded(child: cards[i]),
            if (i < cards.length - 1) SizedBox(width: isDesktop ? 24 : 12),
          ],
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.accent,
    required this.value,
    required this.label,
    required this.isDesktop,
  });

  final IconData icon;
  final Color accent;
  final String value;
  final String label;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 28 : 20),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.02),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppPalette.whiteAlpha(0.05)),
      ),
      child: Column(
        children: [
          Container(
            height: 3,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0),
                  accent,
                  accent.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Icon(icon, size: isDesktop ? 40 : 28, color: accent),
          SizedBox(height: isDesktop ? 16 : 12),
          Text(
            value,
            style: TextStyle(
              fontSize: isDesktop ? 44 : 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: isDesktop ? 13 : 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: AppPalette.whiteAlpha(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailGrid extends StatelessWidget {
  const _DetailGrid({required this.intervals, required this.isDesktop});

  final List<IntervalProgress> intervals;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) {
      return Column(
        children: [
          for (final interval in intervals) ...[
            _IntervalCard(progress: interval, isDesktop: false),
            if (interval != intervals.last) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        for (final interval in intervals)
          _DesktopCardSlot(
            child: _IntervalCard(progress: interval, isDesktop: true),
          ),
      ],
    );
  }
}

class _DesktopCardSlot extends StatelessWidget {
  const _DesktopCardSlot({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 24) / 2;

        return SizedBox(width: width, child: child);
      },
    );
  }
}

class _IntervalCard extends StatelessWidget {
  const _IntervalCard({required this.progress, required this.isDesktop});

  final IntervalProgress progress;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 28 : 24),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.02),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppPalette.whiteAlpha(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  progress.interval.labelFr,
                  style: TextStyle(
                    fontSize: isDesktop ? 22 : 18,
                    fontWeight: FontWeight.w700,
                    color: AppPalette.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppPalette.whiteAlpha(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Moy. ${progress.averagePercentage}%',
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 12,
                    fontWeight: FontWeight.w700,
                    color: AppPalette.whiteAlpha(0.8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 24 : 20),
          for (final mode in TrainingMode.values) ...[
            _ModeBar(
              label: mode.labelFr,
              value: progress.scoreFor(mode).percentage,
              isDesktop: isDesktop,
            ),
            if (mode != TrainingMode.values.last) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _ModeBar extends StatelessWidget {
  const _ModeBar({
    required this.label,
    required this.value,
    required this.isDesktop,
  });

  final String label;
  final int value;
  final bool isDesktop;

  Color get _color {
    if (value >= 90) {
      return AppPalette.green400;
    }

    if (value >= 75) {
      return AppPalette.violet400;
    }

    if (value >= 50) {
      return AppPalette.fuchsia400;
    }

    return AppPalette.zinc600;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: isDesktop ? 110 : 88,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: isDesktop ? 12 : 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: AppPalette.whiteAlpha(0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                Container(height: 8, color: AppPalette.whiteAlpha(0.05)),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: value / 100),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  builder: (context, factor, _) {
                    return FractionallySizedBox(
                      widthFactor: factor.clamp(0.0, 1.0),
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: isDesktop ? 32 : 26,
          child: Text(
            '$value',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isDesktop ? 14 : 12,
              fontWeight: FontWeight.w700,
              color: AppPalette.whiteAlpha(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
