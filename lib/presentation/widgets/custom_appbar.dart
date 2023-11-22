import 'package:flutter/material.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../core/constant/colors.dart';

PreferredSizeWidget CustomAppBar(String title){
  return  PreferredSize(
      child: Padding(
        padding: EdgeInsets.only(top: AppDimensions.normalize(10)),
        child: AppBar(
          title: Text(
            title,
            style: AppText.b1b?.copyWith(color: AppColors.GreyText),
          ),
        ),
      ),
      preferredSize: Size(double.infinity, AppDimensions.normalize(30)));
}