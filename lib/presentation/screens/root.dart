import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/presentation/screens/cart.dart';
import 'package:piiicks/presentation/screens/categories.dart';
import 'package:piiicks/presentation/screens/filter.dart';
import 'package:piiicks/presentation/screens/home.dart';
import 'package:piiicks/presentation/screens/products_list.dart';
import 'package:piiicks/presentation/screens/profile.dart';
import 'package:piiicks/presentation/screens/signup.dart';
import 'package:piiicks/presentation/widgets/bottom_navbar.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../core/enums/enums.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Center(
        child: BlocBuilder<NavigationCubit, NavigationTab>(
          builder: (context, activeTab) {
            switch (activeTab) {
              case NavigationTab.homeTab:
                return const HomeScreen();
              case NavigationTab.categoriesTab:
                return const CategoriesScreen();
              case NavigationTab.productsTap:
                return const ProductsListScreen();
              case NavigationTab.cartTab:
                return const CartScreen();
              case NavigationTab.profileTab:
                return const ProfileScreen();
              default:
                return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}


