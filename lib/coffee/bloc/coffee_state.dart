part of 'coffee_bloc.dart';

enum CoffeeErrorType { network, server, unknown }

abstract class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object?> get props => [];
}

class CoffeeInitial extends CoffeeState {
  const CoffeeInitial();
}

class CoffeeLoading extends CoffeeState {
  const CoffeeLoading();
}

class CoffeeLoaded extends CoffeeState {
  const CoffeeLoaded({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}

class CoffeeError extends CoffeeState {
  const CoffeeError({required this.error, required this.errorType});

  final String error;
  final CoffeeErrorType errorType;

  @override
  List<Object> get props => [error, errorType];
}
