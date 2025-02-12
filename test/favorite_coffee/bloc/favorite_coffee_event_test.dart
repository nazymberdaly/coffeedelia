import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/favorite_coffee/favorite_coffee.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('FavoriteCoffeesEvent', () {
    test('LoadFavoriteCoffees supports value comparison', () {
      expect(LoadFavoriteCoffees(), equals(LoadFavoriteCoffees()));
    });

    test('RemoveFavoriteCoffee supports value comparison', () {
      expect( RemoveFavoriteCoffee(id: 1), equals( RemoveFavoriteCoffee(id: 1)));
    });

    test('AddFavoriteCoffee supports value comparison', () {
      const coffee = Coffee(id: 1, imageUrl: 'https://example.com/image.jpg');
      expect( AddFavoriteCoffee(coffee: const Coffee(id: 1, imageUrl: 'https://example.com/image.jpg')),
          equals(AddFavoriteCoffee(coffee: coffee)));
    });
  });
}
