import 'package:flutter/material.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppDimensions.normalize(7)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SIGNUP",
            style: AppText.b1b?.copyWith(color: AppColors.GreyText),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: Space.all(1, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SIGNUP",
                  style: AppText.h2b?.copyWith(color: AppColors.CommonBlue),
                ),
                Space.y!,
                Text(
                  "Create New Account",
                  style: AppText.h3?.copyWith(color: AppColors.GreyText),
                ),
                Space.y2!,
                Text(
                  "Full Name*",
                  style: AppText.b1b,
                ),
                Container(
                  height: AppDimensions.normalize(20),
                  padding: Space.h1,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Center(
                      child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hoverColor: Colors.grey,
                      iconColor: Colors.grey,
                      focusColor: Colors.grey,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
