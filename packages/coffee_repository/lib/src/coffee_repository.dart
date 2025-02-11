import 'dart:io';

import 'package:db_client/db_client.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// {@template coffee_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CoffeeRepository {
  /// {@macro coffee_repository}
  const CoffeeRepository({
    required DbClient dbClient,
  }) : _dbClient = dbClient;

  final DbClient _dbClient;

  Future<void> addCoffee(String imageUrl) async {
    // final imagePath = await _dbClient.saveImage(imageFile, name);
    // final coffee = CoffeeEntity(imagePath: imagePath);
    //await _dbClient.insertCoffee(coffee);

    final response = await http.get(Uri.parse(imageUrl)); // Download

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes; // Get image bytes
      final directory = await getApplicationDocumentsDirectory();
      final newImagePath =
          '${directory.path}/coffeeName_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Local path
      final imageFile = File(newImagePath);
      await imageFile.writeAsBytes(bytes); // Save to file

      final coffee = CoffeeEntity(imagePath: newImagePath);
      await _dbClient.insertCoffee(coffee);
    }
  }

  Future<List<CoffeeEntity>> getFavoriteCoffees() async {
    return await _dbClient.getCoffees();
  }

  Future<void> removeCoffee(int id) async {
    await _dbClient.deleteCoffee(id);
  }

  Future<CoffeeEntity?> getCoffee(int id) async {
    return await _dbClient.getCoffee(id);
  }
}
