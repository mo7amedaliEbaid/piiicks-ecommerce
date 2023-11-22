import 'package:flutter/material.dart';

import '../../configs/app_typography.dart';
import '../../configs/space.dart';

Widget AdressRow(String leftText,String rightText ){
  return Column(
    children: [
      Space.yf(.6),
      Row(
        children: [
          Text(
           leftText   ,
              style: AppText.b1b
          ),
          Text(
              rightText,
              style: AppText.b1
          ),
        ],
      ),
    ],
  );
}