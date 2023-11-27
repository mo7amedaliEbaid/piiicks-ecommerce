import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/core/router/app_router.dart';
import '../../configs/app.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Assets.Ads,
                    ),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              bottom: AppDimensions.normalize(10),
              right: AppDimensions.normalize(8),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.mainscreen,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Skip".toUpperCase(),
                    style: AppText.h3b,
                  ))),
        ],
      ),
    );
  }
}
