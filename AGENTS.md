# AGENTS.md

Quick guide for AI agents working in this repository.

## Project

This is a Flutter mobile app for calculating billiard table rental cost based on elapsed time.

The app is presented in the README as **Billiard Time / Billiard Calculator**, and the visible title in the app is currently `CALCULADORA BILLAR`.

Important note: `la_central_del_norte` appears in `pubspec.yaml` as the Dart package name used by imports. Do not treat it as the product/app name unless the user explicitly confirms that.

## What The App Does

The app helps calculate a billiard table charge from:

- price per hour,
- start time,
- end time,
- calculated duration,
- total amount in `Bs.`.

It also supports sessions that cross midnight. If the end time is earlier than the start time, the app treats the end time as happening on the next day.

## Important Structure

- `lib/main.dart`: app entry point and global `MaterialApp` theme setup.
- `lib/screens/home_screen.dart`: main screen, field state, and UI/controller coordination.
- `lib/controllers/calculator_controller.dart`: pure duration and cost calculation logic.
- `lib/widgets/input_section.dart`: price, start time, and end time inputs.
- `lib/widgets/summary_section.dart`: visual billing summary.
- `lib/core/app_constants.dart`: shared text, defaults, and theme constants.
- `lib/theme/app_colors.dart`: centralized color palette.
- `assets/app_icon.png`: main icon declared in `pubspec.yaml`.
- `test/`: widget and controller tests.

## Useful Commands

Run from the project root:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```

If `assets/app_icon.png` changes, regenerate launcher icons with:

```powershell
dart run flutter_launcher_icons
```

## Coding Conventions

- Keep calculation behavior in `CalculatorController` when possible.
- Keep UI split into small widgets under `lib/widgets`.
- Use `AppConstants` for shared text and default values.
- Use `AppColors` for shared colors.
- Avoid duplicating important strings, colors, or default values across widgets.
- This project uses `flutter_lints`; run `flutter analyze` before finishing code changes.
- If calculation behavior changes, add or update tests in `test/calculator_controller_test.dart`.
- If the main visual structure changes, update or add widget tests in `test/widget_test.dart`.

## Key Functional Details

The central calculation API is:

```dart
CalculatorController.calculate({
  required TimeOfDay? startTime,
  required TimeOfDay? endTime,
  required String priceText,
})
```

Current rules:

- Returns `null` when start time, end time, or price is missing.
- Returns `null` when the price is not numeric.
- Calculates proportional cost by minutes: `minutes / 60 * pricePerHour`.
- Formats duration as `"X Horas Y min"`, `"Y min"`, or `"0 min"`.
- If `endTime` is before `startTime`, it adds one day to the end time.

## Product Notes

- The app is intended for quick use in billiard businesses or similar settings.
- The displayed currency is currently `Bs.`.
- The default hourly price is `20`.
- The current visible title is `CALCULADORA BILLAR`.
- Keep the interface simple, clear, and mobile-friendly.
- Most user-facing text in the app is currently Spanish. Confirm with the user before translating UI text or changing product naming.

## Avoid Unrelated Changes

- Do not modify generated folders such as `.dart_tool/` or `build/`.
- Do not change native platform folders such as `android/`, `ios/`, `linux/`, `macos/`, `web/`, or `windows/` unless the task requires it.
- Do not rename the package or project without checking import and platform impact.
- If the Git working tree already has changes from someone else, do not revert them.

## Before Finishing

1. Confirm the change compiles or at least passes static analysis.
2. Run relevant checks:

```powershell
flutter analyze
flutter test
```

3. Check that no generated or unrelated files were modified.
4. Tell the user what changed and which commands were run.
