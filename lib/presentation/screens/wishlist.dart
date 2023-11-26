import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/presentation/screens/product_details.dart';

import '../../application/wishlist_cubit/wishlist_cubit.dart';
import '../../data/models/product/product_model.dart';

class WhishListScreen extends StatefulWidget {
  const WhishListScreen({super.key});

  @override
  State<WhishListScreen> createState() => _WhishListScreenState();
}

class _WhishListScreenState extends State<WhishListScreen> {
  @override
  void initState() {
    context.read<WishlistCubit>().loadWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: YourWidgetContent(),
    );
  }
}

class YourWidgetContent extends StatelessWidget {
  const YourWidgetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoadedState) {
          return YourWishlistWidget(wishlist: state.wishlist);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class YourWishlistWidget extends StatelessWidget {
  final List<ProductModel> wishlist;

  YourWishlistWidget({required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(wishlist[index].name),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(product: wishlist[index]),
              ),
            );
          },
          // Add more UI components as needed
        );
      },
    );
  }
}
