// navigation_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationTab { homeTab, categoriesTab, productsTap, cartTab, profileTab }

class NavigationCubit extends Cubit<NavigationTab> {
  NavigationCubit() : super(NavigationTab.homeTab);

  void updateTab(NavigationTab tab) => emit(tab);
}
