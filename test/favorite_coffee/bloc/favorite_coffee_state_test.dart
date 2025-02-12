import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/favorite_coffee/favorite_coffee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteCoffeesState', () {
    test('FavoriteCoffeesLoading supports value comparison', () {
      expect(FavoriteCoffeesLoading(), equals(FavoriteCoffeesLoading()));
    });

    test('FavoriteCoffeesLoaded supports value comparison', () {
      final coffeeList = [
        const Coffee(id: 1, imageUrl: 'https://example.com/image.jpg')
      ];
      expect(FavoriteCoffeesLoaded(coffees: coffeeList),
          equals(FavoriteCoffeesLoaded(coffees: coffeeList)));
    });

    test('FavoriteCoffeesEmpty supports value comparison', () {
      expect(FavoriteCoffeesEmpty(), equals(FavoriteCoffeesEmpty()));
    });

    test('FavoriteCoffeesError supports value comparison', () {
      const errorMessage = 'Failed to load favorites';
      expect(FavoriteCoffeesError(message: errorMessage),
          equals(FavoriteCoffeesError(message: errorMessage)));
    });
  });
}
