import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:piiicks/configs/configs.dart';

import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';
import '../../core/router/app_router.dart';

Widget unloggedProfileContainer(BuildContext context){
  return Container(
    padding: Space.all(1.3, .7),
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: const AssetImage(
            AppAssets.Profile_bg_png),
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
            Colors.grey.shade700,
            BlendMode.colorBurn),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space.y1!,
        SvgPicture.asset(
          AppAssets.Profile,
          colorFilter: const ColorFilter.mode(
              AppColors.CommonCyan, BlendMode.srcIn),
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
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRouter.login);
            },
            child: Text(
              "Login",
              style: AppText.h3b
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRouter.signup);
          },
          child: Container(
            padding: Space.vf(.75),
            margin: Space.v1,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(5),
                border: Border.all(
                    color: AppColors.CommonCyan,
                    width: 1)),
            child: Center(
              child: Text(
                "Signup",
                style: AppText.h3b?.copyWith(
                    color: AppColors.CommonCyan),
              ),
            ),
          ),
        ),
        Space.yf(.6)
      ],
    ),
  );
}