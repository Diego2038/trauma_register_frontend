# trauma_register_frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### To see all unit tests:
flutter test .\test\

### To see a determinate group of unit tests (for example):
flutter test .\test\data\models\custom\time_of_day_test.dart

### To see coverage of unit tests:
npm install -g lcov-summary
flutter test --coverage
lcov-summary coverage/lcov.info // Para ver el resultado en la terminal

### Note: You can install test coverage calculation, for example:
flutter test .\test\core\ --coverage
lcov-summary coverage/lcov.info

