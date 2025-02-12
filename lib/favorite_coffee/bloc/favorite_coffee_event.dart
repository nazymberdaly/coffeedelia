part of 'favorite_coffee_bloc.dart';

/// The base class for all favorite coffee events.
abstract class FavoriteCoffeesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event to load the list of favorite coffees.
class LoadFavoriteCoffees extends FavoriteCoffeesEvent {}


/// Event to remove a coffee from the favorites list.
class RemoveFavoriteCoffee extends FavoriteCoffeesEvent {
  /// Creates a [RemoveFavoriteCoffee] event with the given coffee [id].
  RemoveFavoriteCoffee({required this.id});

  /// The unique identifier of the coffee to be removed.
  final int id;

  @override
  List<Object?> get props => [id];
}


/// Event to add a coffee to the favorites list.
class AddFavoriteCoffee extends FavoriteCoffeesEvent {
  /// Creates an [AddFavoriteCoffee] event with the given [coffee] object.
  AddFavoriteCoffee({required this.coffee});

  /// The coffee object to be added to favorites.
  final Coffee coffee;

  @override
  List<Object?> get props => [coffee];
}
