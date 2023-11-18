// bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (context, activeTab) {
        return SizedBox(
          height: AppDimensions.normalize(25),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: activeTab.index,
            onTap: (index) {
              final newTab = NavigationTab.values[index];
              context.read<NavigationCubit>().updateTab(newTab);
            },
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
                icon: Icon(Icons.shopping_basket_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
         //   currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
           // onTap: _onItemTapped,
            iconSize: AppDimensions.normalize(12),
            selectedLabelStyle: AppText.b2b,
            unselectedLabelStyle: AppText.b2,
          ),
        );
      },
    );
  }
}
