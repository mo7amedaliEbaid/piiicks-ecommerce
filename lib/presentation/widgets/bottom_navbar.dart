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
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    double height = AppDimensions.normalize(10);
    double width = AppDimensions.normalize(10);
    EdgeInsets padding = EdgeInsets.only(bottom: AppDimensions.normalize(2));
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
                  padding: padding,
                  child: SvgPicture.asset(
                    AppAssets.Home,
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        activeTab == NavigationTab.homeTab
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: padding,
                  child: SvgPicture.asset(
                    AppAssets.Categories,
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        activeTab == NavigationTab.categoriesTab
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: padding,
                  child: SvgPicture.asset(
                    AppAssets.Products,
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        activeTab == NavigationTab.productsTap
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
                  ),
                ),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: padding,
                  child: SvgPicture.asset(
                    AppAssets.Cart,
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        activeTab == NavigationTab.cartTab
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
                  ),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: padding,
                  child: SvgPicture.asset(
                    AppAssets.Profile,
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        activeTab == NavigationTab.profileTab
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
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
