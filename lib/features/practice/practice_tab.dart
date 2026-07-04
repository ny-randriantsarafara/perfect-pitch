import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/instrument.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/exercises/session_difficulty.dart';
import 'package:perfect_pitch/core/music/music_interval.dart';
import 'package:perfect_pitch/core/progress/interval_progress.dart';
import 'package:perfect_pitch/core/session/interval_session_stats.dart';
import 'package:perfect_pitch/features/practice/practice_controller.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';
import 'package:perfect_pitch/l10n/localized_labels.dart';
import 'package:perfect_pitch/ui/glass_panel.dart';
import 'package:perfect_pitch/ui/layout_mode.dart';
import 'package:perfect_pitch/ui/pressable.dart';

/// The Exercises tab. It renders one of four stages driven by the controller:
/// the exercise catalogue, the shared setup, the active question loop, and the
/// end-of-session summary.
class PracticeTab extends StatelessWidget {
  const PracticeTab({
    required this.controller,
    required this.progress,
    required this.mode,
    super.key,
  });

  final PracticeController controller;
  final ProgressSnapshot progress;
  final LayoutMode mode;

  bool get _isDesktop {
    return mode == LayoutMode.desktop;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final Widget child;

        switch (controller.stage) {
          case PracticeStage.catalogue:
            child = _CatalogueView(
              controller: controller,
              progress: progress,
              isDesktop: _isDesktop,
            );
          case PracticeStage.setup:
            child = _SetupView(controller: controller, isDesktop: _isDesktop);
          case PracticeStage.active:
            child = _ActiveView(controller: controller, isDesktop: _isDesktop);
          case PracticeStage.summary:
            child = _SummaryView(controller: controller, isDesktop: _isDesktop);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: KeyedSubtree(key: ValueKey(controller.stage), child: child),
        );
      },
    );
  }
}

int _masteryForType(ProgressSnapshot progress, ExerciseType type) {
  final modes = _modesForType(type);
  var correct = 0;
  var total = 0;

  for (final interval in progress.intervals.values) {
    for (final mode in modes) {
      final score = interval.scoreFor(mode);
      correct += score.correct;
      total += score.total;
    }
  }

  if (total == 0) {
    return 0;
  }

  return (correct / total * 100).round();
}

List<TrainingMode> _modesForType(ExerciseType type) {
  switch (type) {
    case ExerciseType.ascendingIntervals:
      return const [TrainingMode.ascending];
    case ExerciseType.descendingIntervals:
      return const [TrainingMode.descending];
    case ExerciseType.harmonicIntervals:
      return const [TrainingMode.harmonic];
    case ExerciseType.mixedIntervals:
      return const [
        TrainingMode.ascending,
        TrainingMode.descending,
        TrainingMode.harmonic,
      ];
  }
}

// --- Catalogue ---

class _CatalogueView extends StatelessWidget {
  const _CatalogueView({
    required this.controller,
    required this.progress,
    required this.isDesktop,
  });

  final PracticeController controller;
  final ProgressSnapshot progress;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        isDesktop ? 32 : 16,
        24,
        isDesktop ? 48 : 128,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.exercisesTitle,
            style: TextStyle(
              fontSize: isDesktop ? 48 : 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.exercisesSubtitle,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 14,
              fontWeight: FontWeight.w500,
              color: AppPalette.violet200.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: isDesktop ? 40 : 24),
          for (final type in ExerciseType.values) ...[
            _CatalogueCard(
              type: type,
              mastery: _masteryForType(progress, type),
              onStart: () => controller.configureExercise(type),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _CatalogueCard extends StatelessWidget {
  const _CatalogueCard({
    required this.type,
    required this.mastery,
    required this.onStart,
  });

  final ExerciseType type;
  final int mastery;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final started = mastery > 0;
    final l10n = AppLocalizations.of(context);

    return Pressable(
      onTap: onStart,
      pressedScale: 0.99,
      child: GlassPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    type.localizedLabel(l10n),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppPalette.white,
                    ),
                  ),
                ),
                _MasteryBadge(mastery: mastery),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              type.localizedDescription(l10n),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppPalette.whiteAlpha(0.55),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _DifficultyChip(
                  label: SessionDifficulty.initial.localizedLabel(l10n),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      started ? l10n.catalogueContinue : l10n.catalogueStart,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppPalette.violet300,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppPalette.violet300,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MasteryBadge extends StatelessWidget {
  const _MasteryBadge({required this.mastery});

  final int mastery;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        AppLocalizations.of(context).masteryLabel(mastery),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppPalette.whiteAlpha(0.8),
        ),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.violet600.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.violet500.withValues(alpha: 0.3)),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          color: AppPalette.violet300,
        ),
      ),
    );
  }
}

// --- Setup ---

class _SetupView extends StatefulWidget {
  const _SetupView({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  State<_SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<_SetupView> {
  SessionDifficulty _difficulty = SessionDifficulty.initial;
  bool _showAdvanced = false;

  ExerciseConfig get _config {
    return widget.controller.draftConfig!;
  }

  void _update(ExerciseConfig config) {
    widget.controller.updateDraftConfig(config);
  }

  void _selectDifficulty(SessionDifficulty difficulty) {
    setState(() => _difficulty = difficulty);
    _update(difficulty.apply(_config));
  }

  void _toggleInterval(MusicInterval interval) {
    final intervals = _config.intervals.toList();

    if (intervals.contains(interval)) {
      if (intervals.length <= 1) {
        return;
      }

      intervals.remove(interval);
    } else {
      intervals.add(interval);
    }

    _update(_config.copyWith(intervals: intervals));
  }

  void _toggleDirection(IntervalDirection direction) {
    final directions = _config.directions.toSet();

    if (directions.contains(direction)) {
      if (directions.length <= 1) {
        return;
      }

      directions.remove(direction);
    } else {
      directions.add(direction);
    }

    _update(_config.copyWith(directions: directions));
  }

  @override
  Widget build(BuildContext context) {
    final config = _config;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        widget.isDesktop ? 32 : 16,
        24,
        widget.isDesktop ? 48 : 128,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SetupHeader(
            title: config.type.localizedLabel(l10n),
            onBack: widget.controller.returnToExercises,
          ),
          const SizedBox(height: 24),
          _SetupSectionTitle(l10n.settings, alreadyUppercase: true),
          const SizedBox(height: 12),
          _DifficultySelector(
            selected: _difficulty,
            onSelect: _selectDifficulty,
          ),
          const SizedBox(height: 16),
          _StepperRow(
            label: l10n.setupQuestions,
            value: '${config.questionCount}',
            onDecrement: config.questionCount > 3
                ? () => _update(
                    config.copyWith(questionCount: config.questionCount - 1),
                  )
                : null,
            onIncrement: config.questionCount < 20
                ? () => _update(
                    config.copyWith(questionCount: config.questionCount + 1),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          _InstrumentSelector(
            selected: config.instrument,
            onSelect: (instrument) =>
                _update(config.copyWith(instrument: instrument)),
          ),
          const SizedBox(height: 24),
          _AdvancedToggle(
            expanded: _showAdvanced,
            onToggle: () => setState(() => _showAdvanced = !_showAdvanced),
          ),
          if (_showAdvanced) ...[
            const SizedBox(height: 16),
            _AdvancedSection(
              config: config,
              onToggleInterval: _toggleInterval,
              onToggleDirection: _toggleDirection,
              onChanged: _update,
            ),
          ],
          const SizedBox(height: 28),
          _PrimaryButton(
            key: const ValueKey('practice-setup-start'),
            label: l10n.startSession,
            onTap: () => widget.controller.startExercise(config),
          ),
        ],
      ),
    );
  }
}

class _SetupHeader extends StatelessWidget {
  const _SetupHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Pressable(
          onTap: onBack,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppPalette.whiteAlpha(0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppPalette.whiteAlpha(0.1)),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 20,
              color: AppPalette.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: AppPalette.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _SetupSectionTitle extends StatelessWidget {
  const _SetupSectionTitle(this.label, {this.alreadyUppercase = false});

  final String label;
  final bool alreadyUppercase;

  @override
  Widget build(BuildContext context) {
    return Text(
      alreadyUppercase ? label : label.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: AppPalette.whiteAlpha(0.4),
      ),
    );
  }
}

class _DifficultySelector extends StatelessWidget {
  const _DifficultySelector({required this.selected, required this.onSelect});

  final SessionDifficulty selected;
  final ValueChanged<SessionDifficulty> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final difficulty in SessionDifficulty.values)
          _SegmentChip(
            label: difficulty.localizedLabel(AppLocalizations.of(context)),
            selected: difficulty == selected,
            onTap: () => onSelect(difficulty),
          ),
      ],
    );
  }
}

class _InstrumentSelector extends StatelessWidget {
  const _InstrumentSelector({required this.selected, required this.onSelect});

  final Instrument selected;
  final ValueChanged<Instrument> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final instrument in Instrument.values)
          _SegmentChip(
            label: instrument.localizedLabel(AppLocalizations.of(context)),
            selected: instrument == selected,
            onTap: () => onSelect(instrument),
          ),
      ],
    );
  }
}

class _AdvancedToggle extends StatelessWidget {
  const _AdvancedToggle({required this.expanded, required this.onToggle});

  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onToggle,
      child: Row(
        children: [
          _SetupSectionTitle(AppLocalizations.of(context).setupAdvanced),
          const SizedBox(width: 8),
          Icon(
            expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
            size: 20,
            color: AppPalette.whiteAlpha(0.4),
          ),
        ],
      ),
    );
  }
}

class _AdvancedSection extends StatelessWidget {
  const _AdvancedSection({
    required this.config,
    required this.onToggleInterval,
    required this.onToggleDirection,
    required this.onChanged,
  });

  final ExerciseConfig config;
  final ValueChanged<MusicInterval> onToggleInterval;
  final ValueChanged<IntervalDirection> onToggleDirection;
  final ValueChanged<ExerciseConfig> onChanged;

  @override
  Widget build(BuildContext context) {
    final maxChoices = config.intervals.length.clamp(2, 6);
    final l10n = AppLocalizations.of(context);

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SetupSectionTitle(l10n.setupIntervals),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final interval in MusicInterval.values)
                _SegmentChip(
                  label: interval.localizedLabel(l10n),
                  selected: config.intervals.contains(interval),
                  onTap: () => onToggleInterval(interval),
                ),
            ],
          ),
          if (config.type.isMixed) ...[
            const SizedBox(height: 20),
            _SetupSectionTitle(l10n.setupDirections),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final direction in IntervalDirection.values)
                  _SegmentChip(
                    label: direction.localizedLabel(l10n),
                    selected: config.directions.contains(direction),
                    onTap: () => onToggleDirection(direction),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          _StepperRow(
            label: l10n.setupChoicesPerQuestion,
            value: '${config.choiceCount}',
            onDecrement: config.choiceCount > 2
                ? () => onChanged(
                    config.copyWith(choiceCount: config.choiceCount - 1),
                  )
                : null,
            onIncrement: config.choiceCount < maxChoices
                ? () => onChanged(
                    config.copyWith(choiceCount: config.choiceCount + 1),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          _SwitchRow(
            label: l10n.setupUnlimitedReplays,
            value: config.allowsUnlimitedReplays,
            onChanged: (unlimited) => onChanged(
              unlimited
                  ? config.copyWith(clearReplayLimit: true)
                  : config.copyWith(replayLimit: 3),
            ),
          ),
          if (!config.allowsUnlimitedReplays)
            _StepperRow(
              label: l10n.setupReplayLimit,
              value: '${config.replayLimit}',
              onDecrement: config.replayLimit! > 0
                  ? () => onChanged(
                      config.copyWith(replayLimit: config.replayLimit! - 1),
                    )
                  : null,
              onIncrement: config.replayLimit! < 5
                  ? () => onChanged(
                      config.copyWith(replayLimit: config.replayLimit! + 1),
                    )
                  : null,
            ),
          const SizedBox(height: 12),
          _StepperRow(
            label: l10n.setupLowNoteMidi,
            value: '${config.minimumRootMidi}',
            onDecrement: config.minimumRootMidi > 40
                ? () => onChanged(
                    config.copyWith(
                      minimumRootMidi: config.minimumRootMidi - 1,
                    ),
                  )
                : null,
            onIncrement: config.minimumRootMidi < config.maximumRootMidi
                ? () => onChanged(
                    config.copyWith(
                      minimumRootMidi: config.minimumRootMidi + 1,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          _StepperRow(
            label: l10n.setupHighNoteMidi,
            value: '${config.maximumRootMidi}',
            onDecrement: config.maximumRootMidi > config.minimumRootMidi
                ? () => onChanged(
                    config.copyWith(
                      maximumRootMidi: config.maximumRootMidi - 1,
                    ),
                  )
                : null,
            onIncrement: config.maximumRootMidi < 84
                ? () => onChanged(
                    config.copyWith(
                      maximumRootMidi: config.maximumRootMidi + 1,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          _SwitchRow(
            label: l10n.setupAutoPlay,
            value: config.autoPlay,
            onChanged: (value) => onChanged(config.copyWith(autoPlay: value)),
          ),
          _SwitchRow(
            label: l10n.setupImmediateFeedback,
            value: config.immediateFeedback,
            onChanged: (value) =>
                onChanged(config.copyWith(immediateFeedback: value)),
          ),
          _SwitchRow(
            label: l10n.setupAnnounceDirection,
            value: config.showDirectionBeforeAnswer,
            onChanged: (value) =>
                onChanged(config.copyWith(showDirectionBeforeAnswer: value)),
          ),
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppPalette.violet600 : AppPalette.whiteAlpha(0.05),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppPalette.violet500 : AppPalette.whiteAlpha(0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? AppPalette.white : AppPalette.whiteAlpha(0.6),
          ),
        ),
      ),
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final String value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppPalette.white,
            ),
          ),
        ),
        _StepButton(icon: Icons.remove_rounded, onTap: onDecrement),
        SizedBox(
          width: 56,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppPalette.white,
            ),
          ),
        ),
        _StepButton(icon: Icons.add_rounded, onTap: onIncrement),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return Pressable(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppPalette.whiteAlpha(enabled ? 0.08 : 0.02),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppPalette.whiteAlpha(enabled ? 0.8 : 0.2),
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppPalette.white,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppPalette.white,
            activeTrackColor: AppPalette.violet600,
          ),
        ],
      ),
    );
  }
}

// --- Active session ---

class _ActiveView extends StatelessWidget {
  const _ActiveView({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final question = controller.question;

    if (question == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 8, 24, isDesktop ? 48 : 128),
      child: Column(
        children: [
          _TopBar(controller: controller, isDesktop: isDesktop),
          const SizedBox(height: 24),
          Expanded(
            child: isDesktop
                ? _DesktopBody(controller: controller)
                : _MobileBody(controller: controller),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final questionNumber = controller.questionNumber;
    final questionCount = controller.questionCount;
    final canSkip = !controller.showResult && !controller.isPlaying;
    final fraction = questionCount == 0 ? 0.0 : questionNumber / questionCount;
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.questionProgress(questionNumber, questionCount),
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
              onTap: canSkip ? controller.skip : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isDesktop) ...[
                    Text(
                      l10n.skipQuestion,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppPalette.whiteAlpha(canSkip ? 0.4 : 0.15),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Icon(
                    Icons.skip_next_rounded,
                    size: 22,
                    color: AppPalette.whiteAlpha(canSkip ? 0.4 : 0.15),
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
    final widths = isDesktop ? [96.0, 32.0, 32.0] : [48.0, 16.0, 16.0];

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
                const SizedBox(height: 20),
                _ReplayHint(controller: controller),
                const SizedBox(height: 20),
                _Prompt(controller: controller, isDesktop: false),
                const SizedBox(height: 24),
                _Options(controller: controller, isDesktop: false),
                const SizedBox(height: 16),
                _Explanation(controller: controller),
                const SizedBox(height: 12),
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
              const SizedBox(height: 24),
              _ReplayHint(controller: controller),
              const SizedBox(height: 24),
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
                const SizedBox(height: 16),
                _Explanation(controller: controller),
                const SizedBox(height: 16),
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
    final outerSize = isDesktop ? 400.0 : 240.0;
    final innerSize = isDesktop ? 300.0 : 172.0;
    final buttonSize = isDesktop ? 176.0 : 116.0;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _Ring(
            size: outerSize,
            color: AppPalette.violet500.withValues(alpha: 0.2),
            active: isPlaying,
          ),
          _Ring(
            size: innerSize,
            color: AppPalette.fuchsia500.withValues(alpha: 0.3),
            active: isPlaying,
          ),
          Pressable(
            onTap: controller.canReplay
                ? () => controller.playCurrent(isReplay: true)
                : null,
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
                        : Icon(
                            Icons.replay_rounded,
                            size: isDesktop ? 60 : 40,
                            color: AppPalette.white,
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

class _ReplayHint extends StatelessWidget {
  const _ReplayHint({required this.controller});

  final PracticeController controller;

  @override
  Widget build(BuildContext context) {
    final config = controller.config;

    if (config == null) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    final replayLimit = config.replayLimit;
    final text = config.allowsUnlimitedReplays || replayLimit == null
        ? l10n.replayUnlimited
        : l10n.replayCount(controller.replayCount, replayLimit);

    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: AppPalette.whiteAlpha(0.4),
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
    final config = controller.config;
    final reveal =
        controller.showResult || (config?.showDirectionBeforeAnswer ?? true);
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Text(
          l10n.intervalQuestionPrompt,
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
          key: reveal ? const ValueKey('direction-badge') : null,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppPalette.whiteAlpha(0.05),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppPalette.whiteAlpha(0.1)),
          ),
          child: Text(
            reveal
                ? controller.question!.direction.localizedLabel(l10n)
                : l10n.directionUnknown,
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
            _OptionButton(
              controller: controller,
              choice: choice,
              isDesktop: true,
            ),
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
          _OptionButton(
            controller: controller,
            choice: choice,
            isDesktop: false,
          ),
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
    final enabled = !controller.showResult && !controller.isPlaying;
    final l10n = AppLocalizations.of(context);

    return Pressable(
      onTap: enabled ? () => controller.selectAnswer(choice) : null,
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
                choice.localizedLabel(l10n),
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

class _Explanation extends StatelessWidget {
  const _Explanation({required this.controller});

  final PracticeController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.showResult || controller.isCorrect) {
      return const SizedBox.shrink();
    }

    final selected = controller.selected;
    final expected = controller.question!.interval;
    final l10n = AppLocalizations.of(context);
    final expectedLabel = expected.localizedLabel(l10n);

    if (selected == null) {
      return _ExplanationSurface(text: l10n.resultSkippedAnswer(expectedLabel));
    }

    final delta = (selected.semitones - expected.semitones).abs();
    final selectedLabel = selected.localizedLabel(l10n);

    return _ExplanationSurface(
      text: l10n.resultWrongAnswer(selectedLabel, expectedLabel, delta),
    );
  }
}

class _ExplanationSurface extends StatelessWidget {
  const _ExplanationSurface({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPalette.red500.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.red500.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppPalette.whiteAlpha(0.85),
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
    if (!controller.showResult) {
      return const SizedBox(height: 8);
    }

    final canAdvance = !controller.isPlaying;
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: Pressable(
            onTap: controller.markHesitation,
            child: _actionSurface(
              color: AppPalette.whiteAlpha(controller.hesitated ? 0.15 : 0.05),
              border: AppPalette.whiteAlpha(0.1),
              child: Text(
                l10n.resultHesitation,
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
            onTap: canAdvance ? controller.next : null,
            child: _actionSurface(
              color: AppPalette.whiteAlpha(canAdvance ? 1 : 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.resultNext,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppPalette.violet900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
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

// --- Summary ---

class _SummaryView extends StatelessWidget {
  const _SummaryView({required this.controller, required this.isDesktop});

  final PracticeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final stats = IntervalSessionStats.fromAttempts(controller.attempts);
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        isDesktop ? 32 : 16,
        24,
        isDesktop ? 48 : 128,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.summaryTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 40 : 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: AppPalette.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.summaryScore(stats.correctAnswers, stats.totalQuestions),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppPalette.violet300,
            ),
          ),
          const SizedBox(height: 24),
          _SummaryGrid(stats: stats),
          const SizedBox(height: 24),
          _PrimaryButton(
            label: l10n.summaryReplaySession,
            onTap: controller.repeatSession,
          ),
          const SizedBox(height: 12),
          _SecondaryButton(
            label: l10n.summaryRetryMistakes,
            enabled: stats.correctAnswers < stats.totalQuestions,
            onTap: controller.retryMistakes,
          ),
          const SizedBox(height: 12),
          _SecondaryButton(
            label: l10n.summaryIncreaseDifficulty,
            enabled: true,
            onTap: controller.increaseDifficulty,
          ),
          const SizedBox(height: 12),
          _SecondaryButton(
            label: l10n.summaryBackToExercises,
            enabled: true,
            onTap: controller.returnToExercises,
          ),
        ],
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.stats});

  final IntervalSessionStats stats;

  @override
  Widget build(BuildContext context) {
    final confusion = stats.mostCommonConfusion;
    final hardest = stats.hardestInterval;
    final seconds = (stats.averageResponseTime.inMilliseconds / 1000)
        .toStringAsFixed(1);
    final l10n = AppLocalizations.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _SummaryStat(
          label: l10n.summaryAccuracy,
          value: '${stats.accuracyPercentage}%',
        ),
        _SummaryStat(label: l10n.summaryAverageTime, value: '$seconds s'),
        _SummaryStat(
          label: l10n.summaryReplays,
          value: '${stats.manualReplays}',
        ),
        _SummaryStat(
          label: l10n.summaryBestStreak,
          value: '${stats.bestStreak}',
        ),
        _SummaryStat(
          label: l10n.summarySkipped,
          value: '${stats.skippedQuestions}',
        ),
        _SummaryStat(
          label: l10n.summaryHardest,
          value: hardest?.localizedLabel(l10n) ?? '—',
        ),
        _SummaryStat(
          label: l10n.summaryCommonConfusion,
          value: confusion == null
              ? '—'
              : '${confusion.expected.localizedLabel(l10n)} → ${confusion.selected.localizedLabel(l10n)}',
        ),
      ],
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return SizedBox(
          width: maxWidth,
          child: GlassPanel(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: AppPalette.whiteAlpha(0.4),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppPalette.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Shared buttons ---

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppPalette.violet600, AppPalette.fuchsia600],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppPalette.violet500.withValues(alpha: 0.3),
              blurRadius: 20,
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppPalette.white,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppPalette.whiteAlpha(enabled ? 0.05 : 0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppPalette.whiteAlpha(0.1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppPalette.whiteAlpha(enabled ? 0.85 : 0.3),
          ),
        ),
      ),
    );
  }
}
