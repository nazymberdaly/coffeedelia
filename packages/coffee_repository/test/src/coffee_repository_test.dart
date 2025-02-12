// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:coffee_repository/coffee_repository.dart';
import 'package:db_client/db_client.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// void main() {
//   group('CoffeeRepository', () {
//     test('can be instantiated', () {
//       expect(CoffeeRepository(), isNotNull);
//     });
//   });
// }

class MockDbClient extends Mock implements DbClient {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CoffeeRepository coffeeRepository;
  late MockDbClient mockDbClient;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockDbClient = MockDbClient();
    mockHttpClient = MockHttpClient();
    coffeeRepository = CoffeeRepository(dbClient: mockDbClient);
  });

  group('CoffeeRepository', () {
    test('addCoffee stores image and inserts entry into database', () async {
      const testUrl = 'https://example.com/coffee.jpg';
      final fakeBytes = List<int>.filled(10, 0);
      final fakeResponse = http.Response.bytes(fakeBytes, 200);

      when(() => mockHttpClient.get(Uri.parse(testUrl)))
          .thenAnswer((_) async => fakeResponse);
      when(() => mockDbClient.insertCoffee(any()))
          .thenAnswer((_) async {});

      await coffeeRepository.addCoffee(testUrl);

      verify(() => mockHttpClient.get(Uri.parse(testUrl))).called(1);
      verify(() => mockDbClient.insertCoffee(any())).called(1);
    });

    test('getFavoriteCoffees returns a list of stored coffees', () async {
      final fakeCoffees = [
        CoffeeEntity(id: 1, imagePath: '/path/to/coffee1.jpg'),
        CoffeeEntity(id: 2, imagePath: '/path/to/coffee2.jpg'),
      ];

      when(() => mockDbClient.getCoffees())
          .thenAnswer((_) async => fakeCoffees);

      final result = await coffeeRepository.getFavoriteCoffees();

      expect(result, equals(fakeCoffees));
      verify(() => mockDbClient.getCoffees()).called(1);
    });

    test('removeCoffee deletes coffee from database and local storage', () async {
      final testCoffee = CoffeeEntity(id: 1, imagePath: '/path/to/coffee.jpg');

      when(() => mockDbClient.getCoffee(1))
          .thenAnswer((_) async => testCoffee);
      when(() => mockDbClient.deleteCoffee(1))
          .thenAnswer((_) async {return 1;});

      final file = File(testCoffee.imagePath);
      await file.create();
      await coffeeRepository.removeCoffee(1);

      verify(() => mockDbClient.getCoffee(1)).called(1);
      verify(() => mockDbClient.deleteCoffee(1)).called(1);
      expect(await file.exists(), isFalse);
    });

    test('getCoffee returns a single coffee entity', () async {
      final testCoffee = CoffeeEntity(id: 1, imagePath: '/path/to/coffee.jpg');

      when(() => mockDbClient.getCoffee(1))
          .thenAnswer((_) async => testCoffee);

      final result = await coffeeRepository.getCoffee(1);

      expect(result, equals(testCoffee));
      verify(() => mockDbClient.getCoffee(1)).called(1);
    });
  });
}
