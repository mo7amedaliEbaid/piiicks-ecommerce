import 'package:get_it/get_it.dart';
import 'package:piiicks/di/cubits.dart';
import 'package:piiicks/di/order.dart';
import 'package:piiicks/di/product.dart';
import 'package:piiicks/di/user.dart';
import 'cart.dart';
import 'category.dart';
import 'common.dart';
import 'delivery.dart';

final sl = GetIt.instance;

// Main Initialization
Future<void> init() async {
  // Register features
  registerCategoryFeature();
  registerProductFeature();
  registerUserFeature();
  registerDeliveryInfoFeature();
  registerCartFeature();
  registerOrderFeature();

  // Register Cubits
  registerCubits();

  // Register common dependencies
  registerCommonDependencies();
}
