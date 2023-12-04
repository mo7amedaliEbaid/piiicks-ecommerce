import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/router/app_router.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';

PreferredSizeWidget CustomAppBar(
  String title,
  BuildContext context, {
  bool doesHasCartIcom = false,
  bool automaticallyImplyLeading = false,
}) {
  return PreferredSize(
    preferredSize: Size(double.infinity, AppDimensions.normalize(30)),
    child: Padding(
      padding: EdgeInsets.only(top: AppDimensions.normalize(10)),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(
          title,
          style: AppText.b1b?.copyWith(color: AppColors.GreyText),
        ),
        actions: [
          doesHasCartIcom
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.cart);
                  },
                  child: Padding(
                    padding: Space.h1!,
                    child: SvgPicture.asset(
                      AppAssets.Cart,
                      color: AppColors.CommonCyan,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    ),
  );
}
