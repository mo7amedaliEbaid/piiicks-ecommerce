import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/presentation/widgets/top_row.dart';

import '../../core/constant/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Space.hf(1.1),
        child: SafeArea(
          minimum: EdgeInsets.only(top: AppDimensions.normalize(20)),
          child: Column(
            children: [
              TopRow(isFromHome: false, context: context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space.y!,
                      Container(
                        // height: AppDimensions.normalize(10),
                        padding: Space.all(1.3, .7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage(Assets.Profile_bg_png),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.grey.shade700, BlendMode.colorBurn),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Space.y1!,
                            SvgPicture.asset(
                              Assets.Profile,
                              color: AppColors.CommonCyan,
                              height: AppDimensions.normalize(19),
                            ),
                            Space.y1!,
                            Text(
                              "Login/Signup",
                              style: AppText.h2b,
                            ),
                            Space.yf(.9),
                            Text(
                              "Join The Hub!",
                              style: AppText.b1,
                            ),
                            Space.yf(1.2),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: null,
                                child: Text(
                                  "Login",
                                  style: AppText.h3b
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              padding: Space.vf(.75),
                              margin: Space.v1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.CommonCyan, width: 1)),
                              child: Center(
                                child: Text(
                                  "Signup",
                                  style: AppText.h3b
                                      ?.copyWith(color: AppColors.CommonCyan),
                                ),
                              ),
                            ),
                            Space.yf(.6)
                          ],
                        ),
                      ),
                      Space.yf(1.5),
                      Text(
                        "SETTINGS",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                      Space.yf(.9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.Bell),
                              Space.xf(),
                              Text(
                                "Notifications",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppDimensions.normalize(10),
                            child: Switch(
                              value: true,
                              onChanged: null,
                              activeTrackColor: AppColors.CommonCyan,
                              thumbColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                          )
                        ],
                      ),
                      Space.yf(1.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.Globe),
                              Space.xf(),
                              Text(
                                "Preferred Language",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "English",
                                style: AppText.b2b
                                    ?.copyWith(color: AppColors.CommonCyan),
                              ),
                              Space.xf(.2),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ],
                      ),
                      Space.yf(1.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.Money),
                              Space.xf(),
                              Text(
                                "Currency",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Dollars",
                                style: AppText.b2b
                                    ?.copyWith(color: AppColors.CommonCyan),
                              ),
                              Space.xf(.2),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ],
                      ),
                      Space.yf(2),
                      Text(
                        "SUPPORT",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                      Space.yf(1.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.Document),
                              Space.xf(),
                              Text(
                                "Terms & Conditions",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Space.yf(1.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.Document),
                              Space.xf(),
                              Text(
                                "Privacy Policy",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Space.yf(1.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.Comments),
                              Space.xf(),
                              Text(
                                "Contact",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Space.yf(2.9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "V.1.0",
                            style: AppText.b1b,
                          )
                        ],
                      ),
                      Space.yf(.3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           SvgPicture.asset(Assets.Whats,height: AppDimensions.normalize(15),),
                          SvgPicture.asset(Assets.Noti,height: AppDimensions.normalize(15),),
                          SvgPicture.asset(Assets.Music,height: AppDimensions.normalize(15),),
                        ],
                      ),
                      Space.yf(1.3),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
