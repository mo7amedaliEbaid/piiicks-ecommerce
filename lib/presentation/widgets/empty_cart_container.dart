import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../configs/configs.dart';
import '../../core/constant/colors.dart';
import '../../core/enums/enums.dart';

Widget emptyCartContainer(BuildContext context) {
  return Container(
    color: AppColors.LightGrey,
    margin: EdgeInsets.only(top: AppDimensions.normalize(60)),
    //  height: AppDimensions.normalize(45),
    padding: Space.all(1, 2.5),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "NO ITEMS IN CART",
            style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
          ),
          Space.yf(),
          Text(
            "We Have Found No Items Added",
            style: AppText.b1,
          ),
          Space.yf(),
          Text(
            "In Your Cart To Checkout",
            style: AppText.b1,
          ),
          Space.yf(1.5),
          SizedBox(
            width: AppDimensions.normalize(50),
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<NavigationCubit>()
                    .updateTab(NavigationTab.productsTap);
              },
              child: Text(
                "Add Items",
                style: AppText.h3b?.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
