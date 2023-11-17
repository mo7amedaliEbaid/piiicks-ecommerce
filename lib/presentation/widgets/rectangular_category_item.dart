import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/colors.dart';
import '../../domain/entities/category/category.dart';

class RectangularCategoryItem extends StatelessWidget {
  const RectangularCategoryItem({super.key, this.category});

  final Category? category;

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return category != null
        ? Container(
            padding: EdgeInsets.only(left: AppDimensions.normalize(7)),
            margin: EdgeInsets.symmetric(vertical: AppDimensions.normalize(3)),
            decoration: BoxDecoration(
                color: AppColors.LightGrey,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: CachedNetworkImage(
                    height: AppDimensions.normalize(40),
                    width: AppDimensions.normalize(60),
                    imageUrl: category!.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => placeholderShimmer(),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                Space.x1!,
                Text(
                  category!.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.h2b?.copyWith(color: AppColors.GreyText),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.CommonBlue,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  width: AppDimensions.normalize(7),
                  height: AppDimensions.normalize(60),
                )
              ],
            ),
          )
        : LoadingShimmer(isSquare: false);
  }
}
