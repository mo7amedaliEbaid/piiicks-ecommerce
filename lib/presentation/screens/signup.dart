import 'package:flutter/material.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/custom_textfield.dart';

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
                  style: AppText.h2b?.copyWith(color: AppColors.CommonCyan),
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
                Space.y!,
                CustomTextField(hintText: "Enter Your Full Name"),
                Space.yf(1.5),
                Text(
                  "Email Address*",
                  style: AppText.b1b,
                ),
                Space.y!,
                CustomTextField(hintText: "Enter your Email Address"),
                Space.yf(1.5),
                Text(
                  "Password*",
                  style: AppText.b1b,
                ),
                Space.y!,
                CustomTextField(hintText: "Enter your Password"),
                Space.yf(1.5),
                Text(
                  "Confirm Password*",
                  style: AppText.b1b,
                ),
                Space.y!,
                CustomTextField(hintText: "Enter your Password"),
                Space.yf(1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_box_outline_blank_outlined,
                      color: Colors.black,
                    ),
                    Space.x!,
                    Text(
                      "I Accept All Privacy Policies And Terms & Conditions Of ",
                      style: AppText.l1,
                    ),
                    Text(
                      "Piicks!",
                      style: AppText.b2b,
                    )
                  ],
                ),
                Space.yf(1.5),
                ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size(
                          double.infinity,
                          AppDimensions.normalize(20),
                        ),
                      ),
                    ),
                    child: Text(
                      "Signup",
                      style: AppText.h3b?.copyWith(color: Colors.white),
                    )),
                Space.yf(1.5),
                Center(
                    child: Text(
                  "Already Have an Account?",
                  style: AppText.b1b,
                )),
                Space.y1!,
                Container(
                  height: AppDimensions.normalize(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border:
                          Border.all(width: 1, color: AppColors.CommonCyan)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
