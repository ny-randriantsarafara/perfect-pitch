# Perfect Pitch Web

Flutter Web app for learning to recognize isolated musical notes by ear.

The app is local-first: no account, no authentication, no backend, and no cloud sync. The MVP focuses on natural notes, learn mode, free training, a guided path starter, local session statistics, and browser-local audio synthesis.

## Product Notes

- Functional spec: `docs/product/functional-spec.md`
- Audio strategy: synth playback now, `assets/audio/` sample support later
- Storage strategy: `shared_preferences` on the browser/device
- Main platform target: Flutter Web

## Development

Run the app:

```bash
flutter run -d chrome
```

Validate locally:

```bash
dart format lib test
flutter analyze
flutter test
flutter build web
```
