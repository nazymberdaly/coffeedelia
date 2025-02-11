import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeResource extends Mock implements CoffeeResource {}

void main() {
  group('CoffeeBloc', () {
    late CoffeeResource coffeeResource;

    setUp(() {
      coffeeResource = MockCoffeeResource();
    });

    test('initial state is CoffeeBloc.initial', () {
      final bloc = CoffeeBloc(
        coffeeResource: coffeeResource,
      );
      expect(bloc.state, equals(const CoffeeInitial()));
    });

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [CoffeeLoading, CoffeeLoaded] when LoadCoffeeImage is '
      'added and succeeds',
      build: () {
        when(() => coffeeResource.fetchRandomCoffee()).thenAnswer(
          (_) async =>
              const Coffee(id: 1, imageUrl: 'https://example.com/coffee.jpg'),
        );
        return CoffeeBloc(coffeeResource: coffeeResource);
      },
      act: (bloc) => bloc.add(const LoadCoffeeImage()),
      expect: () => [
        const CoffeeLoading(),
        isA<CoffeeLoaded>().having(
          (state) => state.coffee.imageUrl,
          'imageUrl',
          'https://example.com/coffee.jpg',
        ),
      ],
    );

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [CoffeeLoading, CoffeeError] when LoadCoffeeImage fails due '
      'to network error',
      build: () {
        when(() => coffeeResource.fetchRandomCoffee())
            .thenThrow(NetworkException('No Internet'));
        return CoffeeBloc(coffeeResource: coffeeResource);
      },
      act: (bloc) => bloc.add(const LoadCoffeeImage()),
      expect: () => [
        const CoffeeLoading(),
        isA<CoffeeError>().having(
          (state) => state.errorType,
          'errorType',
          CoffeeErrorType.network,
        ),
      ],
    );

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [CoffeeLoading, CoffeeError] when LoadCoffeeImage fails '
      'due to server error',
      build: () {
        when(() => coffeeResource.fetchRandomCoffee()).thenThrow(
          ServerException('Server error'),
        );
        return CoffeeBloc(coffeeResource: coffeeResource);
      },
      act: (bloc) => bloc.add(const LoadCoffeeImage()),
      expect: () => [
        const CoffeeLoading(),
        isA<CoffeeError>().having(
          (state) => state.errorType,
          'errorType',
          CoffeeErrorType.server,
        ),
      ],
    );

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [CoffeeLoading, CoffeeError] when LoadCoffeeImage fails due '
      'to unknown error',
      build: () {
        when(() => coffeeResource.fetchRandomCoffee())
            .thenThrow(Exception('Unknown error'));
        return CoffeeBloc(coffeeResource: coffeeResource);
      },
      act: (bloc) => bloc.add(const LoadCoffeeImage()),
      expect: () => [
        const CoffeeLoading(),
        isA<CoffeeError>().having(
          (state) => state.errorType,
          'errorType',
          CoffeeErrorType.unknown,
        ),
      ],
    );
  });
}
