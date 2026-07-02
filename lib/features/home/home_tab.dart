import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/ui/gradient_text.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';
import 'package:perfect_pitch/ui/pressable.dart';
import 'package:perfect_pitch/ui/pulsing_dot.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({required this.controller, required this.mode, super.key});

  final AppController controller;
  final LayoutMode mode;

  bool get _isDesktop {
    return mode == LayoutMode.desktop;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, _isDesktop ? 32 : 16, 24, _isDesktop ? 48 : 128),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(mode: mode, streakDays: controller.progress.streakDays),
          SizedBox(height: _isDesktop ? 40 : 24),
          if (_isDesktop)
            _DesktopBody(controller: controller)
          else
            _MobileBody(controller: controller),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.mode, required this.streakDays});

  final LayoutMode mode;
  final int streakDays;

  @override
  Widget build(BuildContext context) {
    final isDesktop = mode == LayoutMode.desktop;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'Bonjour !',
                style: TextStyle(
                  fontSize: isDesktop ? 48 : 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "L'oreille absolue t'attend.",
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.violet300.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        if (!isDesktop) _StreakPill(streakDays: streakDays),
      ],
    );
  }
}

class _StreakPill extends StatelessWidget {
  const _StreakPill({required this.streakDays});

  final int streakDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.05),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.whiteAlpha(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            size: 16,
            color: AppPalette.fuchsia400,
          ),
          const SizedBox(width: 6),
          Text(
            '$streakDays jours',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppPalette.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final entries = _repertoireEntries(controller.progress);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SessionCard(onStart: controller.startPractice, mode: LayoutMode.mobile),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Ton répertoire',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'VOIR TOUT',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: AppPalette.violet400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _RepertoireCard(entry: entries[0])),
              const SizedBox(width: 16),
              Expanded(child: _RepertoireCard(entry: entries[1])),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final entries = _repertoireEntries(controller.progress);

    return SizedBox(
      height: 520,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: _SessionCard(
              onStart: controller.startPractice,
              mode: LayoutMode.desktop,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _RepertoireCard(entry: entries[0])),
                const SizedBox(height: 24),
                Expanded(child: _RepertoireCard(entry: entries[1])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.onStart, required this.mode});

  final VoidCallback onStart;
  final LayoutMode mode;

  @override
  Widget build(BuildContext context) {
    final isDesktop = mode == LayoutMode.desktop;

    return Pressable(
      onTap: onStart,
      pressedScale: 0.98,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: AppPalette.violet600.withValues(alpha: 0.35),
              blurRadius: 40,
              spreadRadius: -8,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(isDesktop ? 48 : 32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppPalette.cardTop, AppPalette.cardBottom],
            ),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppPalette.whiteAlpha(0.1)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -30,
                child: Icon(
                  Icons.album_rounded,
                  size: isDesktop ? 220 : 120,
                  color: AppPalette.whiteAlpha(0.05),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sessionBadge(),
                  SizedBox(height: isDesktop ? 32 : 24),
                  Text(
                    'Quinte Juste\n& Comparaison',
                    style: TextStyle(
                      fontSize: isDesktop ? 36 : 24,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: AppPalette.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Text(
                      'Échauffement, nouvel intervalle et mise en pratique.',
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : 14,
                        color: AppPalette.violet200.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _startButton(isDesktop: isDesktop),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sessionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.whiteAlpha(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PulsingDot(color: AppPalette.fuchsia400, size: 8),
          const SizedBox(width: 8),
          Text(
            'SESSION DU JOUR',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppPalette.whiteAlpha(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _startButton({required bool isDesktop}) {
    final button = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: AppPalette.whiteAlpha(0.2),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.play_arrow_rounded, size: 22, color: AppPalette.violet900),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'Démarrer (5 min)',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: isDesktop ? 18 : 16,
                fontWeight: FontWeight.w700,
                color: AppPalette.violet900,
              ),
            ),
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Align(
        alignment: Alignment.centerLeft,
        child: IntrinsicWidth(child: button),
      );
    }

    return SizedBox(width: double.infinity, child: button);
  }
}

class _RepertoireEntry {
  const _RepertoireEntry({
    required this.title,
    required this.status,
    required this.color,
    required this.icon,
  });

  final String title;
  final String status;
  final Color color;
  final IconData icon;
}

List<_RepertoireEntry> _repertoireEntries(ProgressSnapshot progress) {
  final attempted = progress.attemptedIntervals
    ..sort((a, b) => b.totalAttempts.compareTo(a.totalAttempts));
  final palette = [AppPalette.green400, AppPalette.fuchsia400];
  final icons = [Icons.layers_rounded, Icons.album_rounded];
  final defaults = [
    const _RepertoireEntry(
      title: 'Unisson\n& Octave',
      status: 'À découvrir',
      color: AppPalette.green400,
      icon: Icons.layers_rounded,
    ),
    const _RepertoireEntry(
      title: 'Quinte\nJuste',
      status: 'À découvrir',
      color: AppPalette.fuchsia400,
      icon: Icons.album_rounded,
    ),
  ];

  return List.generate(2, (index) {
    if (index >= attempted.length) {
      return defaults[index];
    }

    final progressEntry = attempted[index];
    final mastered = progressEntry.isMastered;

    return _RepertoireEntry(
      title: progressEntry.interval.labelFr,
      status: mastered
          ? 'Maîtrisé à ${progressEntry.averagePercentage}%'
          : 'En apprentissage',
      color: palette[index % palette.length],
      icon: icons[index % icons.length],
    );
  });
}

class _RepertoireCard extends StatelessWidget {
  const _RepertoireCard({required this.entry});

  final _RepertoireEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppPalette.whiteAlpha(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(entry.icon, size: 32, color: entry.color),
          const SizedBox(height: 16),
          Text(
            entry.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.1,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: entry.color.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
