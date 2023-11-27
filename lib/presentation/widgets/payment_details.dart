import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/presentation/widgets/payment_details_row.dart';

import '../../application/cart_bloc/cart_bloc.dart';
import '../../configs/configs.dart';
import '../../core/constant/colors.dart';
import '../../core/router/app_router.dart';
import 'dashed_separator.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key, required this.buttonText});
final String buttonText;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state.cart.isEmpty) {
        return const SizedBox.shrink();
      }
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
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
                    Navigator.pushNamed(context, AppRouter.checkout,
                        arguments: state.cart);
                  },
                  child: Text(
                    buttonText,
                    style: AppText.h3b?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
