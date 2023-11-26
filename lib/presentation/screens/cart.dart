import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/dashed_separator.dart';
import 'package:piiicks/presentation/widgets/payment_details_row.dart';

import '../../../../core/error/failures.dart';
import '../../../../domain/entities/cart/cart_item.dart';
import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/cart_bloc/cart_bloc.dart';
import '../../core/enums/enums.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> selectedCartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("CART", false),
      body: Stack(
        children: [
          Padding(
            padding: Space.all(1, 0),
            child: Column(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartError && state.cart.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.failure is NetworkFailure)
                            //TODO
                            if (state.failure is ServerFailure)
                              //TODO
                              // const Text("Cart is Empty!"),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                        ],
                      );
                    }
                    if (state.cart.isEmpty) {
                      return Container(
                        color: AppColors.LightGrey,
                        margin:
                            EdgeInsets.only(top: AppDimensions.normalize(60)),
                        //  height: AppDimensions.normalize(45),
                        padding: Space.all(1, 2.5),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "NO ITEMS IN CART",
                                style: AppText.h3b
                                    ?.copyWith(color: AppColors.CommonCyan),
                              ),
                              Space.yf(),
                              Text(
                                "We Have Found No Items Added",
                                style: AppText.b1,
                              ),
                              Space.yf(),
                              Text(
                                "In Your Cart To Checkout",
                                style: AppText.b1,
                              ),
                              Space.yf(1.5),
                              SizedBox(
                                width: AppDimensions.normalize(50),
                                child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<NavigationCubit>()
                                          .updateTab(NavigationTab.productsTap);
                                    },
                                    child: Text(
                                      "Add Items",
                                      style: AppText.h3b
                                          ?.copyWith(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: (state is CartLoading && state.cart.isEmpty)
                            ? 10
                            : (state.cart.length +
                                ((state is CartLoading) ? 10 : 0)),
                        padding: EdgeInsets.only(
                            bottom: AppDimensions.normalize(120)),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (state is CartLoading && state.cart.isEmpty) {
                            return const CartItemCard();
                          } else {
                            if (state.cart.length < index) {
                              return const CartItemCard();
                            }
                            return CartItemCard(
                              cartItem: state.cart[index],
                              isSelected: selectedCartItems.any(
                                  (element) => element == state.cart[index]),
                              onLongClick: () {
                                setState(() {
                                  if (selectedCartItems.any((element) =>
                                      element == state.cart[index])) {
                                    selectedCartItems.remove(state.cart[index]);
                                  } else {
                                    selectedCartItems.add(state.cart[index]);
                                  }
                                });
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
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
                          "Proceed To Checkout",
                          style: AppText.h3b?.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}