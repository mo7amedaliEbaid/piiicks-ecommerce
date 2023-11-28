import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/screens/product_details.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

import '../../application/wishlist_cubit/wishlist_cubit.dart';
import '../../data/models/product/product_model.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    context.read<WishlistCubit>().loadWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('WISHLIST', true),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoadedState) {
              if (state.wishlist.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(
                      top: AppDimensions.normalize(90),
                      bottom: AppDimensions.normalize(120),
                      left: AppDimensions.normalize(10),
                      right: AppDimensions.normalize(10)),
                  padding: Space.all(1, 1.5),
                  color: AppColors.LightGrey,
                  // height: AppDimensions.normalize(70),
                  child: Center(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "NO FAVORITES",
                          style: AppText.h3b
                              ?.copyWith(color: AppColors.CommonCyan),
                        ),
                        const Text(
                          "There Is No Saved Products.\n Please Add New Products!",
                          style: TextStyle(height: 2),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return YourWishlistWidget(wishlist: state.wishlist);
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
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
