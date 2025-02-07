part of  'coffee_bloc.dart';

abstract class CoffeeEvent {}

class LoadCoffeeImage extends CoffeeEvent {}

class RefreshCoffeeImage extends CoffeeEvent {}

class ToggleFavoriteCoffee extends CoffeeEvent {
  ToggleFavoriteCoffee(this.coffee);
  final Coffee coffee;
}
