import 'package:api_client/api_client.dart';
import 'package:coffeedelia/coffee/bloc/coffee_bloc.dart';
import 'package:coffeedelia/coffee/view/coffee_image_view.dart';
import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
import 'package:coffeedelia/favorite_coffee/view/favorite_coffee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => CoffeeBloc(
        coffeeResource: context.read<CoffeeResource>(),
      )..add(LoadCoffeeImage()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coffee Lover'),
        ),
        body: Center(
          child: BlocBuilder<CoffeeBloc, CoffeeState>(
            builder: (context, state) {
              if (state is CoffeeLoading) {
                return const CircularProgressIndicator();
              } else if (state is CoffeeLoaded) {
                return CoffeeImageView(
                  coffee: state.coffee,
                  isFavorite:
                      false, //state.isFavorite, // Pass isFavorite to the widget
                  onRefresh: () =>
                      context.read<CoffeeBloc>().add(RefreshCoffeeImage()),
                  onFavoriteToggled: (coffeeImage) => context
                      .read<FavoriteCoffeesBloc>()
                      .add(AddFavoriteCoffee(coffee: coffeeImage)),
                );
              } else if (state is CoffeeError) {
                return Text('Error: ${state.error}');
              } else {
                return Container(); // Or a default widget
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    const FavoriteCoffeeList(), // Use const if possible
              ),
            );
          },
        ),
      ),
    );
  }
}
