import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/constant/colors.dart';

Widget TransparentButton({
  required BuildContext context,
  required void Function() onTap,
  required String buttonText,
}) {
  return SizedBox(
    width: double.infinity,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Space.vf(.8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.CommonCyan),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
          ),
        ),
      ),
    ),
  );
}
