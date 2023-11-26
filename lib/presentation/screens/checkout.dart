import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/presentation/widgets/adress_card.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../domain/entities/cart/cart_item.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key, required this.items});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("CHECKOUT", true),
      body: Column(
        children: [
          BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
            builder: (context, state) {
              if (state.deliveryInformation.isNotEmpty &&
                  state.selectedDeliveryInformation != null) {
                return AdressCard(
                  deliveryInformation: state.selectedDeliveryInformation!,
                  isfromCheckout: true,
                );

                /*Container(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 12, left: 4, right: 10),
                  child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.selectedDeliveryInformation!.firstName} ${state.selectedDeliveryInformation!.lastName}, ${state.selectedDeliveryInformation!.contactNumber}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${state.selectedDeliveryInformation!.addressLineOne}, ${state.selectedDeliveryInformation!.addressLineTwo}, ${state.selectedDeliveryInformation!.city}, ${state.selectedDeliveryInformation!.zipCode}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                );*/
              } else {
                return Container(
                  height: 50,
                  padding: const EdgeInsets.only(top: 20, bottom: 8, left: 4),
                  child: const Text(
                    "Please select delivery information",
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
