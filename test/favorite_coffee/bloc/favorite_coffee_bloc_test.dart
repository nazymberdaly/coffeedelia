import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffeedelia/favorite_coffee/favorite_coffee.dart';
import 'package:db_client/db_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepository coffeeRepository;
  late FavoriteCoffeesBloc bloc;

  setUp(() {
    coffeeRepository = MockCoffeeRepository();
    bloc = FavoriteCoffeesBloc(coffeeRepository: coffeeRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('FavoriteCoffeesBloc', () {
    test('initial state is FavoriteCoffeesLoading', () {
      expect(bloc.state, equals(FavoriteCoffeesLoading()));
    });

    blocTest<FavoriteCoffeesBloc, FavoriteCoffeesState>(
      'emits [FavoriteCoffeesLoading, FavoriteCoffeesLoaded] when '
      'LoadFavoriteCoffees is added',
      build: () {
        when(() => coffeeRepository.getFavoriteCoffees()).thenAnswer(
          (_) async => [
            CoffeeEntity(id: 1, imagePath: 'https://example.com/espresso.jpg')
          ],
        );
        return bloc;
      },
      act: (bloc) => bloc.add(LoadFavoriteCoffees()),
      expect: () => [
        FavoriteCoffeesLoading(),
        FavoriteCoffeesLoaded(
          coffees: const [
            Coffee(id: 1, imageUrl: 'https://example.com/espresso.jpg'),
          ],
        ),
      ],
    );

    blocTest<FavoriteCoffeesBloc, FavoriteCoffeesState>(
      'emits [FavoriteCoffeesLoading, FavoriteCoffeesEmpty] when no favorite '
      'coffees are found',
      build: () {
        when(() => coffeeRepository.getFavoriteCoffees())
            .thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadFavoriteCoffees()),
      expect: () => [
        FavoriteCoffeesLoading(),
        FavoriteCoffeesEmpty(),
      ],
    );

    blocTest<FavoriteCoffeesBloc, FavoriteCoffeesState>(
      'emits [FavoriteCoffeesError] when LoadFavoriteCoffees fails',
      build: () {
        when(() => coffeeRepository.getFavoriteCoffees())
            .thenThrow(Exception('Database error'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadFavoriteCoffees()),
      expect: () => [
        FavoriteCoffeesLoading(),
        FavoriteCoffeesError(message: 'Exception: Database error'),
      ],
    );

    blocTest<FavoriteCoffeesBloc, FavoriteCoffeesState>(
      'emits [FavoriteCoffeesLoading, FavoriteCoffeesLoaded] after '
      'adding a coffee',
      build: () {
        when(() => coffeeRepository.addCoffee(any())).thenAnswer((_) async {});
        when(() => coffeeRepository.getFavoriteCoffees()).thenAnswer(
          (_) async =>
              [CoffeeEntity(id: 1, imagePath: 'https://example.com/latte.jpg')],
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        AddFavoriteCoffee(
          coffee:
              const Coffee(id: 1, imageUrl: 'https://example.com/latte.jpg'),
        ),
      ),
      expect: () => [
        FavoriteCoffeesLoading(),
        FavoriteCoffeesLoaded(
          coffees: const [
            Coffee(id: 1, imageUrl: 'https://example.com/latte.jpg')
          ],
        ),
      ],
    );

    blocTest<FavoriteCoffeesBloc, FavoriteCoffeesState>(
      'emits [FavoriteCoffeesError] when adding a coffee fails',
      build: () {
        when(() => coffeeRepository.addCoffee(any()))
            .thenThrow(Exception('Failed to add coffee'));
        return bloc;
      },
      act: (bloc) => bloc.add(
        AddFavoriteCoffee(
          coffee:
              const Coffee(id: 1, imageUrl: 'https://example.com/latte.jpg'),
        ),
      ),
      expect: () => [
        FavoriteCoffeesError(message: 'Exception: Failed to add coffee'),
      ],
    );

    blocTest<FavoriteCoffeesBloc, FavoriteCoffeesState>(
      'emits [FavoriteCoffeesLoading, FavoriteCoffeesLoaded] after '
      'removing a coffee',
      build: () {
        when(() => coffeeRepository.removeCoffee(any())).thenAnswer(
          (_) async {},
        );
        when(() => coffeeRepository.getFavoriteCoffees()).thenAnswer(
          (_) async => [],
        );
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveFavoriteCoffee(id: 1)),
      expect: () => [
        FavoriteCoffeesLoading(),
        FavoriteCoffeesEmpty(),
      ],
    );
  });
}
