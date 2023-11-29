import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/presentation/widgets/payment_details_row.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

import '../../application/cart_bloc/cart_bloc.dart';
import '../../configs/configs.dart';
import '../../core/constant/colors.dart';
import '../../core/router/app_router.dart';
import 'dashed_separator.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails(
      {super.key, required this.buttonText, required this.isFromCheckout});

  final String buttonText;
  final bool isFromCheckout;

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
                        : Navigator.pushNamed(context, AppRouter.checkout,
                            arguments: state.cart);
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
                          onTap: () {},
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
