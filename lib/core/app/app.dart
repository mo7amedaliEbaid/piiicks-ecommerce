import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/application/share_cubit/share_cubit.dart';

import 'package:piiicks/application/wishlist_cubit/wishlist_cubit.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../application/filter_cubit/filter_cubit.dart';
import '../../application/order_fetch_cubit/order_fetch_cubit.dart';
import '../../application/products_bloc/product_bloc.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../data/models/product/filter_params_model.dart';
import '../../di/di.dart' as di;

import '../../application/categories_bloc/category_bloc.dart';

import '../router/app_router.dart';
import '../constant/colors.dart';
import '../constant/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<NavigationCubit>()),
        BlocProvider(
          create: (context) => di.sl<WishlistCubit>()..loadWishlist(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<CategoryBloc>()..add(const GetCategories()),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
        BlocProvider(
          create: (context) => di.sl<FilterCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>()..add(CheckUser()),
        ),
        BlocProvider(
          create: (context) => di.sl<CartBloc>()..add(const GetCart()),
        ),
        BlocProvider(
          create: (context) => di.sl<DeliveryInfoActionCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<DeliveryInfoFetchCubit>()..fetchDeliveryInfo(),
        ),
        BlocProvider(
          create: (context) => di.sl<OrderFetchCubit>()..getOrders(),
        ),
        BlocProvider(
          create: (context) => di.sl<ShareCubit>(),
        ),
        /*     BlocProvider(
          create: (context) => di.sl<NotificationsCubit>()..init(),
        ),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: ThemeData.light().copyWith(
          canvasColor: AppColors.CommonCyan,
          appBarTheme: AppBarTheme(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              toolbarHeight: 56,
              centerTitle: true,
              iconTheme:
                  const IconThemeData(color: AppColors.CommonCyan, size: 30)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.CommonCyan,
              minimumSize: const Size(170, 50),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: AppColors.CommonCyan, size: 30),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.CommonCyan,
          ),
        ),
        initialRoute: AppRouter.splash,
      ),
    );
  }
}
