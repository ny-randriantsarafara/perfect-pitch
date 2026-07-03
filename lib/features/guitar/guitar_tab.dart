import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/features/guitar/guitar_controller.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';
import 'package:perfect_pitch/ui/pressable.dart';

class GuitarTab extends StatelessWidget {
  const GuitarTab({required this.controller, required this.mode, super.key});

  final GuitarController controller;
  final LayoutMode mode;

  bool get _isDesktop {
    return mode == LayoutMode.desktop;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, _isDesktop ? 32 : 16, 24, _isDesktop ? 48 : 128),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(interval: controller.interval, isDesktop: _isDesktop),
              SizedBox(height: _isDesktop ? 40 : 24),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _Fretboard(controller: controller, isDesktop: _isDesktop),
                  ),
                ),
              ),
              SizedBox(height: _isDesktop ? 32 : 20),
              _NextAction(controller: controller, isDesktop: _isDesktop),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.interval, required this.isDesktop});

  final MusicInterval interval;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppPalette.fuchsia500.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppPalette.fuchsia500.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            l10n.practiceMode,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppPalette.fuchsia400,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.guitarTitle,
          style: TextStyle(
            fontSize: isDesktop ? 48 : 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            color: AppPalette.white,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: isDesktop ? 18 : 14,
              height: 1.4,
              color: AppPalette.violet200.withValues(alpha: 0.6),
            ),
            children: [
              TextSpan(text: l10n.guitarPromptPrefix),
              TextSpan(
                text: interval.labelFr,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppPalette.fuchsia400,
                ),
              ),
              TextSpan(text: l10n.guitarPromptSuffix),
            ],
          ),
        ),
      ],
    );
  }
}

class _Fretboard extends StatelessWidget {
  const _Fretboard({required this.controller, required this.isDesktop});

  final GuitarController controller;
  final bool isDesktop;

  static const List<int> _inlayFrets = [3, 5, 7, 9, 12, 15];

  int get _fretCount {
    return isDesktop ? 15 : 9;
  }

  @override
  Widget build(BuildContext context) {
    final boardWidth = isDesktop ? 860.0 : 600.0;
    final boardHeight = isDesktop ? 360.0 : 280.0;
    final nutWidth = isDesktop ? 24.0 : 16.0;
    final revealed = controller.showResult
        ? controller.revealedTarget(fretCount: _fretCount)
        : null;

    return Container(
      width: boardWidth,
      height: boardHeight,
      decoration: BoxDecoration(
        color: AppPalette.frame.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppPalette.whiteAlpha(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppPalette.violet600.withValues(alpha: 0.1),
            blurRadius: 80,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          _FretsLayer(
            fretCount: _fretCount,
            nutWidth: nutWidth,
            inlayFrets: _inlayFrets,
            isDesktop: isDesktop,
          ),
          _StringsLayer(
            stringCount: GuitarController.openStringMidi.length,
          ),
          _DotsLayer(
            controller: controller,
            fretCount: _fretCount,
            nutWidth: nutWidth,
            isDesktop: isDesktop,
            revealed: revealed,
          ),
        ],
      ),
    );
  }
}

class _FretsLayer extends StatelessWidget {
  const _FretsLayer({
    required this.fretCount,
    required this.nutWidth,
    required this.inlayFrets,
    required this.isDesktop,
  });

  final int fretCount;
  final double nutWidth;
  final List<int> inlayFrets;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: nutWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF27272A), Color(0xFF18181B)],
            ),
          ),
        ),
        for (var fret = 0; fret < fretCount; fret += 1)
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppPalette.whiteAlpha(0.1)),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                  ],
                ),
              ),
              child: Center(
                child: inlayFrets.contains(fret + 1)
                    ? Container(
                        width: isDesktop ? 20 : 12,
                        height: isDesktop ? 20 : 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppPalette.whiteAlpha(0.1),
                        ),
                      )
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}

class _StringsLayer extends StatelessWidget {
  const _StringsLayer({required this.stringCount});

  final int stringCount;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: [
          for (var i = 0; i < stringCount; i += 1)
            Expanded(
              child: Center(
                child: Container(
                  height: 1 + i * 0.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppPalette.whiteAlpha(0.1),
                        AppPalette.whiteAlpha(0.3),
                        AppPalette.whiteAlpha(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DotsLayer extends StatelessWidget {
  const _DotsLayer({
    required this.controller,
    required this.fretCount,
    required this.nutWidth,
    required this.isDesktop,
    required this.revealed,
  });

  final GuitarController controller;
  final int fretCount;
  final double nutWidth;
  final bool isDesktop;
  final FretPosition? revealed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var string = 0;
            string < GuitarController.openStringMidi.length;
            string += 1)
          Expanded(
            child: Row(
              children: [
                SizedBox(width: nutWidth),
                for (var fret = 0; fret < fretCount; fret += 1)
                  Expanded(
                    child: _FretCell(
                      controller: controller,
                      position: FretPosition(string: string, fret: fret),
                      isDesktop: isDesktop,
                      revealed: revealed,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _FretCell extends StatelessWidget {
  const _FretCell({
    required this.controller,
    required this.position,
    required this.isDesktop,
    required this.revealed,
  });

  final GuitarController controller;
  final FretPosition position;
  final bool isDesktop;
  final FretPosition? revealed;

  static const Map<MusicInterval, String> _degreeLabels = {
    MusicInterval.majorThird: '3',
    MusicInterval.minorThird: '3',
    MusicInterval.perfectFourth: '4',
    MusicInterval.perfectFifth: '5',
    MusicInterval.octave: '8',
  };

  @override
  Widget build(BuildContext context) {
    final size = isDesktop ? 40.0 : 28.0;
    final isRoot = controller.isRoot(position);
    final isSelected = controller.selected == position;
    final showResult = controller.showResult;
    final isCorrectTarget = controller.isCorrectTarget(position);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.selectPosition(position),
      child: Center(
        child: _buildDot(
          size: size,
          isRoot: isRoot,
          isSelected: isSelected,
          showResult: showResult,
          isCorrectTarget: isCorrectTarget,
        ),
      ),
    );
  }

  Widget _buildDot({
    required double size,
    required bool isRoot,
    required bool isSelected,
    required bool showResult,
    required bool isCorrectTarget,
  }) {
    if (isRoot) {
      return _dot(
        size: size,
        color: AppPalette.white,
        glow: AppPalette.whiteAlpha(0.8),
        label: '1',
      );
    }

    if (showResult && isCorrectTarget) {
      return _dot(
        size: size,
        color: AppPalette.green400,
        glow: AppPalette.green400.withValues(alpha: 0.8),
        label: _degreeLabels[controller.interval],
        reveal: true,
      );
    }

    if (showResult && isSelected) {
      return _dot(
        size: size,
        color: AppPalette.red500.withValues(alpha: 0.6),
        glow: null,
      );
    }

    if (isSelected) {
      return _dot(
        size: size,
        color: AppPalette.fuchsia500,
        glow: AppPalette.fuchsia500.withValues(alpha: 0.6),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _dot({
    required double size,
    required Color color,
    required Color? glow,
    String? label,
    bool reveal = false,
  }) {
    final dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: glow == null
            ? null
            : [BoxShadow(color: glow, blurRadius: 20)],
      ),
      alignment: Alignment.center,
      child: label == null
          ? null
          : Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
    );

    if (!reveal) {
      return dot;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.4, end: 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: dot,
    );
  }
}

class _NextAction extends StatelessWidget {
  const _NextAction({required this.controller, required this.isDesktop});

  final GuitarController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: 64,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.4),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: controller.showResult
              ? Pressable(
                  onTap: controller.nextChallenge,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 64 : 32,
                      vertical: 16,
                    ),
                    width: isDesktop ? null : double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppPalette.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppPalette.whiteAlpha(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      l10n.guitarNextInterval,
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        fontWeight: FontWeight.w700,
                        color: AppPalette.frame,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
