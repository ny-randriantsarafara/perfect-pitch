// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'The Perfect Pitch';

  @override
  String get navHome => 'Home';

  @override
  String get navExercises => 'Exercises';

  @override
  String get navLearn => 'Learn';

  @override
  String get navGuitar => 'Guitar';

  @override
  String get navProgress => 'Progress';

  @override
  String streakDays(int days) {
    return '$days days';
  }

  @override
  String get streakLabel => 'Current streak';

  @override
  String streakDaysUppercase(int days) {
    return '$days Days';
  }

  @override
  String get homeGreeting => 'Hello!';

  @override
  String get homeSubtitle => 'Your ear training is waiting.';

  @override
  String get homeTodaySession => 'TODAY\'S SESSION';

  @override
  String get homeSessionTitle => 'Perfect Fifth\n& Comparison';

  @override
  String get homeSessionSubtitle => 'Warm-up, new interval, and practice.';

  @override
  String get homeStartFiveMinutes => 'Start (5 min)';

  @override
  String get homeRepertoire => 'Your repertoire';

  @override
  String get homeSeeAll => 'SEE ALL';

  @override
  String get discover => 'Not started';

  @override
  String get learning => 'Learning';

  @override
  String masteredAt(int percentage) {
    return 'Mastered at $percentage%';
  }

  @override
  String get repertoireUnisonOctave => 'Unison\n& Octave';

  @override
  String get repertoirePerfectFifth => 'Perfect\nFifth';

  @override
  String get practiceMode => 'PRACTICE MODE';

  @override
  String get guitarTitle => 'Fretboard';

  @override
  String get guitarPromptPrefix => 'Find the ';

  @override
  String get guitarPromptSuffix => ' from the glowing root note.';

  @override
  String get guitarNextInterval => 'Next interval';

  @override
  String get exercisesTitle => 'Exercises';

  @override
  String get exercisesSubtitle => 'Choose an ear-training exercise.';

  @override
  String get startSession => 'Start session';

  @override
  String get settings => 'SETTINGS';

  @override
  String get intervalQuestionPrompt => 'What interval is this?';

  @override
  String get languagePickerTooltip => 'Choose language';

  @override
  String get exerciseAscendingLabel => 'Ascending intervals';

  @override
  String get exerciseAscendingDescription => 'Low note, then high note.';

  @override
  String get exerciseDescendingLabel => 'Descending intervals';

  @override
  String get exerciseDescendingDescription => 'High note, then low note.';

  @override
  String get exerciseHarmonicLabel => 'Harmonic intervals';

  @override
  String get exerciseHarmonicDescription => 'Both notes played together.';

  @override
  String get exerciseMixedLabel => 'Mixed intervals';

  @override
  String get exerciseMixedDescription =>
      'Ascending, descending, or harmonic on each question.';

  @override
  String get difficultyBeginner => 'Beginner';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get trainingModeAscending => 'Ascending';

  @override
  String get trainingModeDescending => 'Descending';

  @override
  String get trainingModeHarmonic => 'Harmonic';

  @override
  String get trainingModeGuitar => 'Guitar';

  @override
  String get directionAscending => 'ASCENDING';

  @override
  String get directionDescending => 'DESCENDING';

  @override
  String get directionHarmonic => 'HARMONIC';

  @override
  String get instrumentSine => 'Sine';

  @override
  String get instrumentWarmSynth => 'Warm synth';

  @override
  String get instrumentPiano => 'Piano';

  @override
  String get instrumentGuitar => 'Guitar';

  @override
  String get catalogueContinue => 'Continue';

  @override
  String get catalogueStart => 'Start';

  @override
  String masteryLabel(int percentage) {
    return 'Mastery $percentage%';
  }

  @override
  String get setupQuestions => 'Questions';

  @override
  String get setupAdvanced => 'Advanced';

  @override
  String get setupIntervals => 'Intervals';

  @override
  String get setupDirections => 'Directions';

  @override
  String get setupChoicesPerQuestion => 'Choices per question';

  @override
  String get setupUnlimitedReplays => 'Unlimited replays';

  @override
  String get setupReplayLimit => 'Replay limit';

  @override
  String get setupLowNoteMidi => 'Low note (MIDI)';

  @override
  String get setupHighNoteMidi => 'High note (MIDI)';

  @override
  String get setupAutoPlay => 'Auto-play';

  @override
  String get setupImmediateFeedback => 'Immediate feedback';

  @override
  String get setupAnnounceDirection => 'Announce direction';

  @override
  String questionProgress(int current, int total) {
    return 'QUESTION $current/$total';
  }

  @override
  String get skipQuestion => 'SKIP';

  @override
  String get replayUnlimited => 'Unlimited replays';

  @override
  String replayCount(int count, int limit) {
    return 'Replays: $count/$limit';
  }

  @override
  String get directionUnknown => 'DIRECTION?';

  @override
  String resultSkippedAnswer(String expected) {
    return 'Skipped - the answer was $expected.';
  }

  @override
  String resultWrongAnswer(String selected, String expected, int delta) {
    return 'You chose $selected; it was $expected ($delta semitones away).';
  }

  @override
  String get resultHesitation => 'HESITATION?';

  @override
  String get resultNext => 'Next';

  @override
  String get summaryTitle => 'Session complete';

  @override
  String summaryScore(int correct, int total) {
    return '$correct/$total correct answers';
  }

  @override
  String get summaryReplaySession => 'Replay this session';

  @override
  String get summaryRetryMistakes => 'Review my mistakes';

  @override
  String get summaryIncreaseDifficulty => 'Increase difficulty';

  @override
  String get summaryBackToExercises => 'Back to exercises';

  @override
  String get summaryAccuracy => 'Accuracy';

  @override
  String get summaryAverageTime => 'Average time';

  @override
  String get summaryReplays => 'Replays';

  @override
  String get summaryBestStreak => 'Best streak';

  @override
  String get summarySkipped => 'Skipped';

  @override
  String get summaryHardest => 'Hardest';

  @override
  String get summaryCommonConfusion => 'Common confusion';

  @override
  String get statsTitle => 'Progress';

  @override
  String get statsSubtitle => 'Analysis of your performance';

  @override
  String get statsIntervalDetail => 'Interval detail';

  @override
  String get statsDays => 'Days';

  @override
  String get statsIntervals => 'Intervals';

  @override
  String get statsLevels => 'Levels';

  @override
  String statsAverage(int percentage) {
    return 'Avg. $percentage%';
  }

  @override
  String get intervalUnisonLabel => 'Unison';

  @override
  String get intervalUnisonSensation => 'Same identity, same pitch';

  @override
  String get intervalMinorSecondLabel => 'Minor Second';

  @override
  String get intervalMinorSecondSensation => 'Very close, tense';

  @override
  String get intervalMajorSecondLabel => 'Major Second';

  @override
  String get intervalMajorSecondSensation => 'Small melodic movement';

  @override
  String get intervalMinorThirdLabel => 'Minor Third';

  @override
  String get intervalMinorThirdSensation => 'Minor color';

  @override
  String get intervalMajorThirdLabel => 'Major Third';

  @override
  String get intervalMajorThirdSensation => 'Major color';

  @override
  String get intervalPerfectFourthLabel => 'Perfect Fourth';

  @override
  String get intervalPerfectFourthSensation => 'Open, suspended';

  @override
  String get intervalTritoneLabel => 'Tritone';

  @override
  String get intervalTritoneSensation => 'Unstable, very tense';

  @override
  String get intervalPerfectFifthLabel => 'Perfect Fifth';

  @override
  String get intervalPerfectFifthSensation => 'Stable, powerful';

  @override
  String get intervalMinorSixthLabel => 'Minor Sixth';

  @override
  String get intervalMinorSixthSensation => 'Nostalgic, soft';

  @override
  String get intervalMajorSixthLabel => 'Major Sixth';

  @override
  String get intervalMajorSixthSensation => 'Open, bright';

  @override
  String get intervalMinorSeventhLabel => 'Minor Seventh';

  @override
  String get intervalMinorSeventhSensation => 'Tense, unresolved';

  @override
  String get intervalMajorSeventhLabel => 'Major Seventh';

  @override
  String get intervalMajorSeventhSensation => 'Very tense, bright';

  @override
  String get intervalOctaveLabel => 'Octave';

  @override
  String get intervalOctaveSensation => 'Same identity, different height';

  @override
  String get coursePrevious => 'Previous';

  @override
  String get courseNext => 'Next';

  @override
  String get courseStartDrill => 'Start drill';

  @override
  String get courseRecommended => 'Recommended';

  @override
  String get courseCompleted => 'Completed';

  @override
  String get courseLearnFirst => 'Learn first';

  @override
  String get coursePlayDemo => 'Play example';

  @override
  String courseEstimatedMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get learnTabTitle => 'Learn';

  @override
  String get learnTabSubtitle => 'Short lessons before each drill.';

  @override
  String get courseEarTrainingBasicsTitle => 'How to train your ear';

  @override
  String get courseEarTrainingBasicsGoal =>
      'Learn the app routine before the first exercise.';

  @override
  String get courseEarTrainingBasicsCard1Title => 'Concept';

  @override
  String get courseEarTrainingBasicsCard1Body =>
      'An interval is the distance between two notes. In this app, your job is to name that distance by ear.';

  @override
  String get courseEarTrainingBasicsCard2Title => 'Ear clue';

  @override
  String get courseEarTrainingBasicsCard2Body =>
      'Do not hunt for the note names. Listen for size, color, and stability: small/large, tense/calm, dark/bright.';

  @override
  String get courseEarTrainingBasicsCard3Title => 'Mini drill';

  @override
  String get courseEarTrainingBasicsCard3Body =>
      'Play the example, pause, then say whether it feels same, close, open, or far before choosing an answer.';

  @override
  String get courseIntervalDirectionTitle => 'Ascending, descending, harmonic';

  @override
  String get courseIntervalDirectionGoal =>
      'Know the three ways the same interval can be played.';

  @override
  String get courseIntervalDirectionCard1Title => 'Concept';

  @override
  String get courseIntervalDirectionCard1Body =>
      'Ascending goes low to high. Descending goes high to low. Harmonic plays both notes together.';

  @override
  String get courseIntervalDirectionCard2Title => 'Ear clue';

  @override
  String get courseIntervalDirectionCard2Body =>
      'The interval name stays the same even when the direction changes. Direction changes the feeling, not the distance.';

  @override
  String get courseIntervalDirectionCard3Title => 'Mini drill';

  @override
  String get courseIntervalDirectionCard3Body =>
      'Play the same interval in all three directions and answer only the direction first, then the interval.';

  @override
  String get coursePracticeStrategyTitle => 'Practice without guessing';

  @override
  String get coursePracticeStrategyGoal =>
      'Use replay and hesitation markers the right way.';

  @override
  String get coursePracticeStrategyCard1Title => 'Concept';

  @override
  String get coursePracticeStrategyCard1Body =>
      'Accuracy matters more than speed. A slow correct answer builds the map; a fast guess adds noise.';

  @override
  String get coursePracticeStrategyCard2Title => 'Ear clue';

  @override
  String get coursePracticeStrategyCard2Body =>
      'Replay once for the shape, once for the feeling. After that, answer and learn from the comparison.';

  @override
  String get coursePracticeStrategyCard3Title => 'Mini drill';

  @override
  String get coursePracticeStrategyCard3Body =>
      'When unsure, mark hesitation after answering. This keeps correct-but-fragile intervals visible in progress.';

  @override
  String get courseUnisonTitle => 'Unison';

  @override
  String get courseUnisonGoal => 'Recognize Unison by its sound.';

  @override
  String get courseUnisonCard1Title => 'What to hear';

  @override
  String get courseUnisonCard1Body =>
      'Focus on the feeling: same note, no distance';

  @override
  String get courseUnisonCard2Title => 'Compare it';

  @override
  String get courseUnisonCard2Body =>
      'Compare Unison with Octave. Name the size first, then the color.';

  @override
  String get courseUnisonCard3Title => 'Mini drill';

  @override
  String get courseUnisonCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseOctaveTitle => 'Octave';

  @override
  String get courseOctaveGoal => 'Recognize Octave by its sound.';

  @override
  String get courseOctaveCard1Title => 'What to hear';

  @override
  String get courseOctaveCard1Body =>
      'Focus on the feeling: same identity, different height';

  @override
  String get courseOctaveCard2Title => 'Compare it';

  @override
  String get courseOctaveCard2Body =>
      'Compare Octave with Unison. Name the size first, then the color.';

  @override
  String get courseOctaveCard3Title => 'Mini drill';

  @override
  String get courseOctaveCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get coursePerfectFifthTitle => 'Perfect fifth';

  @override
  String get coursePerfectFifthGoal => 'Recognize Perfect fifth by its sound.';

  @override
  String get coursePerfectFifthCard1Title => 'What to hear';

  @override
  String get coursePerfectFifthCard1Body =>
      'Focus on the feeling: stable, open, powerful';

  @override
  String get coursePerfectFifthCard2Title => 'Compare it';

  @override
  String get coursePerfectFifthCard2Body =>
      'Compare Perfect fifth with Perfect fourth. Name the size first, then the color.';

  @override
  String get coursePerfectFifthCard3Title => 'Mini drill';

  @override
  String get coursePerfectFifthCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMinorThirdTitle => 'Minor third';

  @override
  String get courseMinorThirdGoal => 'Recognize Minor third by its sound.';

  @override
  String get courseMinorThirdCard1Title => 'What to hear';

  @override
  String get courseMinorThirdCard1Body =>
      'Focus on the feeling: small leap, darker color';

  @override
  String get courseMinorThirdCard2Title => 'Compare it';

  @override
  String get courseMinorThirdCard2Body =>
      'Compare Minor third with Major third. Name the size first, then the color.';

  @override
  String get courseMinorThirdCard3Title => 'Mini drill';

  @override
  String get courseMinorThirdCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMajorThirdTitle => 'Major third';

  @override
  String get courseMajorThirdGoal => 'Recognize Major third by its sound.';

  @override
  String get courseMajorThirdCard1Title => 'What to hear';

  @override
  String get courseMajorThirdCard1Body =>
      'Focus on the feeling: small leap, brighter color';

  @override
  String get courseMajorThirdCard2Title => 'Compare it';

  @override
  String get courseMajorThirdCard2Body =>
      'Compare Major third with Minor third. Name the size first, then the color.';

  @override
  String get courseMajorThirdCard3Title => 'Mini drill';

  @override
  String get courseMajorThirdCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get coursePerfectFourthTitle => 'Perfect fourth';

  @override
  String get coursePerfectFourthGoal =>
      'Recognize Perfect fourth by its sound.';

  @override
  String get coursePerfectFourthCard1Title => 'What to hear';

  @override
  String get coursePerfectFourthCard1Body =>
      'Focus on the feeling: open, suspended, waiting';

  @override
  String get coursePerfectFourthCard2Title => 'Compare it';

  @override
  String get coursePerfectFourthCard2Body =>
      'Compare Perfect fourth with Perfect fifth. Name the size first, then the color.';

  @override
  String get coursePerfectFourthCard3Title => 'Mini drill';

  @override
  String get coursePerfectFourthCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMinorSecondTitle => 'Minor second';

  @override
  String get courseMinorSecondGoal => 'Recognize Minor second by its sound.';

  @override
  String get courseMinorSecondCard1Title => 'What to hear';

  @override
  String get courseMinorSecondCard1Body =>
      'Focus on the feeling: very close and tense';

  @override
  String get courseMinorSecondCard2Title => 'Compare it';

  @override
  String get courseMinorSecondCard2Body =>
      'Compare Minor second with Major second. Name the size first, then the color.';

  @override
  String get courseMinorSecondCard3Title => 'Mini drill';

  @override
  String get courseMinorSecondCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMajorSecondTitle => 'Major second';

  @override
  String get courseMajorSecondGoal => 'Recognize Major second by its sound.';

  @override
  String get courseMajorSecondCard1Title => 'What to hear';

  @override
  String get courseMajorSecondCard1Body =>
      'Focus on the feeling: small natural movement';

  @override
  String get courseMajorSecondCard2Title => 'Compare it';

  @override
  String get courseMajorSecondCard2Body =>
      'Compare Major second with Minor second. Name the size first, then the color.';

  @override
  String get courseMajorSecondCard3Title => 'Mini drill';

  @override
  String get courseMajorSecondCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMinorSixthTitle => 'Minor sixth';

  @override
  String get courseMinorSixthGoal => 'Recognize Minor sixth by its sound.';

  @override
  String get courseMinorSixthCard1Title => 'What to hear';

  @override
  String get courseMinorSixthCard1Body =>
      'Focus on the feeling: wide, soft, nostalgic';

  @override
  String get courseMinorSixthCard2Title => 'Compare it';

  @override
  String get courseMinorSixthCard2Body =>
      'Compare Minor sixth with Major sixth. Name the size first, then the color.';

  @override
  String get courseMinorSixthCard3Title => 'Mini drill';

  @override
  String get courseMinorSixthCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMajorSixthTitle => 'Major sixth';

  @override
  String get courseMajorSixthGoal => 'Recognize Major sixth by its sound.';

  @override
  String get courseMajorSixthCard1Title => 'What to hear';

  @override
  String get courseMajorSixthCard1Body =>
      'Focus on the feeling: wide, bright, open';

  @override
  String get courseMajorSixthCard2Title => 'Compare it';

  @override
  String get courseMajorSixthCard2Body =>
      'Compare Major sixth with Minor sixth. Name the size first, then the color.';

  @override
  String get courseMajorSixthCard3Title => 'Mini drill';

  @override
  String get courseMajorSixthCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMinorSeventhTitle => 'Minor seventh';

  @override
  String get courseMinorSeventhGoal => 'Recognize Minor seventh by its sound.';

  @override
  String get courseMinorSeventhCard1Title => 'What to hear';

  @override
  String get courseMinorSeventhCard1Body =>
      'Focus on the feeling: wide, tense, unresolved';

  @override
  String get courseMinorSeventhCard2Title => 'Compare it';

  @override
  String get courseMinorSeventhCard2Body =>
      'Compare Minor seventh with Major seventh. Name the size first, then the color.';

  @override
  String get courseMinorSeventhCard3Title => 'Mini drill';

  @override
  String get courseMinorSeventhCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseMajorSeventhTitle => 'Major seventh';

  @override
  String get courseMajorSeventhGoal => 'Recognize Major seventh by its sound.';

  @override
  String get courseMajorSeventhCard1Title => 'What to hear';

  @override
  String get courseMajorSeventhCard1Body =>
      'Focus on the feeling: almost octave, very tense';

  @override
  String get courseMajorSeventhCard2Title => 'Compare it';

  @override
  String get courseMajorSeventhCard2Body =>
      'Compare Major seventh with Octave. Name the size first, then the color.';

  @override
  String get courseMajorSeventhCard3Title => 'Mini drill';

  @override
  String get courseMajorSeventhCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseTritoneTitle => 'Tritone';

  @override
  String get courseTritoneGoal => 'Recognize Tritone by its sound.';

  @override
  String get courseTritoneCard1Title => 'What to hear';

  @override
  String get courseTritoneCard1Body =>
      'Focus on the feeling: unstable, strange, split';

  @override
  String get courseTritoneCard2Title => 'Compare it';

  @override
  String get courseTritoneCard2Body =>
      'Compare Tritone with Perfect fifth. Name the size first, then the color.';

  @override
  String get courseTritoneCard3Title => 'Mini drill';

  @override
  String get courseTritoneCard3Body =>
      'Start with 5 questions using only this interval and its closest confusion. Then add it back to the normal exercise.';

  @override
  String get courseAscendingIntervalsTitle => 'Master ascending intervals';

  @override
  String get courseAscendingIntervalsGoal =>
      'Hear the distance when the melody goes upward.';

  @override
  String get courseAscendingIntervalsCard1Title => 'Concept';

  @override
  String get courseAscendingIntervalsCard1Body =>
      'The first note is the root. The second note tells you the interval size upward.';

  @override
  String get courseAscendingIntervalsCard2Title => 'Ear clue';

  @override
  String get courseAscendingIntervalsCard2Body =>
      'Sing the first note in your head, then feel how far the second note climbs.';

  @override
  String get courseAscendingIntervalsCard3Title => 'Mini drill';

  @override
  String get courseAscendingIntervalsCard3Body =>
      'Start with unison, octave, fifth, and thirds before adding seconds and sevenths.';

  @override
  String get courseDescendingIntervalsTitle => 'Master descending intervals';

  @override
  String get courseDescendingIntervalsGoal =>
      'Recognize the same distance when the melody falls.';

  @override
  String get courseDescendingIntervalsCard1Title => 'Concept';

  @override
  String get courseDescendingIntervalsCard1Body =>
      'The first note is high, then the sound falls to the root. The interval name is still the distance.';

  @override
  String get courseDescendingIntervalsCard2Title => 'Ear clue';

  @override
  String get courseDescendingIntervalsCard2Body =>
      'Do not answer “lower” automatically. Keep the first note in memory and measure the fall.';

  @override
  String get courseDescendingIntervalsCard3Title => 'Mini drill';

  @override
  String get courseDescendingIntervalsCard3Body =>
      'Practice the same interval ascending then descending until the distance feels identical.';

  @override
  String get courseHarmonicIntervalsTitle => 'Hear two notes together';

  @override
  String get courseHarmonicIntervalsGoal =>
      'Identify intervals when both notes sound at the same time.';

  @override
  String get courseHarmonicIntervalsCard1Title => 'Concept';

  @override
  String get courseHarmonicIntervalsCard1Body =>
      'Both notes arrive together, so you hear color more than melody.';

  @override
  String get courseHarmonicIntervalsCard2Title => 'Ear clue';

  @override
  String get courseHarmonicIntervalsCard2Body =>
      'Listen for stability and tension: calm, open, bright, dark, rubbing, unresolved.';

  @override
  String get courseHarmonicIntervalsCard3Title => 'Mini drill';

  @override
  String get courseHarmonicIntervalsCard3Body =>
      'After a wrong answer, replay the correct interval and name its color before moving on.';

  @override
  String get courseMixedIntervalsTitle => 'Mixed interval survival';

  @override
  String get courseMixedIntervalsGoal =>
      'Answer by distance, even when the direction changes every question.';

  @override
  String get courseMixedIntervalsCard1Title => 'Concept';

  @override
  String get courseMixedIntervalsCard1Body =>
      'Mixed mode removes the training wheels. Every question can change direction.';

  @override
  String get courseMixedIntervalsCard2Title => 'Ear clue';

  @override
  String get courseMixedIntervalsCard2Body =>
      'First identify direction, then distance. Do not let direction steal the answer.';

  @override
  String get courseMixedIntervalsCard3Title => 'Mini drill';

  @override
  String get courseMixedIntervalsCard3Body =>
      'Use easier intervals first, then unlock the full set when accuracy is stable.';

  @override
  String get courseMistakeReviewTitle => 'Turn mistakes into training';

  @override
  String get courseMistakeReviewGoal =>
      'Use the summary screen to attack your real weak spots.';

  @override
  String get courseMistakeReviewCard1Title => 'Concept';

  @override
  String get courseMistakeReviewCard1Body =>
      'A wrong answer is a clue. The confusion tells you which two sounds your ear merges.';

  @override
  String get courseMistakeReviewCard2Title => 'Ear clue';

  @override
  String get courseMistakeReviewCard2Body =>
      'Use “Review my mistakes” while the sound is still fresh in memory.';

  @override
  String get courseMistakeReviewCard3Title => 'Mini drill';

  @override
  String get courseMistakeReviewCard3Body =>
      'Train only the missed intervals for one short session, then return to mixed practice.';
}
