import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/bottom_nav_container.dart';

import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';

class OrderFailureScreen extends StatelessWidget {
  const OrderFailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            Space.yf(3),
            SvgPicture.asset(
              AppAssets.OrderError,
              height: AppDimensions.normalize(30),
            ),
            Space.yf(2),
            Text(
              "ERROR!",
              style: AppText.h3b,
            ),
            Space.yf(1.5),
            Text(
              "An error occurred while placing an order.",
              style: AppText.h3,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Space.yf(2),
            Text(
              "Please Try again!",
              style: AppText.h3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavContainer(
        "Try Again",
        () {
          Navigator.of(context).pushNamed(AppRouter.cart);
        },
      ),
    );
  }
}
