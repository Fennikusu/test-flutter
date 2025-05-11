# Restaurant App

Flutter test project for JDC company - Restaurant order management application.

## Overview

A mobile application that displays restaurant orders and table details.

## Architecture

- **MVVM Pattern** with Flutter Riverpod
- **Dependencies**: 
  - `flutter_riverpod` - State management
  - `dio` - HTTP client for API calls

## Project Structure

```
lib/
├── models/          # Data models
├── providers/       # Riverpod state management
├── services/        # API integration
├── theme/          # App theming
├── viewmodels/     # Business logic
├── views/          # UI screens
└── widgets/        # Reusable components
```

## Data Source

Fetches restaurant data from:
```
https://raw.githubusercontent.com/popina/test-flutter/main/data.json
```

## How to Run

```bash
flutter pub get
flutter run
flutter test
```

## Notes

- Comments have been automatically generated
- Time display shows static value (18:20) as API doesn't provide timestamps
- Test project for JDC company
