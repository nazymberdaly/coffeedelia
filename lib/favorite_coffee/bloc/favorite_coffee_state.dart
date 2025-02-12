part of 'favorite_coffee_bloc.dart';

/// The base class for all favorite coffee states.
abstract class FavoriteCoffeesState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Represents the loading state when favorite coffees are being fetched.
class FavoriteCoffeesLoading extends FavoriteCoffeesState {}

/// Represents the state when favorite coffees have been successfully loaded.
class FavoriteCoffeesLoaded extends FavoriteCoffeesState {
  /// Creates a [FavoriteCoffeesLoaded] state with the given list of coffees.
  FavoriteCoffeesLoaded({required this.coffees});

  /// The list of favorite coffees.
  final List<Coffee> coffees;

  @override
  List<Object?> get props => [coffees];
}

/// Represents the state when no favorite coffees are available.
class FavoriteCoffeesEmpty extends FavoriteCoffeesState {}

/// Represents an error state when fetching favorite coffees fails.
class FavoriteCoffeesError extends FavoriteCoffeesState {
  /// Creates a [FavoriteCoffeesError] state with the given error [message].
  FavoriteCoffeesError({required this.message});

  /// The error message describing what went wrong.
  final String message;

  @override
  List<Object?> get props => [message];
}
