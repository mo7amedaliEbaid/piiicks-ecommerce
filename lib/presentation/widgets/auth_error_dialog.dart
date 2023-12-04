import 'package:flutter/material.dart';
import 'package:piiicks/configs/configs.dart';

import '../../core/constant/colors.dart';

Future<void> showAuthErrorDialog(BuildContext context) async{
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: AppDimensions.normalize(50),
            padding: Space.all(1, .5),
            child: Center(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Error",
                    style: AppText.b1b,
                  ),
                  Space.yf(.5),
                  Text(
                    "Try Again!",
                    style: AppText.b1,
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Dismiss",
                          style: AppText.h3b?.copyWith(
                              color:
                              AppColors.CommonCyan,),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}