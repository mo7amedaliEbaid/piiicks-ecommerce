import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../configs/configs.dart';
import '../../core/constant/colors.dart';

Widget errorContainer(BuildContext context, bool isFromCart) {
  return Container(
    color: isFromCart ? AppColors.LightGrey : Colors.transparent,
    margin: isFromCart
        ? EdgeInsets.only(top: AppDimensions.normalize(40))
        : EdgeInsets.zero,
    padding: Space.vf(1.5),
    child: Center(
      child: Column(
        children: [
          Text(
            isFromCart
                ? "Error Occured While Loading Cart"
                : "Error Occured While Loading Items",
            style: AppText.h3b,
          ),
          Space.yf(2),
          ElevatedButton(
              onPressed: () {
                Phoenix.rebirth(context);
              },
              child: Text(
                "Restart",
                style: AppText.h3b?.copyWith(color: Colors.white),
              ))
        ],
      ),
    ),
  );
}
