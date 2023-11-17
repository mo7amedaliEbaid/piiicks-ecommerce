import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';
import 'package:shimmer/shimmer.dart';


import '../../core/constant/colors.dart';
import '../../domain/entities/category/category.dart';

class SquareCategoryItem extends StatelessWidget {
  const SquareCategoryItem({super.key, this.category});

  final Category? category;

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return category != null
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
                    imageUrl: category!.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>placeholderShimmer(),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                Space.y1!,
                Text(
                  category!.name.toUpperCase(),
                  style: AppText.h2b?.copyWith(color: AppColors.GreyText),
                )
              ],
            ),
          )
        : LoadingShimmer(isSquare: true);
  }
}
