/*
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product/product_model.dart';
import '../../data/repositories/favourite_products_repo_impl.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final FavouriteProductRepository favouriteProductRepository;

  FavouritesCubit(this.favouriteProductRepository) : super(FavouritesLoading());

  void getFavouriteProducts() async {
    emit(FavouritesLoading());

    try {
      final favouriteProducts = await favouriteProductRepository.getFavoriteProducts();
      emit(FavouritesLoaded(favouriteProducts));
    } catch (e) {
      emit(FavouritesError('Failed to load favourite products'));
    }
  }

  void addToFavourites(ProductModel product) async {
    emit(FavouritesAdding());

    try {
      await favouriteProductRepository.addToFavorites(product);
      final updatedFavouriteProducts = await favouriteProductRepository.getFavoriteProducts();
      emit(FavouritesAdded(updatedFavouriteProducts));
    } catch (e) {
      emit(FavouritesAddError('Failed to add product to favourites'));
    }
  }
}
*/
