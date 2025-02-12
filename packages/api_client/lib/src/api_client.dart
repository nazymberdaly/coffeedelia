import 'package:api_client/api_client.dart';
import 'package:http/http.dart' as http;


/// {@template api_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
   ApiClient({
    required String baseUrl,
    http.Client? client,
  })  : _base = Uri.parse(baseUrl),
        _client = client ?? http.Client();

  final Uri _base;
  final http.Client _client;

  /// {@macro crossword_resource}
  late final CoffeeResource coffeeResource =
      CoffeeResource(apiClient: this);

  /// Makes a GET request to the given [path].
  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final response = await _client.get(
      _base.resolve(path),
      headers: headers,
    );
    return response;
  }

  // /// Handles the HTTP response and throws an exception if needed.
  // dynamic _handleResponse(http.Response response) {
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw ApiException(
  //       statusCode: response.statusCode,
  //       message: response.body.isNotEmpty ? response.body : 'Unknown error',
  //     );
  //   }
  // }
}

/// {@template api_exception}
/// Custom exception for handling API errors.
/// 
/// Provides the HTTP [statusCode] and an error [message] when an API call fails
/// {@endtemplate}
class ApiException implements Exception {
   /// {@macro api_exception}
  const ApiException({required this.statusCode, required this.message});
  
  /// The HTTP status code returned by the API.
  final int statusCode;
  /// The error message describing the failure reason.
  final String message;

  @override
  String toString() => 'ApiException: $statusCode - $message';
}
