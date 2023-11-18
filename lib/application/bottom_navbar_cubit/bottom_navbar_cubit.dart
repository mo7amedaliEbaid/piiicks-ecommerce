// navigation_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/enums/enums.dart';


class NavigationCubit extends Cubit<NavigationTab> {
  NavigationCubit() : super(NavigationTab.homeTab);

  void updateTab(NavigationTab tab) => emit(tab);
}
