import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/product/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  Future<void> loadWishlist() async {
    final box = GetStorage();
    final List<dynamic>? wishlistData = box.read('wishlist');

    if (wishlistData == null) {
      emit(const WishlistLoadedState([]));
      return;
    }

    final List<ProductModel> wishlist =
        wishlistData.map((jsonMap) => ProductModel.fromJson(jsonMap)).toList();

    emit(WishlistLoadedState(wishlist));
  }

  Future<void> addToWishlist(ProductModel product) async {
    final box = GetStorage();
    final List<dynamic>? wishlistData = box.read('wishlist');

    final List<Map<String, dynamic>> updatedWishlist =
        List<Map<String, dynamic>>.from(wishlistData ?? []);

    updatedWishlist.add(product.toJson());

    box.write('wishlist', updatedWishlist);

    if (state is WishlistLoadedState) {
      emit(WishlistLoadedState(
          (state as WishlistLoadedState).wishlist + [product]));
    } else {
      emit(WishlistLoadedState([product]));
    }
  }

  Future<void> clearWishlist() async {
    final box = GetStorage();
    await box.remove('wishlist');
    emit(const WishlistLoadedState([]));
  }

  bool isInWishlist(String productId) {
    final box = GetStorage();
    List<dynamic>? wishlistData = box.read<List<dynamic>>('wishlist');

    if (wishlistData == null) {
      return false;
    }

    // Ensure the list contains only maps
    List<Map<String, dynamic>> mapWishlistData = wishlistData
        .whereType<Map<String, dynamic>>() // Filter out non-Map elements
        .toList();

    // Extract 'id' from each map and convert it to a string
    List<String> stringWishlistIds = mapWishlistData
        .map((map) => map['_id'].toString()) // Use '_id' instead of 'id'
        .toList();

 //   log('mapWishlistData: $mapWishlistData');

 //   log(stringWishlistIds.contains(productId).toString());
    return stringWishlistIds.contains(productId);
  }
}
