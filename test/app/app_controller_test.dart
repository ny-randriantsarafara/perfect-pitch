import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/app/app_controller.dart';
import 'package:perfect_pitch/core/audio/audio_engine.dart';
import 'package:perfect_pitch/core/audio/platform_audio_player_stub.dart';
import 'package:perfect_pitch/core/music/music_note.dart';
import 'package:perfect_pitch/core/session/session_settings.dart';
import 'package:perfect_pitch/core/storage/progress_repository.dart';

void main() {
  test(
    'records local progress and opens the summary when a session ends',
    () async {
      final repository = InMemoryProgressRepository();
      final controller = PerfectPitchController(
        audioEngine: const AudioEngine(player: SilentAudioPlayer()),
        progressRepository: repository,
        initialSettings: SessionSettings.custom(
          enabledNotes: const [MusicNote.doNote],
          enabledOctaves: const [4],
          questionCount: 1,
          replayLimit: null,
          referenceMode: ReferenceMode.none,
        ),
      );

      controller.startTraining();
      controller.answer(MusicNote.doNote);
      controller.nextQuestion();
      await Future<void>.delayed(Duration.zero);

      final snapshot = await repository.load();

      expect(controller.section, AppSection.summary);
      expect(snapshot.completedSessions, 1);
      expect(snapshot.noteProgress[MusicNote.doNote]?.playedCount, 1);
    },
  );
}
