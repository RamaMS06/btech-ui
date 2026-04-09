import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btech_ui/btech_ui.dart';

void main() {
  group('BtechButton Golden Tests', () {
    testWidgets('primary variant - default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BtechTheme.light(),
          home: Scaffold(
            body: Center(
              child: BtechButton(
                label: 'Primary',
                onPressed: () {},
                variant: BtechButtonVariant.primary,
                size: BtechButtonSize.md,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(BtechButton),
        matchesGoldenFile('goldens/btech_button_primary.png'),
      );
    });

    testWidgets('secondary variant - default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BtechTheme.light(),
          home: Scaffold(
            body: Center(
              child: BtechButton(
                label: 'Secondary',
                onPressed: () {},
                variant: BtechButtonVariant.secondary,
                size: BtechButtonSize.md,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(BtechButton),
        matchesGoldenFile('goldens/btech_button_secondary.png'),
      );
    });

    testWidgets('ghost variant - default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BtechTheme.light(),
          home: Scaffold(
            body: Center(
              child: BtechButton(
                label: 'Ghost',
                onPressed: () {},
                variant: BtechButtonVariant.ghost,
                size: BtechButtonSize.md,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(BtechButton),
        matchesGoldenFile('goldens/btech_button_ghost.png'),
      );
    });

    testWidgets('primary variant - disabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BtechTheme.light(),
          home: Scaffold(
            body: Center(
              child: BtechButton(
                label: 'Disabled',
                onPressed: () {},
                variant: BtechButtonVariant.primary,
                disabled: true,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(BtechButton),
        matchesGoldenFile('goldens/btech_button_disabled.png'),
      );
    });

    testWidgets('all sizes - sm, md, lg', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BtechTheme.light(),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BtechButton(
                    label: 'Small',
                    onPressed: () {},
                    size: BtechButtonSize.sm,
                  ),
                  const SizedBox(height: 8),
                  BtechButton(
                    label: 'Medium',
                    onPressed: () {},
                    size: BtechButtonSize.md,
                  ),
                  const SizedBox(height: 8),
                  BtechButton(
                    label: 'Large',
                    onPressed: () {},
                    size: BtechButtonSize.lg,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(Column),
        matchesGoldenFile('goldens/btech_button_sizes.png'),
      );
    });

    testWidgets('primary variant - dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BtechTheme.dark(),
          home: Scaffold(
            body: Center(
              child: BtechButton(
                label: 'Dark Primary',
                onPressed: () {},
                variant: BtechButtonVariant.primary,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(BtechButton),
        matchesGoldenFile('goldens/btech_button_primary_dark.png'),
      );
    });
  });
}
