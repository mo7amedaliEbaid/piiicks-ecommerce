import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/payment_details.dart';

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
      appBar: CustomAppBar("CART", context, automaticallyImplyLeading: true),
      body: Stack(
        children: [
          Padding(
            padding: Space.all(1, 0),
            child: Column(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.failure is NetworkFailure)
                            //TODO
                            if (state.failure is ServerFailure)
                              //TODO
                              // const Text("Cart is Empty!"),
                              const SizedBox.shrink()
                        ],
                      );
                    }
                    if (state is CartLoaded && state.cart.isEmpty) {
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
                        itemCount: (state is CartLoading)
                            ? 10
                            : (state.cart.length +
                                ((state is CartLoading) ? 10 : 0)),
                        padding: EdgeInsets.only(
                            bottom: AppDimensions.normalize(120)),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (state is CartLoading) {
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
          const PaymentDetails(
            buttonText: "Proceed To Checkout",
            isFromCheckout: false,
          )
        ],
      ),
    );
  }
}
