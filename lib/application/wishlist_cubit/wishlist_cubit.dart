import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/product/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  Future<void> loadWishlist() async {
    final box = GetStorage();
    final List<dynamic>? wishlistIds = box.read<List<dynamic>>('wishlist');

    if (wishlistIds == null) {
      emit(WishlistLoadedState([]));
      return;
    }

    final wishlist = wishlistIds
        .whereType<String>() // Only include elements of type String
        .map((id) => ProductModel(
      id: id,
      name: '',
      description: '',
      priceTags: [],
      categories: [],
      images: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ))
        .toList();

    emit(WishlistLoadedState(wishlist));
  }
  Future<void> addToWishlist(ProductModel product) async {
    final box = GetStorage();
    final dynamic wishlistData = box.read('wishlist');
    List<String> wishlistIds = (wishlistData as List<dynamic>?)?.map((id) => id.toString()).toList() ?? [];
    wishlistIds.add(product.id);
    box.write('wishlist', wishlistIds);

    if (state is WishlistLoadedState) {
      emit(WishlistLoadedState(
          (state as WishlistLoadedState).wishlist + [product]));
    } else {
      emit(WishlistLoadedState([product]));
    }
  }

  Future<void> removeFromWishlist(ProductModel product) async {
    final box = GetStorage();
    final dynamic wishlistData = box.read('wishlist');
    List<String> wishlistIds = (wishlistData as List<dynamic>?)?.map((id) => id.toString()).toList() ?? [];
    wishlistIds.remove(product.id);
    box.write('wishlist', wishlistIds);

    if (state is WishlistLoadedState) {
      emit(WishlistLoadedState(
          (state as WishlistLoadedState)
              .wishlist
              .where((p) => p.id != product.id)
              .toList()));
    }
  }


  Future<void> clearWishlist() async {
    final box = GetStorage();
    await box.remove('wishlist');
    emit(const WishlistLoadedState([]));
  }

  bool isInWishlist(String productId) {
    final box = GetStorage();
    List<dynamic>? wishlistIds = box.read<List<dynamic>>('wishlist');

    if (wishlistIds == null) {
      return false;
    }

    // Ensure the list contains only String elements
    List<String> stringWishlistIds = wishlistIds.cast<String>();

    return stringWishlistIds.contains(productId);
  }
}
