import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_shell.dart';
import 'package:perfect_pitch/app/app_theme.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

class PerfectPitchApp extends StatefulWidget {
  const PerfectPitchApp({
    required this.audioEngine,
    this.progressRepository,
    super.key,
  });

  final AudioEngine audioEngine;
  final IntervalProgressRepository? progressRepository;

  @override
  State<PerfectPitchApp> createState() => _PerfectPitchAppState();
}

class _PerfectPitchAppState extends State<PerfectPitchApp> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppController(
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
      title: 'Intervals.pro',
      theme: PerfectPitchTheme.dark(),
      home: AppShell(controller: _controller),
    );
  }
}
