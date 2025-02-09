import 'dart:io';

import 'package:db_client/db_client.dart';

/// {@template coffee_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CoffeeRepository {
  /// {@macro coffee_repository}
  const CoffeeRepository({required DbClient dbClient,
  }) : _dbClient = dbClient;

  final DbClient _dbClient;

  Future<void> addCoffee(String name, File imageFile) async {
    final imagePath = await _dbClient.saveImage(imageFile, name);
    final coffee = CoffeeEntity(imagePath: imagePath);
    await _dbClient.insertCoffee(coffee);
  }

  Future<List<CoffeeEntity>> getFavoriteCoffees() {
    return _dbClient.getCoffees();
  }

   Future<void> removeCoffee(int id) async {
    await _dbClient.deleteCoffee(id);
  }

   Future<CoffeeEntity?> getCoffee(int id) async {
    return _dbClient.getCoffee(id);
  }
}
