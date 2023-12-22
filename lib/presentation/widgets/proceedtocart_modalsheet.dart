import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../core/enums/enums.dart';
import '../../core/router/app_router.dart';

Future<void> showPoceedtoCartBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xfff6f6f6),
    constraints: BoxConstraints(
        minHeight: AppDimensions.normalize(120), maxWidth: double.infinity),
    builder: (BuildContext context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
              top: AppDimensions.normalize(12),
              left: AppDimensions.normalize(8),
              right: AppDimensions.normalize(8),
              bottom: AppDimensions.normalize(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "CONTINUE",
                style: AppText.h3b,
              ),
              Space.yf(1),
              const Text("Lorem Ipsum is simply dummy text of the"),
              Space.yf(.2),
              const Text("printing and typesetting industry."),
              Space.yf(2),
              transparentButton(
                  context: context,
                  onTap: () {
                    context
                        .read<NavigationCubit>()
                        .updateTab(NavigationTab.cartTab);
                    Navigator.popAndPushNamed(context, AppRouter.root);
                  },
                  buttonText: "Proceed to Cart"),
              Space.yf(1.5),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<NavigationCubit>()
                        .updateTab(NavigationTab.productsTap);
                    Navigator.popAndPushNamed(context, AppRouter.root);
                  },
                  child: Text(
                    "Continue Shopping",
                    style: AppText.h3b?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
