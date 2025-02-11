import 'package:api_client/api_client.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
import 'package:coffeedelia/home/view/home_page.dart';
import 'package:coffeedelia/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App(
      {required this.apiClient, required this.coffeeRepository, super.key});

  final ApiClient apiClient;
  final CoffeeRepository coffeeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: apiClient.coffeeResource),
        Provider.value(value: coffeeRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FavoriteCoffeesBloc(
              coffeeRepository: coffeeRepository,
            )..add(LoadFavoriteCoffees()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomePage(),
        ),
      ),
    );
  }
}
