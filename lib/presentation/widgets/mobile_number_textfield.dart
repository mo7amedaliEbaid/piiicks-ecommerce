import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import 'custom_textfield.dart';

Widget MobileNumberTextField(
    TextEditingController controller, String hintText) {
  return Row(
    children: [
      Flexible(
        flex: 1,
        child: Container(
          width: AppDimensions.normalize(30),
          height: AppDimensions.normalize(20),
          decoration: const BoxDecoration(color: Colors.black),
          child: Center(
              child: Text(
            "+20",
            style: AppText.b1b?.copyWith(color: Colors.white),
          )),
        ),
      ),
      Flexible(
        flex: 4,
        child: buildTextFormField(controller, hintText),
      ),
    ],
  );
}
