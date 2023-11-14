import 'package:flutter/material.dart';
import 'package:piiicks/presentation/screens/product_details_screen.dart';
import 'package:piiicks/presentation/screens/root.dart';
import '../../domain/entities/product/product.dart';
import '../error/exceptions.dart';

sealed class AppRouter {

  static const String mainscreen = '/';
  static const String productDetails = '/product-details';


  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case mainscreen:
        return MaterialPageRoute(
            builder: (_) => RootScreen());
      case productDetails:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product));

      default:
        throw const RouteException('Route not found!');
    }
  }
}
