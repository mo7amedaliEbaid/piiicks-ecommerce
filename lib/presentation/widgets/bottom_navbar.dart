// bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../core/constant/assets.dart';
import '../../core/enums/enums.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (context, activeTab) {
        return SizedBox(
          height: AppDimensions.normalize(27),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: activeTab.index,
            onTap: (index) {
              final newTab = NavigationTab.values[index];
              context.read<NavigationCubit>().updateTab(newTab);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.normalize(2)),
                  child: SvgPicture.asset(
                    Assets.Home,
                    height: AppDimensions.normalize(10),
                    width: AppDimensions.normalize(10),
                    fit: BoxFit.fill,
                    color: activeTab == NavigationTab.homeTab
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.normalize(2)),
                  child: SvgPicture.asset(
                    Assets.Categories,
                    height: AppDimensions.normalize(10),
                    width: AppDimensions.normalize(10),
                    fit: BoxFit.fill,
                    color: activeTab == NavigationTab.categoriesTab
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.normalize(2)),
                  child: SvgPicture.asset(
                    Assets.Products,
                    height: AppDimensions.normalize(10),
                    width: AppDimensions.normalize(10),
                    fit: BoxFit.fill,
                    color: activeTab == NavigationTab.productsTap
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.normalize(2)),
                  child: SvgPicture.asset(
                    Assets.Cart,
                    height: AppDimensions.normalize(10),
                    width: AppDimensions.normalize(10),
                    fit: BoxFit.fill,
                    color: activeTab == NavigationTab.cartTab
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.normalize(2)),
                  child: SvgPicture.asset(
                    Assets.Profile,
                    height: AppDimensions.normalize(10),
                    width: AppDimensions.normalize(10),
                    fit: BoxFit.fill,
                    color: activeTab == NavigationTab.profileTab
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                label: 'Profile',
              ),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            iconSize: AppDimensions.normalize(12),
            selectedLabelStyle: AppText.b2b,
            unselectedLabelStyle: AppText.b2,
          ),
        );
      },
    );
  }
}
