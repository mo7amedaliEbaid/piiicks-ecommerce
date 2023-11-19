import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../configs/app_dimensions.dart';

Widget Dotsindicator({int? dotsIndex, required int dotsCount,required Color activeColor}) {
  return DotsIndicator(
    dotsCount: dotsCount,
    position: dotsIndex!,
    decorator: DotsDecorator(
        color: Colors.white,
        activeColor: activeColor,
        size: Size.fromRadius(
          AppDimensions.normalize(2.5),
        ),
        activeSize: Size.fromRadius(AppDimensions.normalize(2.5))),
  );
}
