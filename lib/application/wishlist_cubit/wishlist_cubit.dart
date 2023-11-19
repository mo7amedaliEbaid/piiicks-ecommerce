import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/product/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  Future<void> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final wishlistIds = prefs.getStringList('wishlist') ?? [];
    final wishlist = wishlistIds
        .map((id) => ProductModel(id: id, name: '', description: '', priceTags: [], categories: [], images: [], createdAt: DateTime.now(), updatedAt: DateTime.now()))
        .toList();
    emit(WishlistLoadedState(wishlist));
  }

  Future<void> addToWishlist(ProductModel product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlistIds = prefs.getStringList('wishlist') ?? [];
    wishlistIds.add(product.id);
    await prefs.setStringList('wishlist', wishlistIds);

    if (state is WishlistLoadedState) {
      emit(WishlistLoadedState((state as WishlistLoadedState).wishlist + [product]));
    } else {
      // If the initial state is not WishlistLoadedState, we need to handle it appropriately.
      // You can choose to do nothing or emit a different state based on your use case.
      // For now, let's emit an empty wishlist as a default.
      emit(WishlistLoadedState([product]));
    }
  }

  Future<void> removeFromWishlist(ProductModel product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlistIds = prefs.getStringList('wishlist') ?? [];
    wishlistIds.remove(product.id);
    await prefs.setStringList('wishlist', wishlistIds);
    emit(WishlistLoadedState((state as WishlistLoadedState).wishlist.where((p) => p.id != product.id).toList()));
  }

  Future<void> clearWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('wishlist');
    emit(WishlistLoadedState([]));
  }
}
