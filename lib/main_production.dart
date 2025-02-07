import 'package:api_client/api_client.dart';
import 'package:coffeedelia/app/app.dart';
import 'package:coffeedelia/bootstrap.dart';

void main() {
   bootstrap(() {
    final apiClient = ApiClient(
      baseUrl: 'https://coffee.alexflipnote.dev',
    );
    return App(
      apiClient: apiClient,
    );
  });
}
