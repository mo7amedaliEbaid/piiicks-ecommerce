import 'package:flutter/material.dart';
import 'package:piiicks/presentation/screens/ads.dart';
import 'package:piiicks/presentation/screens/product_details.dart';
import 'package:piiicks/presentation/screens/root.dart';
import 'package:piiicks/presentation/screens/splash.dart';
import '../../domain/entities/product/product.dart';
import '../error/exceptions.dart';

sealed class AppRouter {

  static const String splash = '/';
  static const String ads = '/ads';
  static const String mainscreen = '/mainscreen';
  static const String productDetails = '/product-details';


  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(
            builder: (_) =>const SplashScreen());
      case ads:
        return MaterialPageRoute(
            builder: (_) => AdsScreen());
      case mainscreen:
        return MaterialPageRoute(
            builder: (_) =>const RootScreen());
      case productDetails:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product));

      default:
        throw const RouteException('Route not found!');
    }
  }
}
