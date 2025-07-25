# Flutter Boilerplate Project

A robust, multi-platform Flutter boilerplate to kickstart your next project with best practices, scalable architecture, and ready-to-use features.

## Features
- Multi-platform: Android, iOS, Web, Windows, macOS, Linux
- Feature-based folder structure
- BLOC state management
- Robust networking with Dio
- Light/Dark theme toggle
- Localization (l10n) ready
- Service locator pattern
- Basic widget testing
- GitHub Actions CI for build/test

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart
- Platform-specific requirements (Android Studio/Xcode, etc.)

### Setup
```bash
flutter pub get
flutter run
```

## Project Structure
```
lib/
  core/         # Config, routing, services, utils
  features/     # Feature modules (e.g., counter, auth, onboarding)
  l10n/         # Localization files
  shared/       # Shared widgets, styles, themes
  main_common.dart     # App entry point
```

## State Management
- Uses [BLOC](https://pub.dev/packages/provider) for scalable, reactive state management.
- See `features/counter/` for a sample implementation.

## Networking
- Uses [Dio](https://pub.dev/packages/dio) for HTTP requests.
- See `core/services/api_service.dart`.

## Theming
- Light and dark themes are supported.
- Toggle theme from the app UI.

## Localization
- Add translations in `lib/l10n/` using ARB files.
- Example usage in the sample feature.

## Testing
- Example widget test in `test/widget_test.dart`.

## Continuous Integration
- GitHub Actions workflow for build and test included in `.github/workflows/`.


## Running the App
- You can run the app with different configurations:
Test
  `flutter run -t lib/main_test.dart`.

Development
  `flutter run -t lib/main_development.dart`.

Production
  `flutter run -t lib/main_production.dart`. 


## Building the App
- You can run the app with different configurations:
Test
  `flutter build apk -t lib/main_test.dart`.

Development
  `flutter build apk -t lib/main_development.dart`.

Production
  `flutter build apk -t lib/main_production.dart`. 

# Firebase Notification  
 - To add notifications in your project uncommment firebase notification initialization code from main file
 - In firebase notifications class uncomment options and use yours from google.gson file
 - Add google.json from firebase

