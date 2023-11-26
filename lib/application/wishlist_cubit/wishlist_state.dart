part of 'wishlist_cubit.dart';




abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitialState extends WishlistState {}

class WishlistLoadedState extends WishlistState {
  final List<ProductModel> wishlist;

  const WishlistLoadedState(this.wishlist);

  @override
  List<Object> get props => [wishlist];
}
