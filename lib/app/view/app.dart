import 'package:api_client/api_client.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffeedelia/coffee/bloc/coffee_bloc.dart';
import 'package:coffeedelia/favorite_coffee/bloc/favorite_coffee_bloc.dart';
import 'package:coffeedelia/home/view/home_page.dart';
import 'package:coffeedelia/l10n/l10n.dart';
import 'package:coffeedelia/main_screen/main_screen.dart';
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
          BlocProvider(
            lazy: false,
            create: (context) => CoffeeBloc(
              coffeeResource: context.read<CoffeeResource>(),
            )..add(LoadCoffeeImage()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: const Color(0xFFB38867), // Coffee
            scaffoldBackgroundColor: const Color(0xFFF3EEEA), // Ceramic
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFEBE3D5), // Slate
              foregroundColor: Color(0xFF776B5D),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFFEBE3D5),
              selectedItemColor: Color(0xFF776B5D), // Latte
              unselectedItemColor: Color(0xFFB0A695),
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
