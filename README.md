# FishCheck

FishCheck is a cross-platform fishing journal built with Flutter. It lets
anglers sign in to a demo account, log catches, review their fishing history,
and visualize saved catches on an interactive map.

> This repository is an MVP / portfolio project. Authentication and catch data
> currently use in-memory demo repositories, so they reset when the app closes.

## Highlights

- Clean, responsive Material 3 interface with light and dark themes
- Demo sign-in flow with form validation and loading/error states
- Interactive OpenStreetMap view with catch markers
- Catch journal organized as a list with species, location, and date
- Bottom-sheet flow for creating new catch records
- Feature-first project structure with clear domain, data, and presentation layers
- Repository interfaces separated from demo implementations
- State management with `flutter_bloc`

## Features

### Authentication

- Email and password validation
- Pre-filled demo credentials
- Cubit-driven authentication states
- Sign-out support

### Fishing journal

- Add a species, spot name, and optional note
- Review catches in a journal-style list
- View catch locations on a map
- Reset the map to the default fishing area

## Tech stack

| Area | Technology |
| --- | --- |
| Framework | Flutter / Dart |
| State management | Cubit with `flutter_bloc` |
| Maps | `flutter_map` and OpenStreetMap |
| Coordinates | `latlong2` |
| Location services | `geolocator` |
| Code update | Shorebird configuration |
| Testing | `flutter_test` |
| Linting | `flutter_lints` |

## Architecture

The project follows a feature-oriented structure. Authentication and catch
management are isolated into separate feature folders:

```text
lib/
├── core/
│   └── theme/                 # App colors and light/dark themes
├── features/
│   ├── auth/
│   │   ├── data/              # Demo authentication repository
│   │   ├── domain/            # User and repository contracts
│   │   └── presentation/      # Login UI and AuthCubit
│   └── catches/
│       ├── data/              # In-memory catch repository
│       ├── domain/            # Catch entity and repository contract
│       └── presentation/      # Map, journal, form, and CatchCubit
└── main.dart                  # Dependency setup and app entry point
```

This separation keeps UI state independent from data storage and makes it
straightforward to replace the demo repositories with Firebase, Supabase,
REST APIs, or local database implementations.

## Getting started

### Prerequisites

- Flutter SDK
- Dart SDK included with Flutter
- An Android, iOS, web, Windows, macOS, or Linux device/emulator

### Installation

```bash
git clone https://github.com/JoesdarianI/fish_check.git
cd fish_check
flutter pub get
```

### Run the app

```bash
flutter run
```

To check supported devices:

```bash
flutter devices
flutter run -d <device-id>
```

### Demo login

Use the credentials pre-filled on the sign-in screen:

```text
Email: angler@fishcheck.app
Password: fish123
```

## Testing

Run widget tests with:

```bash
flutter test
```

Run static analysis with:

```bash
flutter analyze
```

## Current limitations

- Authentication is simulated and not backed by a server
- Catches are stored only in memory
- New catch records use the app's demo coordinates
- Data and user sessions do not persist after closing the app
- The map requires an internet connection to load OpenStreetMap tiles

## Roadmap

- Persist catches and user sessions locally or in a database
- Add real authentication
- Request and store the user's actual GPS position
- Support catch photos and custom species details
- Add edit and delete actions
- Add filtering and catch statistics
- Add automated unit and integration tests

## Project status

Active portfolio MVP — suitable for demonstrating Flutter architecture,
state management, responsive UI, form handling, and map integration.

## Author

**JoesdarianI**

- GitHub: [@JoesdarianI](https://github.com/JoesdarianI)
