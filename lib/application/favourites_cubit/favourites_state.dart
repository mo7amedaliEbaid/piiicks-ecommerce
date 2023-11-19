import '../../data/models/product/product_model.dart';

abstract class FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<ProductModel> favouriteProducts;

  FavouritesLoaded(this.favouriteProducts);
}

class FavouritesError extends FavouritesState {
  final String message;

  FavouritesError(this.message);
}

class FavouritesAdding extends FavouritesState {}

class FavouritesAdded extends FavouritesState {
  final List<ProductModel> favouriteProducts;

  FavouritesAdded(this.favouriteProducts);
}

class FavouritesAddError extends FavouritesState {
  final String message;

  FavouritesAddError(this.message);
}

