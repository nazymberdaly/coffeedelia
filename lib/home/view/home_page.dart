import 'package:coffeedelia/coffee/coffee.dart';
import 'package:coffeedelia/favorite_coffee/favorite_coffee.dart';
import 'package:coffeedelia_ui/coffeedelia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffeedelia'),
      ),
      body: Center(
        child: BlocBuilder<CoffeeBloc, CoffeeState>(
          builder: (context, state) {
            if (state is CoffeeLoading) {
              return const CircularProgressIndicator();
            } else if (state is CoffeeLoaded) {
              return CoffeeCard(
                coffee: state.coffee,
                onRefresh: () =>
                    context.read<CoffeeBloc>().add(LoadCoffeeImage()),
                onFavoriteToggled: (coffeeImage) {
                  context
                      .read<FavoriteCoffeesBloc>()
                      .add(AddFavoriteCoffee(coffee: coffeeImage));
                  context.read<CoffeeBloc>().add(LoadCoffeeImage());
                },
              );
            } else if (state is CoffeeError) {
              if (state.errorType == CoffeeErrorType.network) {
                return ErrorView(
                  title: state.error,
                  onPressed: () => context.read<CoffeeBloc>().add(
                        LoadCoffeeImage(),
                      ),
                      buttonTitle: 'Retry',
                );
              }
              return Text(state.error, textAlign: TextAlign.center);
            } else {
              return Container(); // Or a default widget
            }
          },
        ),
      ),
    );
  }
}
