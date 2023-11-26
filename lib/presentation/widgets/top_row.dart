import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/space.dart';
import '../../core/constant/assets.dart';
import '../../core/router/app_router.dart';
import '../screens/wishlist.dart';

Widget TopRow({required bool isFromHome, required BuildContext context}) {
  return SizedBox(
    height: AppDimensions.normalize(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          Assets.PiiicksAppBar,
          width: AppDimensions.normalize(12),
          height: AppDimensions.normalize(15),
          fit: BoxFit.fill,
        ),
        isFromHome
            ? Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.wishlist);
                      },
                      child: const Icon(Icons.favorite_border)),
                  Space.xf(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.search);
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}
