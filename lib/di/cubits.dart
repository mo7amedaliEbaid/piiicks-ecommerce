import 'package:piiicks/application/filter_cubit/filter_cubit.dart';

import '../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'di.dart';

void registerCubits() {
  // Navigation
  sl.registerFactory(() => NavigationCubit());

  //Filter
  sl.registerFactory(() => FilterCubit());

}