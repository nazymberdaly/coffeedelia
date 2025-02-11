import 'package:api_client/api_client.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffeedelia/app/app.dart';
import 'package:coffeedelia/bootstrap.dart';
import 'package:db_client/db_client.dart';

void main() {
  bootstrap(() {
    final apiClient = ApiClient(
      baseUrl: 'https://coffee.alexflipnote.dev',
    );
    final coffeeRepository = CoffeeRepository(dbClient: DbClient.instance);
    return App(
      apiClient: apiClient,
      coffeeRepository: coffeeRepository,
    );
  });
}
