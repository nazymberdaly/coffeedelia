import 'dart:io';

import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
import 'package:coffeedelia_ui/coffeedelia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCoffeeList extends StatelessWidget {
  const FavoriteCoffeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Coffees')),
      body: BlocBuilder<FavoriteCoffeesBloc, FavoriteCoffeesState>(
        builder: (context, state) {
          if (state is FavoriteCoffeesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteCoffeesLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1,
              ),
              itemCount: state.coffees.length,
              itemBuilder: (context, index) {
                final coffee = state.coffees[index];
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Coffee'),
                        content: const Text(
                            'Are you sure you want to delete this coffee?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<FavoriteCoffeesBloc>().add(
                                    RemoveFavoriteCoffee(id: coffee.id!),
                                  );
                              Navigator.of(context).pop();
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(coffee.imageUrl),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                );
              },
            );
          } else if (state is FavoriteCoffeesEmpty) {
            return const Center(
              child: ErrorView(
                title: 'No favorite coffees yet. Add some!',
              ),
            );
          } else if (state is FavoriteCoffeesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
                child: Text(
              'Unknown State',
              style: TextStyle(color: Colors.amber),
            ));
          }
        },
      ),
    );
  }
}
