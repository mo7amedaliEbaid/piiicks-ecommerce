import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/products_bloc/product_bloc.dart';
import '../domain/usecases/product/get_product_usecase.dart';
import '../shared/di/di.dart' as di;

import 'package:piiicks/presentation/screens/root.dart';
import 'package:piiicks/shared/constant/colors.dart';
import 'package:piiicks/shared/constant/strings.dart';

import '../application/categories_bloc/category_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          di.sl<CategoryBloc>()..add(const GetCategories()),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData.light().copyWith(
            canvasColor: AppColors.CommonBlue,
            iconTheme: IconThemeData(color: AppColors.CommonBlue, size: 30)),
        home: const RootScreen(),
      ),
    );
  }
}
