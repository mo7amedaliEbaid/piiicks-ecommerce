import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/domain/entities/order/order_item.dart';
import 'package:piiicks/presentation/widgets/auth_check_modalsheet.dart';
import 'package:piiicks/presentation/widgets/payment_details_row.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../application/order_add_cubit/order_add_cubit.dart';
import '../../configs/configs.dart';
import '../../core/constant/colors.dart';
import '../../core/router/app_router.dart';
import '../../domain/entities/order/order_details.dart';
import 'dashed_separator.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails(
      {super.key,
      required this.buttonText,
      required this.isFromCheckout,
      required this.isLogged});

  final String buttonText;
  final bool isFromCheckout;
  final bool isLogged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.cart.isEmpty) {
          return const SizedBox.shrink();
        }
        Widget paymentWidget = Container(
          color: AppColors.LightGrey,
          padding: Space.all(1, 1.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PAYMENT DETAILS",
                style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
              ),
              Space.yf(),
              PaymentDetailsRow(
                  "SUB Total",
                  '${state.cart.fold(0.0, (previousValue, element) => (element.priceTag.price + previousValue))}',
                  null),
              PaymentDetailsRow("Gift Charges", '0.000', null),
              PaymentDetailsRow("Discount", '0.000', null),
              PaymentDetailsRow("Shipping Charges", '5.000', null),
              PaymentDetailsRow(
                  "Total",
                  '${state.cart.fold(0.0, (previousValue, element) => (element.priceTag.price + previousValue)) + 5}',
                  AppText.h3b),
              const DashedSeparator(),
              Space.yf(.8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    isFromCheckout
                        ? null
                        : isLogged
                            ? Navigator.pushNamed(context, AppRouter.checkout,
                                arguments: state.cart)
                            : showAuthCheckModalSheet(context);
                  },
                  child: Text(
                    buttonText,
                    style: AppText.h3b?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              isFromCheckout
                  ? Padding(
                      padding: Space.vf(1.5),
                      child: TransparentButton(
                          context: context,
                          onTap: () {
                            if (context
                                    .read<DeliveryInfoFetchCubit>()
                                    .state
                                    .selectedDeliveryInformation ==
                                null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        height: AppDimensions.normalize(35),
                                        child: Center(
                                          child: Text(
                                            "Your Delivery Info is Empty.\nPlease Add Or Select An Adress.",
                                            style: AppText.b1b
                                                ?.copyWith(height: 1.5),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              context.read<OrderAddCubit>().addOrder(
                                  OrderDetails(
                                      id: '',
                                      orderItems: state.cart
                                          .map((item) => OrderItem(
                                                id: '',
                                                product: item.product,
                                                priceTag: item.priceTag,
                                                price: item.priceTag.price,
                                                quantity: 1,
                                              ))
                                          .toList(),
                                      deliveryInfo: context
                                          .read<DeliveryInfoFetchCubit>()
                                          .state
                                          .selectedDeliveryInformation!,
                                      discount: 0));
                            }
                          },
                          buttonText: "Pay On Delivery"),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
        return isFromCheckout
            ? paymentWidget
            : Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: paymentWidget,
              );
      },
    );
  }
}
