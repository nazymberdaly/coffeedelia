import 'dart:io';

import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
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
            return ListView.builder(
              itemCount: state.coffees.length,
              itemBuilder: (context, index) {
                final coffee = state.coffees[index];
                return ListTile(
                  leading: Image.file(File(coffee.imageUrl)),
                  title: Text("coffee.name"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // context
                      //     .read<FavoriteCoffeesBloc>()
                      //     .add(RemoveFavoriteCoffee(id: coffee.id!));
                    },
                  ),
                );
              },
            );
          } else if (state is FavoriteCoffeesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }
}
