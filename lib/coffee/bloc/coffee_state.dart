part of 'coffee_bloc.dart';

enum CoffeeErrorType { network, server, unknown }

abstract class CoffeeState {}

class CoffeeInitial extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}

class CoffeeLoaded extends CoffeeState {
  CoffeeLoaded({
    required this.coffee,
  });
  final Coffee coffee;
}

class CoffeeError extends CoffeeState {
  CoffeeError({required this.error, required this.errorType});
  final String error;
  final CoffeeErrorType errorType;
}
