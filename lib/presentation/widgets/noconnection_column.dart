// Usually this Widget will appear if you open the app for the first
// time without internet connection.
// If its not the first time the app will use cached data.
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/core/constant/assets.dart';

import '../../application/products_bloc/product_bloc.dart';
import '../../core/constant/colors.dart';
import '../../data/models/product/filter_params_model.dart';

class NoConnectionColumn extends StatefulWidget {
  const NoConnectionColumn({super.key, required this.isFromCategories});

  final bool isFromCategories;

  @override
  State<NoConnectionColumn> createState() => _NoConnectionColumnState();
}

class _NoConnectionColumnState extends State<NoConnectionColumn> {
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space.yf(2),
            SvgPicture.asset(AppAssets.PiiicksAppBar),
            Space.yf(3),
            SvgPicture.asset(AppAssets.BadConnection),
            Space.yf(3),
            Text(
              "NO INTERNET CONECTION\nServer Error".toUpperCase(),
              style: AppText.h2b
                  ?.copyWith(color: AppColors.CommonCyan, height: 1.7,),
              textAlign: TextAlign.center,
            ),
            Space.yf(2),
            Text(
              "PLEASE CHECK YOUR ( WI-FI / DATA)\nINTERNET CONNECTION\nOR TRY AGAIN LATER.",
              style: AppText.h3?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            Space.yf(2),
            Image.asset(AppAssets.Curves_bg_png),
            Space.yf(1.5),
            Padding(
              padding: Space.hf(),
              child: Material(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.isFromCategories
                          ? Phoenix.rebirth(context)
                          : context
                              .read<ProductBloc>()
                              .add(const GetProducts(FilterProductParams()));
                      setState(() {
                        startLoading();
                      });
                    },
                    child: Text(
                      isLoading ? "Wait..." : "Try Again",
                      style: AppText.b1b?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Space.yf(1.5),
          ],
        ),
      ),
    );
  }
}
