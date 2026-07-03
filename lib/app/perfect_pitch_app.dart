import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/app/app_shell.dart';
import 'package:perfect_pitch/app/app_theme.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';

class PerfectPitchApp extends StatefulWidget {
  const PerfectPitchApp({
    required this.audioEngine,
    this.progressRepository,
    this.locale,
    super.key,
  });

  final AudioEngine audioEngine;
  final IntervalProgressRepository? progressRepository;
  final Locale? locale;

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Intervals.pro',
          locale: widget.locale ?? _controller.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              return const Locale('en');
            }

            for (final supported in supportedLocales) {
              if (supported.languageCode == locale.languageCode) {
                return supported;
              }
            }

            return const Locale('en');
          },
          theme: PerfectPitchTheme.dark(),
          home: AppShell(controller: _controller),
        );
      },
    );
  }
}
