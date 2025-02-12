import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:equatable/equatable.dart';

part 'coffee_state.dart';
part 'coffee_event.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  CoffeeBloc({required CoffeeResource coffeeResource})
      : _coffeeResource = coffeeResource,
        super(CoffeeInitial()) {
    on<LoadCoffeeImage>(_onLoadCoffeeImage);
  }
  final CoffeeResource _coffeeResource;

  Future<void> _onLoadCoffeeImage(
      LoadCoffeeImage event, Emitter<CoffeeState> emit) async {
    emit(CoffeeLoading());
    try {
      final coffee = await _coffeeResource.fetchRandomCoffee();
      emit(
        CoffeeLoaded(
          coffee: coffee,
        ),
      );
    } on NetworkException catch (error) {
      emit(
        CoffeeError(
          error: error.cause,
          errorType: CoffeeErrorType.network,
        ),
      );
    } on ServerException {
      emit(
        CoffeeError(
          error: 'Server error. Please try again later.',
          errorType: CoffeeErrorType.server,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        CoffeeError(
          error: 'An unexpected error occurred.',
          errorType: CoffeeErrorType.unknown,
        ),
      );
    }
  }
}
