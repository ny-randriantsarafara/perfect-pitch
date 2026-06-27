import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_theme.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/storage/progress_repository.dart';
import 'package:perfect_pitch/features/guided_path/guided_path_screen.dart';
import 'package:perfect_pitch/features/home/home_screen.dart';
import 'package:perfect_pitch/features/learn/learn_screen.dart';
import 'package:perfect_pitch/features/training/session_summary_screen.dart';
import 'package:perfect_pitch/features/training/training_screen.dart';

class PerfectPitchApp extends StatefulWidget {
  const PerfectPitchApp({
    required this.audioEngine,
    this.progressRepository,
    super.key,
  });

  final AudioEngine audioEngine;
  final ProgressRepository? progressRepository;

  @override
  State<PerfectPitchApp> createState() => _PerfectPitchAppState();
}

class _PerfectPitchAppState extends State<PerfectPitchApp> {
  late final PerfectPitchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PerfectPitchController(
      audioEngine: widget.audioEngine,
      progressRepository: widget.progressRepository,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfect Pitch',
      theme: PerfectPitchTheme.dark(),
      home: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return _CurrentScreen(controller: _controller);
        },
      ),
    );
  }
}

class _CurrentScreen extends StatelessWidget {
  const _CurrentScreen({required this.controller});

  final PerfectPitchController controller;

  @override
  Widget build(BuildContext context) {
    switch (controller.section) {
      case AppSection.home:
        return HomeScreen(controller: controller);
      case AppSection.learn:
        return LearnScreen(controller: controller);
      case AppSection.training:
        return TrainingScreen(controller: controller);
      case AppSection.guidedPath:
        return GuidedPathScreen(controller: controller);
      case AppSection.summary:
        return SessionSummaryScreen(controller: controller);
    }
  }
}
