import 'package:api_client/api_client.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffeedelia/app/app.dart';
import 'package:coffeedelia/coffeedelia_main/coffeedelia_main_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockCoffeeResource extends Mock implements CoffeeResource {}

void main() {
  group('App', () {
    late ApiClient apiClient;
    late CoffeeRepository coffeeRepository;
    late CoffeeResource coffeeResource;

    setUp(() {
      apiClient = MockApiClient();
      coffeeRepository = MockCoffeeRepository();
      coffeeResource = MockCoffeeResource();
      when(() => apiClient.coffeeResource).thenReturn(coffeeResource);
    });
    testWidgets('renders CoffeedeliaMainPage', (tester) async {
      await tester.pumpWidget(
        App(apiClient: apiClient, coffeeRepository: coffeeRepository),
      );
      expect(find.byType(CoffeedeliaMainPage), findsOneWidget);
    });
  });
}
