# Flutter Boilerplate Project

A robust, multi-platform Flutter boilerplate to kickstart your next project with best practices, scalable architecture, and ready-to-use features.

## Features
- BLOC state management
- Networking with Dio
- Light/Dark theme toggle
- Localization (l10n) ready
- Service locator pattern
- Basic widget testing
- GitHub Actions CI for build/test  
- Firebase notification code 


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

## Networking
- Uses [Dio](https://pub.dev/packages/dio) for HTTP requests.

## Theming
- Light and dark themes are supported.
- Toggle theme from the app UI.

## Localization
- Add translations in `lib/l10n/` using ARB files.

## Testing
- Example widget test in `test/widget_test.dart`.

## Continuous Integration
- GitHub Actions workflow for build and test included in `.github/workflows/`.

## Firebase Notification  
 - To add notifications in your project uncommment firebase notification initialization code from main file
 - In firebase notifications class uncomment options and use yours from google.gson file
 - Add google.json from firebase


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



