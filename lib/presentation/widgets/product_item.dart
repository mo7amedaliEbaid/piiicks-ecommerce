import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/colors.dart';
import '../../domain/entities/product/product.dart';
import '../../core/router/app_router.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final Function? onFavoriteToggle;
  final Function? onClick;

  const ProductCard({
    Key? key,
    this.product,
    this.onFavoriteToggle,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.white,
            child: buildBody(context),
          )
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //if (product != null) {
          Navigator.of(context)
              .pushNamed(AppRouter.productDetails, arguments: product);
      //  }
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: AppDimensions.normalize(10.8)),
        child: Padding(
          padding: Space.all(1, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: AppDimensions.normalize(70),
                imageUrl: product!.images.first,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
              Space.y1!,
              Text(
                product!.name,
                style: AppText.h3b,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Space.y!,
              Text(r'$ ' + product!.priceTags.first.price.toString(),
                  style: AppText.h3?.copyWith(color: AppColors.CommonBlue)),
            ],
          ),
        ),
      ),
    );
  }
}
