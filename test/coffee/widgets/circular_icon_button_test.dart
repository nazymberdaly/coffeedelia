import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CircularIconButton', () {
    testWidgets('renders correctly with given icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularIconButton(
              icon: Icons.add,
              onTap: () {},
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('triggers onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularIconButton(
              icon: Icons.add,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.byType(CircularIconButton));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });
  });
}
