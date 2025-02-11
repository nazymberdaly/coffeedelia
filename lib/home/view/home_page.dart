import 'package:coffeedelia/coffee/bloc/coffee_bloc.dart';
import 'package:coffeedelia/coffee/view/coffee_card.dart';
import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
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
                isFavorite:
                    false, //state.isFavorite, // Pass isFavorite to the widget
                onRefresh: () =>
                    context.read<CoffeeBloc>().add(RefreshCoffeeImage()),
                onFavoriteToggled: (coffeeImage) {
                  context
                      .read<FavoriteCoffeesBloc>()
                      .add(AddFavoriteCoffee(coffee: coffeeImage));
                  context.read<CoffeeBloc>().add(RefreshCoffeeImage());
                },
              );
            } else if (state is CoffeeError) {
              return Text('Error: ${state.error}');
            } else {
              return Container(); // Or a default widget
            }
          },
        ),
      ),
    );
  }
}
