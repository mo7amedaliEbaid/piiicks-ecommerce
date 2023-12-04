import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';

import '../../core/constant/colors.dart';
import '../../domain/entities/product/product.dart';
import '../../core/router/app_router.dart';

class RectangularProductItem extends StatelessWidget {
  final ProductEntity? product;
  final Function? onClick;
  final bool isFromWishlist;

  const RectangularProductItem({
    Key? key,
    this.product,
    this.onClick,
    this.isFromWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return product == null
        ? LoadingShimmer(isSquare: true)
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRouter.productDetails, arguments: product);
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: AppDimensions.normalize(10.8)),
        child: Padding(
          padding: isFromWishlist ? Space.all(.5, .5) : Space.all(1, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product!.id,
                child: product!.images.isNotEmpty
                    ? CachedNetworkImage(
                        height: AppDimensions.normalize(70),
                        imageUrl: isFromWishlist
                            ? product!.images.last
                            : product!.images.first,
                        placeholder: (context, url) => placeholderShimmer(),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      )
                    : SvgPicture.asset(
                        AppAssets.PiiicksIcon,
                        height: AppDimensions.normalize(70),
                      ),
              ),
              Space.y1!,
              Text(
                product!.name,
                style: AppText.h3b,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Space.y!,
              product!.priceTags.isNotEmpty
                  ? Text(
                      r'$ ' + product!.priceTags.first.price.toString(),
                      style: AppText.h3?.copyWith(
                        color: AppColors.CommonCyan,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
