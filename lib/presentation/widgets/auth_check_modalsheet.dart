import 'package:flutter/material.dart';

import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

import '../../core/router/app_router.dart';

Future<void> showAuthCheckModalSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
        maxHeight: AppDimensions.normalize(130),
        minHeight: AppDimensions.normalize(130),
        minWidth: double.infinity,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: Space.all(1.5, 1.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CONTINUE",
                style: AppText.h3b,
              ),
              Space.yf(.7),
              Text(
                "Continue as a guest or login/signup",
                style: AppText.b1,
              ),
              Space.yf(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.login);
                    },
                    child: Text(
                      "Login",
                      style: AppText.b1b?.copyWith(color: Colors.white),
                    )),
              ),
              Space.yf(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.signup);
                    },
                    child: Text(
                      "Signup",
                      style: AppText.b1b?.copyWith(color: Colors.white),
                    )),
              ),
              Space.yf(),
              TransparentButton(
                  context: context,
                  onTap: () {},
                  buttonText: "Continue as a Guest")
            ],
          ),
        );
      });
}
