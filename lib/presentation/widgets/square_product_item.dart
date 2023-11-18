import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/domain/entities/product/product.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/colors.dart';
import '../../domain/entities/category/category.dart';

class SquareProductItem extends StatelessWidget {
  const SquareProductItem({super.key, this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return product != null
        ? Padding(
            padding: EdgeInsets.only(right: AppDimensions.normalize(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: CachedNetworkImage(
                    height: AppDimensions.normalize(70),
                    width: AppDimensions.normalize(70),
                    imageUrl: product!.images.last,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => placeholderShimmer(),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                Space.y1!,
                SizedBox(
                  width: AppDimensions.normalize(60),
                  child: Text(
                    product!.name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.h2b?.copyWith(color: AppColors.GreyText),
                  ),
                )
              ],
            ),
          )
        : LoadingShimmer(isSquare: true);
  }
}
