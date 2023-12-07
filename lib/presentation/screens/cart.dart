import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/empty_cart_container.dart';
import 'package:piiicks/presentation/widgets/error_container.dart';
import 'package:piiicks/presentation/widgets/payment_details.dart';

import '../../../../core/error/failures.dart';
import '../../../../domain/entities/cart/cart_item.dart';
import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../core/enums/enums.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> selectedCartItems = [];
  bool isCartError = false;

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
                BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    /*setState(() {
                      isCartError = true;
                    });*/
                  },
                  builder: (context, state) {
                    if (state is CartError) {
                      return errorContainer(context, true);
                    }
                    if (state is CartLoaded && state.cart.isEmpty) {
                      return emptyCartContainer(context);
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: (state is CartLoading)
                            ? 10
                            : (state.cart.length +
                                ((state is CartLoading) ? 10 : 0)),
                        padding: EdgeInsets.only(
                            bottom: AppDimensions.normalize(127)),
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
          /*  isCartError
              ? const SizedBox.shrink()
              :*/
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLogged) {
                return const PaymentDetails(
                  buttonText: "Proceed To Checkout",
                  isFromCheckout: false,
                  isLogged: true,
                );
              } else {
                return const PaymentDetails(
                  buttonText: "Proceed To Checkout",
                  isFromCheckout: false,
                  isLogged: false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
