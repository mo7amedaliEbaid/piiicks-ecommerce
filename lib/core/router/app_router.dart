import 'package:flutter/material.dart';
import 'package:piiicks/domain/entities/delivery/delivery_info.dart';
import 'package:piiicks/presentation/screens/add_edit_adress.dart';
import 'package:piiicks/presentation/screens/ads.dart';
import 'package:piiicks/presentation/screens/filter.dart';
import 'package:piiicks/presentation/screens/login.dart';
import 'package:piiicks/presentation/screens/product_details.dart';
import 'package:piiicks/presentation/screens/root.dart';
import 'package:piiicks/presentation/screens/search.dart';
import 'package:piiicks/presentation/screens/signup.dart';
import 'package:piiicks/presentation/screens/splash.dart';
import '../../domain/entities/product/product.dart';
import '../../presentation/screens/adress.dart';
import '../error/exceptions.dart';

sealed class AppRouter {
  static const String splash = '/';
  static const String ads = '/ads';
  static const String mainscreen = '/mainscreen';
  static const String productDetails = '/product-details';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String adress = '/adress';
  static const String addadress = '/addadress';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case ads:
        return MaterialPageRoute(builder: (_) => const AdsScreen());
      case mainscreen:
        return MaterialPageRoute(builder: (_) => const RootScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      case productDetails:
        ProductEntity product = routeSettings.arguments as ProductEntity;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product));
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case adress:
        return MaterialPageRoute(builder: (_) => const AdressScreen());
      case addadress:
        DeliveryInfo? deliveryInfo = routeSettings.arguments as DeliveryInfo?;
        return MaterialPageRoute(
            builder: (_) => AddAdressScreen(
                  deliveryInfo: deliveryInfo,
                ));

      default:
        throw const RouteException('Route not found!');
    }
  }
}
