import 'package:get_storage/get_storage.dart';
import '../models/product/product_model.dart';

class FavouriteProductRepository {
  final box = GetStorage();
  static const String _favoriteProductsBox = 'favorite_products';

  Future<void> addToFavorites(ProductModel product) async {
    final List<Map<String, dynamic>>? existingProducts =
    box.read(_favoriteProductsBox) as List<Map<String, dynamic>>?;

    if (existingProducts != null) {
      existingProducts.add(product.toJson());
      await box.write(_favoriteProductsBox, existingProducts);
    } else {
      await box.write(_favoriteProductsBox, [product.toJson()]);
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    final List<Map<String, dynamic>>? existingProducts =
    box.read(_favoriteProductsBox) as List<Map<String, dynamic>>?;

    if (existingProducts != null) {
      existingProducts.removeWhere((product) => product['_id'] == productId);
      await box.write(_favoriteProductsBox, existingProducts);
    }
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    final List<Map<String, dynamic>>? existingProducts =
    box.read(_favoriteProductsBox) as List<Map<String, dynamic>>?;

    if (existingProducts != null) {
      return existingProducts.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      return [];
    }
  }
}
