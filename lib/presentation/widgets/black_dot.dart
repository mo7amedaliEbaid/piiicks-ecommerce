import 'package:flutter/material.dart';

import '../../configs/app_dimensions.dart';

Widget BlackDot() {
  return Container(
    height: AppDimensions.normalize(3),
    width: AppDimensions.normalize(3),
    margin: EdgeInsets.only(bottom: AppDimensions.normalize(10)),
    decoration:
        const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
  );
}
