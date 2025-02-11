// ignore_for_file: prefer_const_constructors
import 'package:coffee_domain/coffee_domain.dart';
import 'package:test/test.dart';

void main() {
  group('CoffeeDomain', () {
    test('can be instantiated', () {
      expect(Coffee(id: '', imageUrl: ''), isNotNull);
    });
  });
}
