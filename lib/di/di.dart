import 'package:get_it/get_it.dart';
import 'package:piiicks/di/product.dart';
import 'package:piiicks/di/user.dart';
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

  // Register common dependencies
  registerCommonDependencies();
}
