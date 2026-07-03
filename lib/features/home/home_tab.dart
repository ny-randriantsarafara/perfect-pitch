import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
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
          _Header(
            mode: mode,
            streakDays: controller.progress.streakDays,
            currentLocale: controller.locale,
            onLocaleSelected: controller.changeLocale,
          ),
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
  const _Header({
    required this.mode,
    required this.streakDays,
    required this.currentLocale,
    required this.onLocaleSelected,
  });

  final LayoutMode mode;
  final int streakDays;
  final Locale? currentLocale;
  final ValueChanged<Locale?> onLocaleSelected;

  @override
  Widget build(BuildContext context) {
    final isDesktop = mode == LayoutMode.desktop;
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                l10n.homeGreeting,
                style: TextStyle(
                  fontSize: isDesktop ? 48 : 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.homeSubtitle,
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.violet300.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        _LanguagePicker(
          currentLocale: currentLocale,
          onSelected: onLocaleSelected,
          tooltip: l10n.languagePickerTooltip,
        ),
        if (!isDesktop) ...[
          const SizedBox(width: 8),
          _StreakPill(streakDays: streakDays),
        ],
      ],
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({
    required this.currentLocale,
    required this.onSelected,
    required this.tooltip,
  });

  final Locale? currentLocale;
  final ValueChanged<Locale?> onSelected;
  final String tooltip;

  static const List<_LanguageOption> _options = [
    _LanguageOption(locale: Locale('en'), label: 'English'),
    _LanguageOption(locale: Locale('fr'), label: 'Français'),
    _LanguageOption(locale: Locale('es'), label: 'Español'),
    _LanguageOption(locale: Locale('de'), label: 'Deutsch'),
    _LanguageOption(locale: Locale('it'), label: 'Italiano'),
    _LanguageOption(locale: Locale('pt'), label: 'Português'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: PopupMenuButton<Locale>(
        key: const ValueKey('language-picker'),
        tooltip: tooltip,
        icon: const Icon(
          Icons.language_rounded,
          size: 20,
          color: AppPalette.white,
        ),
        color: AppPalette.frame,
        onSelected: onSelected,
        padding: EdgeInsets.zero,
        itemBuilder: (context) => [
          for (final option in _options)
            PopupMenuItem<Locale>(
              value: option.locale,
              child: Row(
                children: [
                  if (currentLocale?.languageCode == option.locale.languageCode)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: AppPalette.fuchsia400,
                      ),
                    ),
                  Text(
                    option.label,
                    style: const TextStyle(color: AppPalette.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({required this.locale, required this.label});

  final Locale locale;
  final String label;
}

class _StreakPill extends StatelessWidget {
  const _StreakPill({required this.streakDays});

  final int streakDays;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

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
            l10n.streakDays(streakDays),
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
    final l10n = AppLocalizations.of(context);
    final recommendations = _exerciseRecommendations(
      controller.homeRecommendations,
    );

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
                l10n.homeRepertoire,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.homeSeeAll,
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
              Expanded(
                child: _ExerciseRecommendationCard(
                  recommendation: recommendations[0],
                  onTap: () =>
                      controller.openExerciseSetup(recommendations[0].type),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ExerciseRecommendationCard(
                  recommendation: recommendations[1],
                  onTap: () =>
                      controller.openExerciseSetup(recommendations[1].type),
                ),
              ),
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
    final recommendations = _exerciseRecommendations(
      controller.homeRecommendations,
    );

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
                Expanded(
                  child: _ExerciseRecommendationCard(
                    recommendation: recommendations[0],
                    onTap: () =>
                        controller.openExerciseSetup(recommendations[0].type),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _ExerciseRecommendationCard(
                    recommendation: recommendations[1],
                    onTap: () =>
                        controller.openExerciseSetup(recommendations[1].type),
                  ),
                ),
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
    final l10n = AppLocalizations.of(context);

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
                  _sessionBadge(l10n),
                  SizedBox(height: isDesktop ? 32 : 24),
                  Text(
                    l10n.homeSessionTitle,
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
                      l10n.homeSessionSubtitle,
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : 14,
                        color: AppPalette.violet200.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _startButton(isDesktop: isDesktop, label: l10n.homeStartFiveMinutes),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sessionBadge(AppLocalizations l10n) {
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
            l10n.homeTodaySession,
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

  Widget _startButton({required bool isDesktop, required String label}) {
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
              label,
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

class _ExerciseRecommendation {
  const _ExerciseRecommendation({required this.type, required this.key});

  final ExerciseType type;
  final Key key;
}

List<_ExerciseRecommendation> _exerciseRecommendations(
  List<ExerciseType> types,
) {
  return [
    for (var index = 0; index < types.length; index += 1)
      _ExerciseRecommendation(
        type: types[index],
        key: ValueKey('home-exercise-recommendation-$index'),
      ),
  ];
}

class _ExerciseRecommendationCard extends StatelessWidget {
  const _ExerciseRecommendationCard({
    required this.recommendation,
    required this.onTap,
  });

  final _ExerciseRecommendation recommendation;
  final VoidCallback onTap;

  static const List<Color> _accentPalette = [
    AppPalette.green400,
    AppPalette.fuchsia400,
  ];

  static const List<IconData> _iconPalette = [
    Icons.layers_rounded,
    Icons.album_rounded,
  ];

  int get _paletteIndex {
    return ExerciseType.values.indexOf(recommendation.type) %
        _accentPalette.length;
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentPalette[_paletteIndex];
    final icon = _iconPalette[_paletteIndex];

    return Pressable(
      key: recommendation.key,
      onTap: onTap,
      pressedScale: 0.98,
      child: Container(
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
            Icon(icon, size: 32, color: accent),
            const SizedBox(height: 16),
            Text(
              recommendation.type.labelFr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.1,
                color: AppPalette.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recommendation.type.descriptionFr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: accent.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
