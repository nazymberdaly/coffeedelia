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
    final response = await _apiClient.get('/random.json');

    if (response.statusCode != HttpStatus.ok) {
      throw ApiClientError(
        'POST /game/answer'
        ' returned status ${response.statusCode} '
        'with the following response: "${response.body}"',
        StackTrace.current,
      );
    }

    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Coffee.fromJson(body);
    } catch (error, stackTrace) {
      throw ApiClientError(
        'POST /game/answer'
        ' returned invalid response: "${response.body}"',
        stackTrace,
      );
    }
  }
}
