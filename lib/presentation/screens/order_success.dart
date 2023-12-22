import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/bottom_nav_container.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/notifications_cubit/notifications_cubit.dart';
import '../../core/enums/enums.dart';
import '../../core/router/app_router.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>().showAndSaveNotification(
        "Orders Update",
        "Congratulations, You have successfully Placed a New Order.");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: AppColors.LightGrey,
                    padding: Space.all(4, 4),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.PiiicksAppBar,
                        height: AppDimensions.normalize(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppDimensions.normalize(5),
                    left: AppDimensions.normalize(4),
                    child: IconButton(
                      onPressed: () {
                        /*    context
                              .read<NavigationCubit>()
                              .updateTab(NavigationTab.homeTab);*/
                        context.read<CartBloc>().add(const ClearCart());
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouter.root,
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
              Space.yf(3),
              SvgPicture.asset(
                AppAssets.OrderSuccess,
                height: AppDimensions.normalize(30),
              ),
              Space.yf(2),
              Text(
                "Order Successfully Submitted",
                style: AppText.h3b,
              ),
              Space.yf(1.5),
              Text(
                "Your order has been successfully submitted",
                style: AppText.h3,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Padding(
                      padding: Space.all(1, 2.2),
                      child: DottedBorder(
                        strokeWidth: .5,
                        child: Container(
                          padding: Space.all(1.5, 1.5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Order Date",
                                        style: AppText.h3?.copyWith(
                                            color: AppColors.GreyText),
                                      ),
                                      Space.yf(.8),
                                      Text(
                                        DateTime.now()
                                            .toString()
                                            .substring(0, 10),
                                        style: AppText.h3b,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Order No.",
                                        style: AppText.h3?.copyWith(
                                            color: AppColors.GreyText),
                                      ),
                                      Space.yf(.8),
                                      Text(
                                        "#00002",
                                        style: AppText.h3b,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Space.yf(2.2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Items",
                                        style: AppText.h3?.copyWith(
                                            color: AppColors.GreyText),
                                      ),
                                      Space.yf(.8),
                                      Text(
                                        state.cart.length.toString(),
                                        style: AppText.h3b,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Total",
                                        style: AppText.h3?.copyWith(
                                            color: AppColors.GreyText),
                                      ),
                                      Space.yf(.8),
                                      Text(
                                        "${state.cart.fold(0.0, (previousValue, element) => (element.priceTag.price + previousValue)) + 5}",
                                        style: AppText.h3b,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavContainer(
        "My Orders",
        () {
          context.read<CartBloc>().add(const ClearCart());
          Navigator.of(context).pushNamed(AppRouter.orders);
        },
      ),
    );
  }
}
