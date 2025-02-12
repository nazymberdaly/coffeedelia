// ignore_for_file: prefer_const_constructors
import 'package:coffee_domain/coffee_domain.dart';
import 'package:test/test.dart';

void main() {
  group('CoffeeDomain', () {
    test('supports value equality', () {
      final coffee1 = Coffee(imageUrl: 'https://example.com/coffee1.jpg', id: 1);
      final coffee2 = Coffee(imageUrl: 'https://example.com/coffee1.jpg', id: 1);
      final coffee3 = Coffee(imageUrl: 'https://example.com/coffee2.jpg', id: 2);

      expect(coffee1, equals(coffee2));
      expect(coffee1, isNot(equals(coffee3)));
    });

    test('fromJson creates correct Coffee object', () {
      final json = {'file': 'https://example.com/coffee1.jpg'};
      final coffee = Coffee.fromJson(json);

      expect(coffee.imageUrl, equals('https://example.com/coffee1.jpg'));
      expect(coffee.id, isNull);
    });

    test('props contains correct values', () {
      final coffee = Coffee(imageUrl: 'https://example.com/coffee1.jpg', id: 1);

      expect(coffee.props, equals([1, 'https://example.com/coffee1.jpg']));
    });
  });
}
