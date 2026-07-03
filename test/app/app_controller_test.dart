import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/exercises/exercise_config.dart';
import 'package:perfect_pitch/core/exercises/exercise_type.dart';
import 'package:perfect_pitch/core/progress/interval_progress_repository.dart';

AppController _controller() {
  return AppController(
    audioEngine: const AudioEngine(player: SilentAudioPlayer()),
    progressRepository: InMemoryIntervalProgressRepository(),
  );
}

void main() {
  test('home recommendations are existing catalogue exercise types', () {
    final controller = _controller();
    addTearDown(controller.dispose);

    expect(controller.homeRecommendations, hasLength(2));
    expect(
      controller.homeRecommendations.every(ExerciseType.values.contains),
      isTrue,
    );
  });

  test('opening a home recommendation keeps the normal exercise defaults', () {
    final controller = _controller();
    addTearDown(controller.dispose);

    final type = controller.homeRecommendations.first;
    controller.openExerciseSetup(type);

    expect(controller.tab, AppTab.practice);
    expect(controller.practice.draftConfig, isNotNull);
    expect(controller.practice.draftConfig!.type, type);
    expect(
      controller.practice.draftConfig!.intervals,
      ExerciseConfig.defaults(type).intervals,
    );
    expect(controller.practice.draftConfig!.intervals.length, greaterThan(1));
  });
}
