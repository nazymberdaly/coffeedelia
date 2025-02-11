import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SwipeBackground', () {
    testWidgets('renders correctly with provided values',
        (WidgetTester tester) async {
      const alignment = Alignment.centerLeft;
      const color = Colors.red;
      const icon = Icons.delete;

      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeBackground(
            alignment: alignment,
            color: color,
            icon: icon,
          ),
        ),
      );

      // Verify alignment
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
      final container = tester.widget<Container>(containerFinder);
      expect(container.alignment, alignment);

      // Verify Icon
      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon, icon);
      expect(iconWidget.color, Colors.white);
      expect(iconWidget.size, 40.0);

      // Verify BoxDecoration
      final decoratedBoxFinder = find.byType(DecoratedBox);
      expect(decoratedBoxFinder, findsOneWidget);
      final decoratedBox = tester.widget<DecoratedBox>(decoratedBoxFinder);
      final decoration = decoratedBox.decoration as BoxDecoration; // Safe cast
      expect(decoration.color, color);
      expect(decoration.borderRadius, BorderRadius.circular(20));
    });

    testWidgets('default values work', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeBackground(
            alignment: Alignment.center,
            color: Colors.blue,
            icon: Icons.add,
          ),
        ),
      );

      expect(find.byType(SwipeBackground), findsOneWidget);
    });
    testWidgets('Correct padding applied', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeBackground(
            alignment: Alignment.center,
            color: Colors.blue,
            icon: Icons.add,
          ),
        ),
      );

      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);
      final padding = tester.widget<Padding>(paddingFinder);
      expect(padding.padding, const EdgeInsets.symmetric(horizontal: 20));
      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.icon, Icons.add);
    });
  });
}
