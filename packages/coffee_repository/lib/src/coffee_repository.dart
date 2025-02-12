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
  
   /// Database client for handling coffee storage.
  final DbClient _dbClient;
 
  /// Downloads an image from [imageUrl], saves it locally, and stores its 
  /// path in the database.
  Future<void> addCoffee(String imageUrl) async {
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
  
  /// Retrieves a list of all stored coffee entities.
  Future<List<CoffeeEntity>> getFavoriteCoffees() async {
    return await _dbClient.getCoffees();
  }
  
  /// Removes a coffee entity from the database by its [id].
  Future<void> removeCoffee(int id) async {
    await _dbClient.deleteCoffee(id);
  }
  
  /// Retrieves a single coffee entity by its [id].
  Future<CoffeeEntity?> getCoffee(int id) async {
    return await _dbClient.getCoffee(id);
  }
}
