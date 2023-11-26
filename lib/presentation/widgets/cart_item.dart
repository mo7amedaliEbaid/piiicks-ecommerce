import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/dashed_separator.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';
import 'package:piiicks/presentation/widgets/quantity_row.dart';

import '../../core/router/app_router.dart';
import '../../domain/entities/cart/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem? cartItem;
  final Function? onFavoriteToggle;
  final Function? onClick;
  final Function()? onLongClick;
  final bool isSelected;

  const CartItemCard({
    Key? key,
    this.cartItem,
    this.onFavoriteToggle,
    this.onClick,
    this.onLongClick,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cartItem == null
        ? LoadingShimmer(isSquare: false)
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Space.yf(1),
        GestureDetector(
          onTap: () {
            if (cartItem != null) {
              Navigator.of(context).pushNamed(AppRouter.productDetails,
                  arguments: cartItem!.product);
            }
          },
          onLongPress: onLongClick,
          child: SizedBox(
            height: AppDimensions.normalize(50),
            width: double.infinity,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: cartItem!.product.images.last,
                  width: AppDimensions.normalize(50),
                  height: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      LoadingShimmer(isSquare: false),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
                Space.xf(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: AppDimensions.normalize(75),
                        child: Text(
                          cartItem!.product.name,
                          maxLines: 2,
                          style: AppText.h3b,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Space.yf(.5),
                    Text(
                      "${cartItem!.product.priceTags.first.price} \$",
                      style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                    ),
                    Space.yf(),
                    Row(
                      children: [
                        SizedBox(
                            height: AppDimensions.normalize(15),
                            width: AppDimensions.normalize(55),
                            child: QuantityRow(14, 1.5)),
                        Space.xf(),
                        GestureDetector(
                          onTap: onLongClick,
                          child: const Icon(
                            Icons.delete_forever_outlined,
                            size: 40,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Space.yf(1),
        const DashedSeparator()
      ],
    );
  }
}

