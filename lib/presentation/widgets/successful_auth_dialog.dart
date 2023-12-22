import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../configs/configs.dart';
import '../../core/constant/colors.dart';
import '../../core/router/app_router.dart';

Future<void> showSuccessfulAuthDialog(BuildContext context, String text) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: AppDimensions.normalize(77),
          padding: Space.all(1, 1.05),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SUCCESSFULLY ${text.toUpperCase()}",
                  style: AppText.b1b,
                ),
                Space.yf(.6),
                Text(
                  "Congratulations,\nYour Account Has Been Successfully $text!",
                  style: AppText.b1?.copyWith(height: 1.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<CartBloc>().add(const GetCart());
                        context
                            .read<DeliveryInfoFetchCubit>()
                            .fetchDeliveryInfo();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouter.root,
                          ModalRoute.withName(''),
                        );
                      },
                      child: Text(
                        "Ok",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
