import 'package:coffeedelia/coffee/view/coffee_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeeBloc>(
      create: (context) => CoffeeBloc(CoffeeRepository())..add(LoadCoffeeImage()), // Initial event
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coffee Lover'),
        ),
        body: Center(
          child: BlocBuilder<CoffeeBloc, CoffeeState>(
            builder: (context, state) {
              if (state is CoffeeLoading) {
                return const LoadingIndicator();
              } else if (state is CoffeeLoaded) {
                return CoffeeImageWidget(
                  coffeeImage: state.coffeeImage,
                  isFavorite: state.isFavorite, // Pass isFavorite to the widget
                  onRefresh: () => context.read<CoffeeBloc>().add(RefreshCoffeeImage()),
                  onFavoriteToggled: (coffeeImage) => context.read<CoffeeBloc>().add(ToggleFavoriteCoffee(coffeeImage)),

                );
              } else if (state is CoffeeError) {
                return Text('Error: ${state.error}');
              } else {
                return Container(); // Or a default widget
              }
            },
          ),
        ),
      ),
    );
  }
}