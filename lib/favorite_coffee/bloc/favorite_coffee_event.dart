part of 'favorite_coffee_bloc.dart';

abstract class FavoriteCoffeesEvent {}

class LoadFavoriteCoffees extends FavoriteCoffeesEvent {}

class RemoveFavoriteCoffee extends FavoriteCoffeesEvent {
  RemoveFavoriteCoffee({required this.id});
  final int id;
}

class AddFavoriteCoffee extends FavoriteCoffeesEvent { // Add CoffeeDomain object
  AddFavoriteCoffee({required this.coffee});
  final Coffee coffee;
}
