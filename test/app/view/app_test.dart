import 'package:coffeedelia/app/app.dart';
import 'package:coffeedelia/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App(apiClient: null,));
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
