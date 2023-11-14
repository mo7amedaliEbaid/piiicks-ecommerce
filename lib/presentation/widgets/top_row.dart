import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/space.dart';
import '../../shared/constant/assets.dart';

Widget TopRow({required bool isFromHome}) {
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
                  const Icon(Icons.favorite_border),
                  Space.xf(),
                  const Icon(Icons.search),
                ],
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}
