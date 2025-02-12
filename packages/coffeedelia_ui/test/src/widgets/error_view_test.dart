import 'package:coffeedelia_ui/coffeedelia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorView Widget Tests', () {
    testWidgets('displays title and warning icon', (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorView(title: errorMessage),
          ),
        ),
      );

      // Verify icon is present
      expect(find.byIcon(Icons.warning_rounded), findsOneWidget);

      // Verify text is displayed
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('displays retry button when buttonTitle is provided',
        (WidgetTester tester) async {
      const errorMessage = 'An error occurred';
      const retryButtonTitle = 'Retry';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorView(
              title: errorMessage,
              buttonTitle: retryButtonTitle,
            ),
          ),
        ),
      );

      expect(find.text(retryButtonTitle), findsOneWidget);
    });

    testWidgets('calls onPressed callback when button is tapped',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorView(
              title: 'Error',
              buttonTitle: 'Retry',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Retry'));

      await tester.pumpAndSettle();

      // Verify the callback was triggered
      expect(wasPressed, isTrue);
    });

    testWidgets('does not show button if buttonTitle is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorView(title: 'Error'),
          ),
        ),
      );

      // Verify no button exists
      expect(find.byType(OutlinedButton), findsNothing);
    });
  });
}
