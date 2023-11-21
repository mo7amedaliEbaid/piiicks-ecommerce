import 'package:flutter/material.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/space.dart';
import '../../core/constant/colors.dart';

Widget CustomTextField({required String hintText}) {
  return Container(
    height: AppDimensions.normalize(20),
    padding: Space.h1,
    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    child: Center(
      child: TextField(
        cursorColor: AppColors.CommonCyan,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 10,
              color: AppColors.GreyText,
              fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}
