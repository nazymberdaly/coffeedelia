import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeCard', () {
    testWidgets('renders correctly', (tester) async {
      const coffee = Coffee(imageUrl: 'https://example.com/coffee.jpg');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CoffeeCard(
              coffee: coffee,
              onRefresh: () {},
              onFavoriteToggled: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ImageCard), findsOneWidget);
    });

    testWidgets('calls onRefresh when swiped left', (tester) async {
      var refreshed = false;
      const coffee = Coffee(imageUrl: 'https://example.com/coffee.jpg');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CoffeeCard(
              coffee: coffee,
              onRefresh: () => refreshed = true,
              onFavoriteToggled: (_) {},
            ),
          ),
        ),
      );

      await tester.fling(find.byType(Dismissible), const Offset(-500, 0), 500);
      await tester.pumpAndSettle();

      expect(refreshed, isTrue);
    });

    testWidgets('calls onFavoriteToggled when swiped right', (tester) async {
      var favoriteToggled = false;
      const coffee = Coffee(imageUrl: 'https://example.com/coffee.jpg');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CoffeeCard(
              coffee: coffee,
              onRefresh: () {},
              onFavoriteToggled: (_) => favoriteToggled = true,
            ),
          ),
        ),
      );

      await tester.fling(find.byType(Dismissible), const Offset(500, 0), 500);
      await tester.pumpAndSettle();

      expect(favoriteToggled, isTrue);
    });
  });
}
