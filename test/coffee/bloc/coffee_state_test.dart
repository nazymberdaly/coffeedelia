import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeState', () {
    test('supports value equality for CoffeeInitial', () {
      expect(const CoffeeInitial(), equals(const CoffeeInitial()));
    });

    test('supports value equality for CoffeeLoading', () {
      expect(const CoffeeLoading(), equals(const CoffeeLoading()));
    });

    test('supports value equality for CoffeeLoaded', () {
      const coffee1 =
          Coffee(id: 1, imageUrl: 'https://example.com/coffee1.jpg');
      const coffee2 =
          Coffee(id: 1, imageUrl: 'https://example.com/coffee1.jpg');

      expect(const CoffeeLoaded(coffee: coffee1),
          equals(const CoffeeLoaded(coffee: coffee2)));
    });

    test('supports value equality for CoffeeError', () {
      expect(
        const CoffeeError(
          error: 'Network Error',
          errorType: CoffeeErrorType.network,
        ),
        equals(
          const CoffeeError(
            error: 'Network Error',
            errorType: CoffeeErrorType.network,
          ),
        ),
      );
    });
  });
}
