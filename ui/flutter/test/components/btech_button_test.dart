import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btech_ui/btech_ui.dart';

void main() {
  group('BtechButton', () {
    testWidgets('renders with label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Click me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Click me'), findsOneWidget);
    });

    testWidgets('renders primary variant by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Primary',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders secondary variant as OutlinedButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Secondary',
              onPressed: () {},
              variant: BtechButtonVariant.secondary,
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('renders ghost variant as TextButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Ghost',
              onPressed: () {},
              variant: BtechButtonVariant.ghost,
            ),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Tap me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Disabled',
              onPressed: () => pressed = true,
              disabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      expect(pressed, isFalse);
    });

    testWidgets('renders custom child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BtechButton(
              label: 'Fallback',
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text('Custom'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
