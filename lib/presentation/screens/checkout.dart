import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/adress_card.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/payment_details.dart';

import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../domain/entities/cart/cart_item.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key, required this.items});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("CHECKOUT", true),
      body: Stack(
        children: [
          Padding(
            padding: Space.all(.8, 0),
            child: Column(
              children: [
                BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
                  builder: (context, state) {
                    if (state.deliveryInformation.isNotEmpty &&
                        state.selectedDeliveryInformation != null) {
                      return AdressCard(
                        deliveryInformation: state.selectedDeliveryInformation!,
                        isfromCheckout: true,
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        padding: Space.all(.6, 1.32),
                        color: AppColors.LightGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SHIPPING ADDRESS",
                              style: AppText.h3b
                                  ?.copyWith(color: AppColors.CommonCyan),
                            ),
                            Space.yf(.5),
                            const Text(
                              "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.",
                              style: TextStyle(height: 1.6),
                            ),
                            Space.yf(1.8),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(AppRouter.adress);
                              },
                              child: Container(
                                padding: Space.vf(.7),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.CommonCyan)),
                                child: Center(
                                  child: Text(
                                    "Add Address",
                                    style: AppText.h3b
                                        ?.copyWith(color: AppColors.CommonCyan),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
                Space.yf(1.8),
                Container(
                  width: double.infinity,
                  padding: Space.all(.6, 1.32),
                  color: AppColors.LightGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "COUPON CODE",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                      Space.yf(1.1),
                      Container(
                        padding: Space.all(.5, .1),
                        decoration: const BoxDecoration(color: Colors.white70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: AppDimensions.normalize(40),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "   Enter Here",
                                    hintStyle: AppText.b1?.copyWith(
                                        color: Colors.grey.shade400)),
                              ),
                            ),
                            SizedBox(
                              width: AppDimensions.normalize(35),
                              height: AppDimensions.normalize(16.5),
                              child: ElevatedButton(
                                onPressed: null,
                                child: Text(
                                  "Apply",
                                  style: AppText.h3b
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Space.yf(.5)
                    ],
                  ),
                )
              ],
            ),
          ),
          const PaymentDetails(buttonText: 'Proceed To Payment',)
        ],
      ),
    );
  }
}
