import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:coffee_domain/coffee_domain.dart';

part 'coffee_state.dart';
part 'coffee_event.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  CoffeeBloc({required CoffeeResource coffeeResource})
      : _coffeeResource = coffeeResource,
        super(CoffeeInitial()) {
    on<LoadCoffeeImage>(_onLoadCoffeeImage);
    on<RefreshCoffeeImage>(_onRefreshCoffeeImage);
  }
  final CoffeeResource _coffeeResource;

  Future<void> _onLoadCoffeeImage(
      LoadCoffeeImage event, Emitter<CoffeeState> emit) async {
    emit(CoffeeLoading());
    try {
      final coffee = await _coffeeResource.fetchRandomCoffee();
      // final isFavorite = await _coffeeResource.isFavorite(coffeeImage);
      emit(CoffeeLoaded(
        coffee: coffee,
        // isFavorite: isFavorite
      ));
    } catch (e) {
      emit(CoffeeError(error: e.toString()));
    }
  }

  Future<void> _onRefreshCoffeeImage(
      RefreshCoffeeImage event, Emitter<CoffeeState> emit) async {
    emit(CoffeeLoading());
    try {
      final coffee = await _coffeeResource.fetchRandomCoffee();
      emit(CoffeeLoaded(coffee: coffee));
    } catch (e) {
      emit(CoffeeError(error: e.toString()));
    }
  }
}
