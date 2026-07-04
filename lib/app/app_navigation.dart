import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/glass_panel.dart';
import 'package:perfect_pitch/ui/gradient_text.dart';
import 'package:perfect_pitch/ui/pressable.dart';

class _NavItem {
  const _NavItem({required this.tab, required this.icon});

  final AppTab tab;
  final IconData icon;

  String label(AppLocalizations l10n) {
    switch (tab) {
      case AppTab.home:
        return l10n.navHome;
      case AppTab.practice:
        return l10n.navExercises;
      case AppTab.guitar:
        return l10n.navGuitar;
      case AppTab.stats:
        return l10n.navProgress;
    }
  }
}

const List<_NavItem> _navItems = [
  _NavItem(tab: AppTab.home, icon: Icons.home_rounded),
  _NavItem(tab: AppTab.practice, icon: Icons.headphones_rounded),
  _NavItem(tab: AppTab.guitar, icon: Icons.music_note_rounded),
  _NavItem(tab: AppTab.stats, icon: Icons.auto_awesome_rounded),
];

/// Floating pill navigation shown at the bottom of the mobile phone frame.
class MobileNavigationBar extends StatelessWidget {
  const MobileNavigationBar({
    required this.currentTab,
    required this.onSelect,
    super.key,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onSelect;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: GlassPanel(
            padding: const EdgeInsets.all(8),
            borderRadius: 999,
            fillAlpha: 0.05,
            borderAlpha: 0.1,
            blur: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final item in _navItems)
                  _MobileNavButton(
                    item: item,
                    isActive: item.tab == currentTab,
                    onTap: () => onSelect(item.tab),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavButton extends StatelessWidget {
  const _MobileNavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Pressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        width: 62,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: isActive
              ? const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0x667C3AED), Color(0x66C026D3)],
                )
              : null,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppPalette.violet500.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 20,
              color: isActive ? AppPalette.white : AppPalette.whiteAlpha(0.4),
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Text(
                item.label(l10n).toUpperCase(),
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: AppPalette.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Persistent side navigation used on the desktop layout.
class DesktopNavigationRail extends StatelessWidget {
  const DesktopNavigationRail({
    required this.currentTab,
    required this.onSelect,
    required this.streakDays,
    super.key,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab> onSelect;
  final int streakDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.02),
        border: Border(right: BorderSide(color: AppPalette.whiteAlpha(0.05))),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientText(
                    AppLocalizations.of(context).appTitle,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          for (final item in _navItems) ...[
            _DesktopNavButton(
              item: item,
              isActive: item.tab == currentTab,
              onTap: () => onSelect(item.tab),
            ),
            const SizedBox(height: 8),
          ],
          const Spacer(),
          _StreakCard(streakDays: streakDays),
        ],
      ),
    );
  }
}

class _DesktopNavButton extends StatelessWidget {
  const _DesktopNavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Pressable(
      onTap: onTap,
      pressedScale: 0.98,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isActive ? AppPalette.whiteAlpha(0.1) : null,
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0x337C3AED), Color(0x33C026D3)],
                )
              : null,
          border: isActive
              ? Border.all(color: AppPalette.whiteAlpha(0.1))
              : null,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 22,
              color: isActive
                  ? AppPalette.fuchsia400
                  : AppPalette.whiteAlpha(0.4),
            ),
            const SizedBox(width: 16),
            Text(
              item.label(l10n).toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: isActive ? AppPalette.white : AppPalette.whiteAlpha(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streakDays});

  final int streakDays;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x337C3AED), Color(0x33C026D3)],
        ),
        border: Border.all(color: AppPalette.whiteAlpha(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.streakLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                size: 14,
                color: AppPalette.fuchsia400,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  l10n.streakDaysUppercase(streakDays),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: AppPalette.fuchsia400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
