import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/dashed_separator.dart';

import '../../domain/entities/order/order_details.dart';
import 'loading_shimmer.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderDetails? orderDetails;

  const OrderItemWidget({Key? key, this.orderDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderDetails != null) {
      return Padding(
        padding: Space.v!,
        child: DottedBorder(
          child: Container(
            padding: Space.all(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Order ID : ",
                            style: AppText.h3
                                ?.copyWith(color: AppColors.GreyText)),
                        Text(
                          orderDetails!.id,
                          style: AppText.h3b,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    Space.y1!,
                    Padding(
                      padding: Space.hf(.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Order Items",
                                  style: AppText.h3
                                      ?.copyWith(color: AppColors.GreyText)),
                              Space.yf(.2),
                              Text(
                                "${orderDetails!.orderItems.length}",
                                style: AppText.h3b,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Order Price",
                                style: AppText.h3
                                    ?.copyWith(color: AppColors.GreyText),
                              ),
                              Space.yf(.2),
                              Text(
                                "${orderDetails!.orderItems.fold(0.0, (previousValue, element) => (previousValue + (element.price * element.quantity)))}",
                                style: AppText.h3b,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Space.yf(),
                const DashedSeparator(),
                Space.yf(),
                Column(
                  children: orderDetails!.orderItems
                      .map((product) => Padding(
                            padding: EdgeInsets.only(
                                bottom: AppDimensions.normalize(2)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: AppDimensions.normalize(35),
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.normalize(5)),
                                        child: Padding(
                                          padding: Space.all(),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                product.product.images.first,
                                          ),
                                        )),
                                  ),
                                ),
                                Space.xf(1.2),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.product.name,
                                        style: AppText.b1b,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      Space.yf(.5),
                                      Text(
                                        '\$${product.priceTag.price.toStringAsFixed(2)}',
                                        style: AppText.b1b?.copyWith(
                                            color: AppColors.CommonCyan),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return LoadingShimmer(isSquare: false);
    }
  }
}
