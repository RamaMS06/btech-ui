# Flutter Component Rules (applies to: ui/flutter/)

- Dart 3.x with null safety
- Widget prefix: `Btech` (e.g., BtechButton, BtechInput)
- Use `AppTokens` class for all design values (never hardcode)
- Import: `import '../tokens/tokens.dart'`
- Prefer StatelessWidget; use StatefulWidget only when needed
- Use named parameters with required keyword
- File naming: snake_case (btech_button.dart)
- One public widget per file
- Token file (`tokens.dart`) is auto-generated; NEVER edit manually
- Use BtechTheme for theming (wraps ThemeData, uses AppTokens)
- Golden tests for visual regression: *_golden_test.dart per component
- Reference screenshots in test/goldens/
