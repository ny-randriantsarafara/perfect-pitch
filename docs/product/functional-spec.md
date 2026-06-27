# Perfect Pitch Web Functional Spec

## Product Goal

Perfect Pitch Web helps beginners memorize isolated note colors by ear. The app plays one note, the learner answers with its note name, and the app gives immediate feedback. The first version runs entirely in the browser, without account creation, backend services, or network-dependent learning features.

The product optimizes accuracy and confidence before speed. It should feel like a focused ear-training instrument, not a quiz game that rewards guessing.

## Target Users

- Beginners who want to recognize Do, Re, Mi, Fa, Sol, La, and Si by sound.
- Self-taught musicians who need short, repeatable five-minute sessions.
- Learners who want to practice offline without creating an account.

## MVP Scope

The MVP must deliver the core learning loop:

- Learn mode for listening to each natural note with its solfege and international names.
- Free training mode with randomized natural notes, large answer buttons, instant feedback, response time, replay, and error comparison.
- Guided path with a small local progression: Do only, Do/Sol, Do/Sol/Mi, then all natural notes.
- Session setup with selected notes, octave count, question count, replay limit, and optional reference note.
- Local session stats: score, success rate, average response time, average replays, best streak, strongest note, weakest note, and main confusions.
- Local persistence for preferences, guided path progress, and aggregate note statistics.
- Offline-first audio using local synthesis, with an audio abstraction ready for bundled samples.

## Post-MVP Scope

The following features are designed but not required for the first usable web release:

- Bundled realistic samples for piano, clean electric guitar, acoustic guitar, sine tone, and synthesizer.
- Altered notes in training: Do sharp, Re flat, Re sharp, Mi flat, Fa sharp, Sol flat, Sol sharp, La flat, La sharp, and Si flat.
- Piano keyboard answer mode.
- Guitar fretboard answer mode.
- Advanced adaptive training based on long-term note difficulty, response latency, replay count, and recency.
- Local badges, levels, calendar streaks, and daily objectives.
- Web notifications where browser support and permission behavior are acceptable.
- Data export and import for manual backups.

## Explicit Non-Goals

- User accounts.
- Authentication.
- Remote database storage.
- Cloud synchronization.
- Public profile or leaderboard.
- Online restoration after uninstalling or clearing browser data.

## Learning Modes

### Learn Mode

Learn mode is scoreless. A learner can choose a note, replay it freely, see its solfege name, see its international name, change octave, switch synthetic timbre, sing before replaying, and move to the next note.

The mode also includes automatic playback in note order: Do, Re, Mi, Fa, Sol, La, Si. This playback is a discovery aid, not a test.

### Free Training

Free training plays one randomized note at a time. The learner answers with large buttons. After each answer, the app shows whether the answer was correct, the correct note, the chosen note, response time, replay count, and actions to replay the correct note, replay the chosen note, compare both sounds, or continue.

When the answer is wrong, comparison plays:

1. correct note;
2. short pause;
3. chosen note;
4. short pause;
5. correct note.

### Guided Path

The guided path keeps sessions short and progressive:

- Step 1: recognize Do.
- Step 2: distinguish Do and Sol.
- Step 3: add Mi.
- Step 4: add Re, Fa, La, and Si.
- Step 5: introduce more than one octave.
- Step 6: introduce variable instruments when samples are available.
- Step 7: reduce replay count and encourage quicker answers.

The MVP implements the first four steps and stores the current step locally.

## Session Configuration

Learners can configure:

- notes to practice;
- octave range;
- instrument mode;
- number of questions;
- maximum response time;
- replay limit;
- difficulty;
- answer display format;
- reference note behavior.

For MVP, the default setup is beginner-friendly: two notes, one octave, unlimited replays, no timer pressure, solfege labels, no reference note.

## Difficulty Defaults

- Beginner: two notes, one octave, unlimited replays, no timer pressure.
- Easy: three notes, one octave, three replays.
- Medium: five to seven natural notes, one or two octaves, two replays.
- Difficult: all natural notes, several octaves, one replay.
- Expert: natural and altered notes, several octaves, no replay button, fast response, random instrument.
- Custom: free configuration of all available session settings.

Only Beginner, Easy, Medium, and Custom need to be fully usable in the MVP.

## Audio Strategy

The app starts with browser-local synthesis so the MVP can work offline without audio asset production. The audio layer exposes the same API for both synthesized tones and future bundled samples.

The MVP instruments are:

- sine tone;
- warm synth tone.

Future bundled samples will live under `assets/audio/` and use the same domain concepts: note, octave, instrument, and duration.

## Randomization Rules

The question generator must avoid:

- repeating the exact same note too often;
- accidentally creating long ascending or descending scales;
- producing predictable sequences;
- reusing the same sequence across sessions.

The MVP uses recent-question memory and shuffled weighted selection. Later versions can add stronger adaptive weighting.

## Local Statistics

For each note, the app stores:

- number of times played;
- correct answer count;
- success rate;
- average response time;
- average replay count;
- frequent wrong answers.

Session summaries are derived from question outcomes and can be persisted when local history is enabled.

## Accessibility And Ergonomics

The web app must be mobile-first:

- large touch targets;
- simple layouts during exercises;
- high contrast;
- clear correct and incorrect states;
- optional sound replay;
- dark mode by default;
- one-hand friendly primary actions;
- readable text;
- keyboard-friendly buttons;
- reduced reliance on animation for understanding.

