import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/constant/colors.dart';

Widget transparentButton({
  required BuildContext context,
  required void Function() onTap,
  required String buttonText,
}) {
  return SizedBox(
    width: double.infinity,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Space.vf(.77),
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

/*Widget transparentButton({
  required BuildContext context,
  required void Function() onTap,
  required String buttonText,
}) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(shape: const RoundedRectangleBorder()),
      child: Text(
        buttonText,
        style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
      ),
    ),
  );
}*/
