part of 'favorite_coffee_bloc.dart';

abstract class FavoriteCoffeesState {}

class FavoriteCoffeesLoading extends FavoriteCoffeesState {}

class FavoriteCoffeesLoaded extends FavoriteCoffeesState {
  FavoriteCoffeesLoaded({required this.coffees});
  final List<Coffee> coffees;
}

class FavoriteCoffeesError extends FavoriteCoffeesState {
  FavoriteCoffeesError({required this.message});
  final String message;
}
