import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadCoffeeImage', () {
    group('$LoadCoffeeImage', () {
      test('can be instantiated', () {
        expect(
          const LoadCoffeeImage(),
          isA<LoadCoffeeImage>(),
        );
      });

      test('supports value comparisons', () {
        expect(
          const LoadCoffeeImage(),
          equals(const LoadCoffeeImage()),
        );
      });
    });
  });
}