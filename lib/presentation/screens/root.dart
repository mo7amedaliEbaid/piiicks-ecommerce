import 'package:flutter/material.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/presentation/screens/categories.dart';
import 'package:piiicks/presentation/screens/home.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens =<Widget>[
    const HomeScreen(),
    const CategoriesScreen(),
    const CategoriesScreen(),
    const CategoriesScreen(),
    const CategoriesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: AppDimensions.normalize(25),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          iconSize: AppDimensions.normalize(12),
          selectedLabelStyle: AppText.b2b,
          unselectedLabelStyle: AppText.b2,
        ),
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
    );
  }
}
