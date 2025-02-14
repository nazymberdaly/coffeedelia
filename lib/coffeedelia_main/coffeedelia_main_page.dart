import 'package:coffeedelia/favorite_coffee/favorite_coffee.dart';
import 'package:coffeedelia/home/view/home_page.dart';
import 'package:flutter/material.dart';

/// The main page of the Coffeedelia app, displaying a bottom navigation bar
class CoffeedeliaMainPage extends StatefulWidget {
  /// Creates a [CoffeedeliaMainPage].
  const CoffeedeliaMainPage({super.key});

  @override
  State<CoffeedeliaMainPage> createState() => _CoffeedeliaMainPageState();
}

class _CoffeedeliaMainPageState extends State<CoffeedeliaMainPage> {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex; 

  static final List<Widget> _pages = [
    const HomePage(),
    const FavoriteCoffeeList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}
