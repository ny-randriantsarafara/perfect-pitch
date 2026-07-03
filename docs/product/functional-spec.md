# Perfect Pitch Functional Spec

## Product Goal

Perfect Pitch is an interval-recognition trainer. The app plays a musical
interval, the learner answers with its name, and the app gives immediate
feedback. Practice is organized as an exercise catalogue so a learner can train
one direction at a time (ascending, descending, harmonic) or mix them together.

The product optimizes accuracy and confidence before speed. It should feel like
a focused ear-training instrument, not a quiz game that rewards guessing. The
app runs entirely on-device, without account creation, backend services, or
network-dependent learning features.

## Target Users

- Beginners who want to recognize intervals (unison through octave) by sound.
- Self-taught musicians who need short, repeatable practice sessions.
- Learners who want to practice offline without creating an account.

## Navigation

The app has four primary areas:

- **Home**: greeting, daily streak, quick access to a session, and a short
  progress overview.
- **Exercises**: the exercise catalogue, shared setup, and the active session
  and summary flow (the heart of the product).
- **Instrument**: the guitar fretboard drill, where the learner finds an
  interval on the neck. Advanced instrument expansion is out of scope for now.
- **Progress**: richer statistics derived from recorded attempts.

## Exercises

### Catalogue

The Exercises area opens on a catalogue of interval-recognition exercises. Each
card shows a description, the current mastery percentage, a difficulty, and a
button to start (or continue) the exercise.

The four interval-recognition exercises are:

- **Intervalles ascendants** — the interval is played low note then high note.
- **Intervalles descendants** — the interval is played high note then low note;
  unison is excluded because it has no audible direction.
- **Intervalles harmoniques** — both notes are played simultaneously.
- **Intervalles mixtes** — each question independently uses ascending,
  descending, or harmonic playback.

### Shared setup

Starting a card opens a shared setup screen. It shows simple controls first:

- difficulty;
- number of questions;
- instrument.

An advanced section exposes the full configuration:

- the set of intervals to practice;
- the allowed playback directions;
- the number of answer choices;
- the manual replay limit;
- the root octave range (minimum and maximum root MIDI);
- auto-play of the first playback;
- immediate feedback;
- whether the playback direction is shown before answering (useful in mixed
  easy mode).

Every exercise is driven by a single `ExerciseConfig`, so all four exercises
reuse the same session flow. Ascending is a first-class exercise; mixed mode
chooses the direction per question.

### Active session

During a session the app plays the interval, collects an answer, reveals the
result, then moves on. The session:

- plays the first interval automatically (this is not counted as a replay);
- starts the response timer only after the initial playback completes;
- counts manual replays separately;
- records skips as incorrect, skipped attempts;
- disables answer, skip, next, and replay actions while important audio plays;
- opens a summary after the final question instead of restarting.

When the answer is wrong, comparison playback helps the ear:

1. correct interval;
2. short pause;
3. chosen interval;
4. short pause;
5. correct interval.

The wrong-answer explanation shows the selected interval, the correct interval,
and the semitone difference between them.

### Summary

After the final question the app shows a summary:

- score;
- accuracy;
- average response time;
- number of manual replays;
- best streak;
- hardest interval;
- most common confusion;
- number of skipped questions.

Summary actions let the learner retry the mistakes, repeat the same session,
increase difficulty, or return to the catalogue.

## Difficulty Defaults

Difficulty controls the interval set, choice count, replay limit, and how much
help the UI offers:

- **Beginner**: a small interval set, generous choices, unlimited replays, no
  timer pressure, direction shown before answering in mixed mode.
- **Easy**: a slightly larger interval set with a few replays.
- **Medium**: most intervals, fewer replays.
- **Difficult**: all intervals, one replay, no pre-answer direction hint.
- **Custom**: free configuration of every session setting.

## Attempt Tracking

Every answered question is stored as an attempt that records:

- the exercise type;
- the expected interval;
- the selected interval (null when skipped);
- the playback direction;
- the instrument;
- whether it was correct, skipped, or hesitated;
- the manual replay count;
- the response time;
- when it occurred.

The repository keeps the existing aggregate correct/total mastery for the Home
and Progress screens, and persists enough attempt detail to derive:

- results by interval;
- results by direction;
- results by exercise type;
- common confusions (expected vs. selected);
- replay usage;
- skipped count;
- response-time averages.

## Audio Strategy

The app uses on-device synthesis so it works offline without audio asset
production. The audio layer exposes the same API for synthesized tones and for
future bundled samples. Harmonic intervals play both tones simultaneously;
ascending and descending intervals play the two tones in sequence.

## Randomization Rules

The question generator must avoid:

- repeating the exact same interval too often;
- repeating the same interval-and-direction pair immediately when alternatives
  exist (relevant to mixed mode);
- producing predictable sequences.

The generator uses recent-question memory and shuffled selection.

## Accessibility And Ergonomics

The app is mobile-first:

- large touch targets;
- simple layouts during exercises;
- high contrast and clear correct/incorrect states;
- dark mode by default;
- one-hand friendly primary actions;
- readable text and keyboard-friendly buttons;
- reduced reliance on animation for understanding.

All user-facing copy is in French.

## Explicit Non-Goals

The following are intentionally out of scope for this direction:

- backend services;
- user accounts and authentication;
- remote database storage or cloud synchronization;
- public profiles or leaderboards;
- microphone-based pitch scoring or singing evaluation;
- absolute-note (single-note) recognition training;
- advanced guitar and piano expansion, comparison drills, and melodic dictation.
