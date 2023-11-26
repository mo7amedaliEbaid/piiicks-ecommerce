import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/adress_row.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';

import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../domain/entities/delivery/delivery_info.dart';

class AdressCard extends StatelessWidget {
  final DeliveryInfo? deliveryInformation;
  final bool isSelected;
  final bool isfromCheckout;

  const AdressCard(
      {Key? key,
      this.deliveryInformation,
      this.isSelected = false,
      this.isfromCheckout = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (deliveryInformation != null) {
      return Container(
        margin: EdgeInsets.only(top: AppDimensions.normalize(14)),
        width: double.infinity,
        child: DottedBorder(
          color: Colors.black54,
          strokeWidth: .5,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.addadress,
                  arguments: deliveryInformation);
            },
            child: Padding(
              padding: Space.all(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryInformation!.city,
                    style: AppText.h2b,
                  ),
                  AdressRow("Full Name : ",
                      "${deliveryInformation!.firstName} ${deliveryInformation!.lastName}"),
                  AdressRow("Line 1 : ", deliveryInformation!.addressLineOne),
                  AdressRow("Line 2 : ", deliveryInformation!.addressLineTwo),
                  AdressRow("Zip Code : ", deliveryInformation!.zipCode),
                  AdressRow(
                      "Contact Number : ", deliveryInformation!.contactNumber),
                  Space.yf(1.2),
                  isfromCheckout
                      ? Container(
                          width: double.infinity,
                          padding: Space.v1,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.CommonCyan, width: 1),
                          ),
                          child: Center(
                              child: Text(
                            "Change Address",
                            style: AppText.h3b
                                ?.copyWith(color: AppColors.CommonCyan),
                          )),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<DeliveryInfoActionCubit>()
                                    .selectDeliveryInfo(deliveryInformation!);
                              },
                              child: isSelected
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Selected",
                                          style: AppText.b1b
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      ],
                                    )
                                  : Text(
                                      "Select",
                                      style: AppText.b1b
                                          ?.copyWith(color: Colors.white),
                                    )),
                        ),
                  Space.yf()
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return LoadingShimmer(isSquare: false);
    }
  }
}
