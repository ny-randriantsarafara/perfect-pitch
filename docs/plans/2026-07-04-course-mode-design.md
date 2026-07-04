# Course Mode Design

Date: 2026-07-04

## Status

Approved working design. Keep this document in `docs/plans/` during
implementation. After implementation, either promote the durable product
decisions into `docs/product/functional-spec.md` or delete this file if it no
longer adds value.

## Scope

Add a first-class Learn area for short ear-training micro-courses. V1 uses the
provided course content as the source for 21 runtime courses:

- foundation courses;
- interval courses;
- exercise-direction courses;
- mistake-review strategy course.

`course_guitar_intervals` is explicitly deferred from v1. The Guitar tab remains
outside course mode until there is a dedicated bridge between course lessons and
the guitar controller.

## Product Shape

The Learn area is a separate feature area, not a lesson stage embedded inside
the existing Exercises flow. It should feel like part of the app's core
navigation: a learner opens Learn, picks the next short course, reads/listens
through up to three cards, then starts a focused drill that reuses the existing
exercise engine.

Recommended navigation is a fifth tab: Home, Exercises, Learn, Guitar, Progress.
This makes the course system visible and avoids hiding learning behind exercise
setup screens.

## Architecture

Add course-specific core and feature layers:

```text
lib/core/courses/course.dart
lib/core/courses/course_catalog.dart
lib/core/courses/course_progress.dart
lib/core/courses/course_progress_repository.dart
lib/features/courses/course_controller.dart
lib/features/courses/course_tab.dart
lib/features/courses/course_lesson_view.dart
```

`AppController` owns `CourseController` alongside `PracticeController` and
`GuitarController`. `CourseController` owns course state: selected course,
current lesson card index, completion state, and the current recommendation.
`PracticeController` remains responsible for exercise setup, active sessions,
and summaries.

When a learner starts a drill from a course, the course feature builds the
appropriate `ExerciseConfig` and hands it to the existing practice flow through
`AppController`. No second exercise engine should be created.

## Data Model

Use typed Dart metadata for runtime course structure:

- stable course ID;
- version;
- order;
- kind;
- stage;
- linked exercise types;
- linked intervals;
- estimated seconds;
- step IDs and step types.

Course text should not be hardcoded in Dart. Use course and step IDs to resolve
localized strings from `AppLocalizations`.

Course kinds:

```text
foundation
interval
exercise
strategy
```

Course step types:

```text
concept
earClue
listenDemo
compareDemo
miniDrill
```

The downloaded `course-content-v1.json` is a source artifact for populating ARB
copy and validating catalogue metadata. The app should not parse that file at
runtime.

## UX Flow

The Learn tab opens to a course path:

- recommended course card first;
- foundation courses;
- interval courses in progression order;
- exercise-direction courses;
- strategy course.

Each course card shows title, goal, estimated time, linked exercise, and a small
completion check when finished.

The lesson screen shows at most three cards from the content source. It supports
previous/next navigation, optional demo playback for interval courses, completion,
and starting the linked drill.

The Exercises catalogue may add small "Learn first" or "Review lesson" chips,
but those chips should navigate to the Learn feature instead of opening lessons
inside `PracticeController`.

## Drill Configuration

Starting a lesson drill creates a focused `ExerciseConfig`:

- Foundation: ascending intervals, stage 1 intervals, 5 questions, unlimited
  replay.
- Interval: current exercise context when available, target interval plus a
  nearby confusion interval, 5 questions, 3 choices, unlimited replay.
- Exercise direction: matching exercise type, current unlocked stage, 8
  questions, 4 choices.
- Mixed: mixed exercise, stage no higher than current user progress, direction
  hint enabled for first run.
- Mistake review: reuse the existing retry-mistakes concept after the strategy
  lesson.

Keep the existing descending-unison guard: if a descending-only drill would only
use unison, switch to ascending or harmonic so the drill remains audible.

## Persistence

Course progress is local-first through `shared_preferences`, with an in-memory
repository for tests.

Persist:

```text
courses.completedIds
courses.lastSeenVersion.<courseId>
```

Completion is separate from interval mastery. It should appear as a small course
checkmark, not as another mastery score.

## Error Handling

Catalogue validity problems should fail tests rather than be silently tolerated:

- missing localized copy;
- invalid course ID;
- invalid exercise reference;
- invalid interval reference;
- empty implemented catalogue.

At runtime, optional demo playback should be defensive. If a lesson card has no
demo interval or playback fails, hide or disable the play action and keep the
lesson readable.

## Testing

Add focused tests for:

- 21 v1 courses exist in stable order;
- `course_guitar_intervals` is not in the runtime v1 catalogue;
- every course has valid kind, stage, exercise type, and interval references;
- every course has localized copy for EN, FR, ES, DE, IT, and PT;
- opening Learn shows the recommended first course;
- selecting a course opens its lesson and supports previous/next navigation;
- completing a course persists completion locally;
- starting a course drill hands the expected `ExerciseConfig` to practice;
- existing practice, controller, and localization tests still pass.

## Durable Documentation Candidates

Promote these decisions to permanent product documentation if they remain true
after implementation:

- Learn is a separate top-level feature area.
- V1 includes 21 interval-exercise courses and defers guitar courses.
- Course completion is local-only and separate from mastery.
- Course copy is ARB-localized and runtime course structure is typed Dart data.
- Course drills reuse the existing `ExerciseConfig` and `PracticeController`
  session engine.
