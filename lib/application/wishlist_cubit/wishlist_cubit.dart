import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/product/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  Future<void> loadWishlist() async {
    final box = GetStorage();
    final wishlistIds = box.read<List<String>>('wishlist') ?? [];
    final wishlist = wishlistIds
        .map((id) => ProductModel(
        id: id,
        name: '',
        description: '',
        priceTags: [],
        categories: [],
        images: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()))
        .toList();
    emit(WishlistLoadedState(wishlist));
  }

  Future<void> addToWishlist(ProductModel product) async {
    final box = GetStorage();
    List<String> wishlistIds = box.read<List<String>>('wishlist') ?? [];
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
    List<String> wishlistIds = box.read<List<String>>('wishlist') ?? [];
    wishlistIds.remove(product.id);
    box.write('wishlist', wishlistIds);
    emit(WishlistLoadedState(
        (state as WishlistLoadedState)
            .wishlist
            .where((p) => p.id != product.id)
            .toList()));
  }

  Future<void> clearWishlist() async {
    final box = GetStorage();
    await box.remove('wishlist');
    emit(const WishlistLoadedState([]));
  }

  bool isInWishlist(String productId) {
    final box = GetStorage();
    List<String> wishlistIds = box.read<List<String>>('wishlist') ?? [];
    return wishlistIds.contains(productId);
  }
}
