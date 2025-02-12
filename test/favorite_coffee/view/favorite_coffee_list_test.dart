
import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
import 'package:coffeedelia/favorite_coffee/view/favorite_coffee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteCoffeesBloc
    extends MockBloc<FavoriteCoffeesEvent, FavoriteCoffeesState>
    implements FavoriteCoffeesBloc {}

void main() {
  late MockFavoriteCoffeesBloc mockBloc;

  setUp(() {
    mockBloc = MockFavoriteCoffeesBloc();

    // Ensure mockBloc emits correct initial and transition states
    when(() => mockBloc.state).thenReturn(FavoriteCoffeesLoaded(coffees: []));
    whenListen(
      mockBloc,
      Stream.fromIterable([FavoriteCoffeesLoaded(coffees: [])]),
    );
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<FavoriteCoffeesBloc>(
        create: (_) => mockBloc,
        child: const FavoriteCoffeeList(),
      ),
    );
  }

  group('FavoriteCoffeeList', () {
    testWidgets(
        'displays loading indicator when state is FavoriteCoffeesLoading',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(FavoriteCoffeesLoading());

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays coffee list when state is FavoriteCoffeesLoaded',
        (WidgetTester tester) async {
      final testCoffees = [
        Coffee(id: 1, imageUrl: 'test_images/espresso.jpg'),
        Coffee(id: 2, imageUrl: 'test_images/latte.jpg'),
      ];

      when(() => mockBloc.state)
          .thenReturn(FavoriteCoffeesLoaded(coffees: testCoffees));

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('displays empty state message when no coffees are found',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(FavoriteCoffeesEmpty());

      await tester.pumpWidget(createTestWidget());

      expect(find.text('No favorite coffees yet. Add some!'), findsOneWidget);
    });

    testWidgets('displays error message when state is FavoriteCoffeesError',
        (WidgetTester tester) async {
      const errorMessage = 'An error occurred';
      when(() => mockBloc.state)
          .thenReturn(FavoriteCoffeesError(message: errorMessage));

      await tester.pumpWidget(createTestWidget());

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets(
        'shows delete confirmation dialog when long pressing on a coffee',
        (WidgetTester tester) async {
      final testCoffees = [
        Coffee(id: 1, imageUrl: 'test_images/espresso.jpg'),
      ];

      when(() => mockBloc.state)
          .thenReturn(FavoriteCoffeesLoaded(coffees: testCoffees));

      await tester.pumpWidget(createTestWidget());

      await tester.longPress(find.byType(Image));

      await tester.pumpAndSettle();

      expect(find.text('Delete Coffee'), findsOneWidget);
      expect(find.text('Are you sure you want to delete this coffee?'),
          findsOneWidget);
    });
  });
}
