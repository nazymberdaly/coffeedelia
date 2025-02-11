import 'dart:convert';
import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:coffee_domain/coffee_domain.dart';

/// {@template coffee_resource}
/// An api resource for interacting with the coffee.
/// {@endtemplate}
class CoffeeResource {
  /// {@macro crossword_resource}
  CoffeeResource({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Get random coffee image
  ///
  /// Returns a [Map<String, String>]
  Future<Coffee> fetchRandomCoffee() async {
    
    try {
      final response = await _apiClient.get('/random.json');
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Coffee.fromJson(body);
    } on SocketException catch (error) {
        throw NetworkException("No internet connection. Please check your connectiion and try again.");
    } on HttpException catch (error) {
        throw ServerException("Server error. Please try again later.");
    }

    // if (response.statusCode != HttpStatus.ok) {
    //   throw ApiClientError(
    //     'GET /random.json'
    //     ' returned status ${response.statusCode} '
    //     'with the following response: "${response.body}"',
    //     StackTrace.current,
    //   );
    // }

     catch (error, stackTrace) {
      throw ApiClientError(
        'GET /random.json'
        ' returned invalid response: "$error"',
        stackTrace,
      );
    }
  }
}
