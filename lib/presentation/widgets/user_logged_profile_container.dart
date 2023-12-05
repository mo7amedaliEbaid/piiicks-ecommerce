import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piiicks/configs/configs.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';
import '../../core/enums/enums.dart';

Widget userLoggedProfileContainer(
    BuildContext context, String name, String email) {
  return Container(
    padding: Space.all(1.3, .7),
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: const AssetImage(AppAssets.Profile_bg_png),
        fit: BoxFit.fill,
        colorFilter:
            ColorFilter.mode(Colors.grey.shade700, BlendMode.colorBurn),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space.yf(1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AppAssets.Profile,
              colorFilter:
                  const ColorFilter.mode(AppColors.CommonCyan, BlendMode.srcIn),
              //    color: AppColors.CommonCyan,
              height: AppDimensions.normalize(19),
            ),
            SizedBox(
              width: AppDimensions.normalize(45),
              height: AppDimensions.normalize(22),
              child: ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(SignOutUser());
                  context
                      .read<NavigationCubit>()
                      .updateTab(NavigationTab.homeTab);
                  /* context.read<CartBloc>().add(const ClearCart());
                                            context
                                                .read<DeliveryInfoFetchCubit>()
                                                .clearLocalDeliveryInfo();
                                            context.read<OrderFetchCubit>().clearLocalOrders();*/
                },
                child: Text(
                  "Logout",
                  style: AppText.h3b?.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Space.y1!,
        Text(
          name,
          style: AppText.h2b,
        ),
        Space.yf(.7),
        Text(
          email,
          style: AppText.h3,
        ),
        Space.yf(1.2),
      ],
    ),
  );
}
