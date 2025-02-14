import 'package:bloc/bloc.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:db_client/db_client.dart';
import 'package:equatable/equatable.dart';

part 'favorite_coffee_state.dart';
part 'favorite_coffee_event.dart';

/// A Bloc that manages favorite coffee operations, including loading,
/// adding, and removing favorite coffees.
class FavoriteCoffeesBloc
    extends Bloc<FavoriteCoffeesEvent, FavoriteCoffeesState> {
  FavoriteCoffeesBloc({required CoffeeRepository coffeeRepository})
      : _coffeeRepository = coffeeRepository,
        super(FavoriteCoffeesLoading()) {
    on<AddFavoriteCoffee>(_onAddFavoriteCoffee);
    on<LoadFavoriteCoffees>(_onLoadFavoriteCoffees);
    on<RemoveFavoriteCoffee>(_onRemoveFavoriteCoffee);
  }

  /// The repository handling favorite coffee storage and retrieval.
  final CoffeeRepository _coffeeRepository;


  /// Handles the [AddFavoriteCoffee] event by adding a coffee to the repository.
  Future<void> _onAddFavoriteCoffee(
    AddFavoriteCoffee event,
    Emitter<FavoriteCoffeesState> emit,
  ) async {
    try {
      await _coffeeRepository
          .addCoffee(event.coffee.imageUrl); // Use the CoffeeService
      add(LoadFavoriteCoffees()); // Reload after adding
    } catch (e) {
      emit(FavoriteCoffeesError(message: e.toString()));
    }
  }
 
  /// Handles the [LoadFavoriteCoffees] event by fetching the list of 
  /// favorite coffees
  Future<void> _onLoadFavoriteCoffees(
    LoadFavoriteCoffees event,
    Emitter<FavoriteCoffeesState> emit,
  ) async {
    emit(FavoriteCoffeesLoading());
    try {
      final coffees = await _coffeeRepository.getFavoriteCoffees();

      if (coffees.isEmpty) {
        emit(FavoriteCoffeesEmpty()); // Emit empty state if no favorites
      } else {
        emit(
          FavoriteCoffeesLoaded(
            coffees: coffees.map((entity) => entity.toDomain()).toList(),
          ),
        );
      }
    } on DbClientException catch (error) {
      emit(FavoriteCoffeesError(message: error.cause));
    } catch (e) {
      emit(FavoriteCoffeesError(message: e.toString()));
    }
  }

  /// Handles the [RemoveFavoriteCoffee] event by removing a coffee
  ///  from the repository
  Future<void> _onRemoveFavoriteCoffee(
    RemoveFavoriteCoffee event,
    Emitter<FavoriteCoffeesState> emit,
  ) async {
    try {
      await _coffeeRepository.removeCoffee(event.id);
      add(LoadFavoriteCoffees());
    } catch (e) {
      emit(FavoriteCoffeesError(message: e.toString()));
    }
  }
}
