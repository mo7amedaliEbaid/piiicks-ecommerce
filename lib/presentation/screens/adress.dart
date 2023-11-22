import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../widgets/adress_card.dart';

class AdressScreen extends StatefulWidget {
  const AdressScreen({Key? key}) : super(key: key);

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        if (state is DeliveryInfoActionLoading) {
        } else if (state is DeliveryInfoSelectActionSuccess) {
          context
              .read<DeliveryInfoFetchCubit>()
              .selectDeliveryInfo(state.deliveryInfo);
        } else if (state is DeliveryInfoActionFail) {}
      },
      child: Scaffold(
        appBar: CustomAppBar("ADD ADDRESS"),
        body: Padding(
          padding: Space.all(1.2, 1),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRouter.addadress);
                },
                child: Container(
                  width: double.infinity,
                  padding: Space.v1,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.CommonCyan, width: 1)),
                  child: Center(
                      child: Text(
                    "Add New Address",
                    style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                  )),
                ),
              ),
              BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
                builder: (context, state) {
                  if (state is! DeliveryInfoFetchLoading &&
                      state.deliveryInformation.isEmpty) {
                    return Container(
                      height: AppDimensions.normalize(60),
                      padding: Space.all(0, .7),
                      margin: EdgeInsets.only(top: AppDimensions.normalize(10)),
                      color: AppColors.LightGrey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "NO SAVED ADDRESS",
                              style: AppText.h3b
                                  ?.copyWith(color: AppColors.CommonCyan),
                            ),
                            Space.yf(1),
                            Text(
                              "There Is No Saved Address.",
                              style: AppText.b2,
                            ),
                            Space.yf(1),
                            Text(
                              "Please Save New Address!",
                              style: AppText.b2,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Flexible(
                    child: ListView.builder(
                      itemCount: (state is DeliveryInfoFetchLoading &&
                              state.deliveryInformation.isEmpty)
                          ? 5
                          : state.deliveryInformation.length,
                      itemBuilder: (context, index) => (state
                                  is DeliveryInfoFetchLoading &&
                              state.deliveryInformation.isEmpty)
                          ? const AdressCard()
                          : AdressCard(
                              deliveryInformation:
                                  state.deliveryInformation[index],
                              isSelected: state.deliveryInformation[index] ==
                                  state.selectedDeliveryInformation,
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
