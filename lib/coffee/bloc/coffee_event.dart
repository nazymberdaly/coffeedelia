part of  'coffee_bloc.dart';

sealed class CoffeeEvent extends Equatable {
  const CoffeeEvent();
}

class LoadCoffeeImage extends CoffeeEvent {
  const LoadCoffeeImage();
   @override
  List<Object> get props => [];
}
