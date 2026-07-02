import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';
import 'package:perfect_pitch/ui/pressable.dart';

class PracticeTab extends StatelessWidget {
  const PracticeTab({required this.controller, required this.mode, super.key});

  final PracticeController controller;
  final LayoutMode mode;

  bool get _isDesktop {
    return mode == LayoutMode.desktop;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final question = controller.question;

        if (question == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(24, 8, 24, _isDesktop ? 48 : 128),
          child: Column(
            children: [
              _TopBar(
                questionNumber: controller.questionNumber,
                questionCount: controller.questionCount,
                onSkip: controller.showResult ? null : controller.skip,
                isDesktop: _isDesktop,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _isDesktop
                    ? _DesktopBody(controller: controller)
                    : _MobileBody(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.questionNumber,
    required this.questionCount,
    required this.onSkip,
    required this.isDesktop,
  });

  final int questionNumber;
  final int questionCount;
  final VoidCallback? onSkip;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final fraction = questionCount == 0 ? 0.0 : questionNumber / questionCount;

    return Row(
      children: [
        Expanded(
          child: Text(
            'QUESTION $questionNumber/$questionCount',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: isDesktop ? 14 : 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppPalette.whiteAlpha(0.4),
            ),
          ),
        ),
        _ProgressPills(fraction: fraction, isDesktop: isDesktop),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Pressable(
              onTap: onSkip,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isDesktop) ...[
                    Text(
                      'PASSER',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppPalette.whiteAlpha(0.4),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Icon(
                    Icons.skip_next_rounded,
                    size: 22,
                    color: AppPalette.whiteAlpha(0.4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressPills extends StatelessWidget {
  const _ProgressPills({required this.fraction, required this.isDesktop});

  final double fraction;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final filled = (fraction * 3).ceil();
    final widths = isDesktop
        ? [96.0, 32.0, 32.0]
        : [48.0, 16.0, 16.0];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i += 1) ...[
          Container(
            width: widths[i],
            height: isDesktop ? 8 : 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: i < filled
                  ? const LinearGradient(
                      colors: [AppPalette.violet500, AppPalette.fuchsia500],
                    )
                  : null,
              color: i < filled ? null : AppPalette.whiteAlpha(0.1),
            ),
          ),
          if (i < 2) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({required this.controller});

  final PracticeController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PlayArea(controller: controller, isDesktop: false),
                const SizedBox(height: 32),
                _Prompt(controller: controller, isDesktop: false),
                const SizedBox(height: 28),
                _Options(controller: controller, isDesktop: false),
                const SizedBox(height: 20),
                _ResultActions(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({required this.controller});

  final PracticeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PlayArea(controller: controller, isDesktop: true),
              const SizedBox(height: 40),
              _Prompt(controller: controller, isDesktop: true),
            ],
          ),
        ),
        const SizedBox(width: 64),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Options(controller: controller, isDesktop: true),
                const SizedBox(height: 24),
                _ResultActions(controller: controller),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayArea extends StatelessWidget {
  const _PlayArea({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final isPlaying = controller.isPlaying;
    final outerSize = isDesktop ? 400.0 : 280.0;
    final innerSize = isDesktop ? 300.0 : 200.0;
    final buttonSize = isDesktop ? 176.0 : 128.0;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _Ring(size: outerSize, color: AppPalette.violet500.withValues(alpha: 0.2), active: isPlaying),
          _Ring(size: innerSize, color: AppPalette.fuchsia500.withValues(alpha: 0.3), active: isPlaying),
          Pressable(
            onTap: controller.playCurrent,
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppPalette.violet600, AppPalette.fuchsia600],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppPalette.violet500.withValues(alpha: 0.4),
                    blurRadius: 40,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 8 : 6),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppPalette.frame,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isPlaying
                        ? _EqualizerBars(isDesktop: isDesktop)
                        : Padding(
                            padding: EdgeInsets.only(left: isDesktop ? 16 : 10),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: isDesktop ? 60 : 40,
                              color: AppPalette.white,
                            ),
                          ),
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

class _Ring extends StatelessWidget {
  const _Ring({required this.size, required this.color, required this.active});

  final double size;
  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: active ? 1.1 : 1,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: active ? 0 : 1,
        duration: const Duration(milliseconds: 700),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
        ),
      ),
    );
  }
}

class _EqualizerBars extends StatefulWidget {
  const _EqualizerBars({required this.isDesktop});

  final bool isDesktop;

  @override
  State<_EqualizerBars> createState() => _EqualizerBarsState();
}

class _EqualizerBarsState extends State<_EqualizerBars>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [
    _makeController(500),
    _makeController(800),
    _makeController(620),
  ];

  AnimationController _makeController(int millis) {
    return AnimationController(
      vsync: this,
      duration: Duration(milliseconds: millis),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = widget.isDesktop ? 60.0 : 40.0;
    final width = widget.isDesktop ? 12.0 : 8.0;
    final colors = [
      AppPalette.fuchsia400,
      AppPalette.violet400,
      AppPalette.fuchsia400,
    ];

    return SizedBox(
      height: maxHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < _controllers.length; i += 1) ...[
            AnimatedBuilder(
              animation: _controllers[i],
              builder: (context, _) {
                return Container(
                  width: width,
                  height: maxHeight * (0.3 + 0.7 * _controllers[i].value),
                  color: colors[i],
                );
              },
            ),
            if (i < _controllers.length - 1) const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

class _Prompt extends StatelessWidget {
  const _Prompt({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Quel est cet intervalle ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 36 : 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppPalette.white,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppPalette.whiteAlpha(0.05),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppPalette.whiteAlpha(0.1)),
          ),
          child: Text(
            _directionLabel(controller.direction),
            style: TextStyle(
              fontSize: isDesktop ? 14 : 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: AppPalette.violet300,
            ),
          ),
        ),
      ],
    );
  }

  String _directionLabel(IntervalDirection direction) {
    switch (direction) {
      case IntervalDirection.ascending:
        return 'ASCENDANT';
      case IntervalDirection.descending:
        return 'DESCENDANT';
      case IntervalDirection.harmonic:
        return 'HARMONIQUE';
    }
  }
}

class _Options extends StatelessWidget {
  const _Options({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final choices = controller.question!.choices;

    if (isDesktop) {
      return Column(
        children: [
          for (final choice in choices) ...[
            _OptionButton(controller: controller, choice: choice, isDesktop: true),
            if (choice != choices.last) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.4,
      children: [
        for (final choice in choices)
          _OptionButton(controller: controller, choice: choice, isDesktop: false),
      ],
    );
  }
}

class _OptionState {
  const _OptionState({
    required this.fill,
    required this.border,
    required this.text,
    this.icon,
    this.glow,
  });

  final Color fill;
  final Color border;
  final Color text;
  final IconData? icon;
  final Color? glow;
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.controller,
    required this.choice,
    required this.isDesktop,
  });

  final PracticeController controller;
  final MusicInterval choice;
  final bool isDesktop;

  _OptionState _resolveState() {
    final isSelected = controller.selected == choice;
    final isAnswer = controller.question!.interval == choice;

    if (controller.showResult) {
      if (isAnswer) {
        return _OptionState(
          fill: AppPalette.green500.withValues(alpha: 0.1),
          border: AppPalette.green500.withValues(alpha: 0.5),
          text: AppPalette.green400,
          icon: Icons.check_rounded,
          glow: AppPalette.green500.withValues(alpha: 0.2),
        );
      }

      if (isSelected) {
        return _OptionState(
          fill: AppPalette.red500.withValues(alpha: 0.1),
          border: AppPalette.red500.withValues(alpha: 0.5),
          text: AppPalette.red400,
          icon: Icons.close_rounded,
        );
      }

      return _OptionState(
        fill: AppPalette.whiteAlpha(0.01),
        border: AppPalette.whiteAlpha(0.05),
        text: AppPalette.whiteAlpha(0.3),
      );
    }

    if (isSelected) {
      return _OptionState(
        fill: AppPalette.violet600,
        border: AppPalette.violet500,
        text: AppPalette.white,
        glow: AppPalette.violet500.withValues(alpha: 0.3),
      );
    }

    return _OptionState(
      fill: AppPalette.whiteAlpha(0.03),
      border: AppPalette.whiteAlpha(0.1),
      text: AppPalette.whiteAlpha(0.7),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _resolveState();

    return Pressable(
      onTap: controller.showResult ? null : () => controller.selectAnswer(choice),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : 18,
          vertical: isDesktop ? 22 : 16,
        ),
        decoration: BoxDecoration(
          color: state.fill,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: state.border),
          boxShadow: state.glow == null
              ? null
              : [BoxShadow(color: state.glow!, blurRadius: 20)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                choice.labelFr,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  color: state.text,
                ),
              ),
            ),
            if (state.icon != null)
              Icon(state.icon, size: 20, color: state.text),
          ],
        ),
      ),
    );
  }
}

class _ResultActions extends StatelessWidget {
  const _ResultActions({required this.controller});

  final PracticeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: controller.showResult
            ? Row(
                children: [
                  Expanded(
                    child: Pressable(
                      onTap: controller.markHesitation,
                      child: _actionSurface(
                        color: AppPalette.whiteAlpha(controller.hesitated ? 0.15 : 0.05),
                        border: AppPalette.whiteAlpha(0.1),
                        child: Text(
                          'HÉSITATION ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: AppPalette.whiteAlpha(0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Pressable(
                      onTap: controller.next,
                      child: _actionSurface(
                        color: AppPalette.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Suivant',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppPalette.violet900,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: AppPalette.violet900,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _actionSurface({
    required Color color,
    required Widget child,
    Color? border,
  }) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: border == null ? null : Border.all(color: border),
      ),
      child: child,
    );
  }
}
