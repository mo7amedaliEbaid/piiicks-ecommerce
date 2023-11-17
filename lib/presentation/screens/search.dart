import 'package:flutter/material.dart';
import 'package:piiicks/configs/configs.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../core/constant/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppDimensions.normalize(20)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimensions.normalize(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                Space.xf(6),
                Text(
                  "SEARCH",
                  style: AppText.b1b?.copyWith(color: AppColors.GreyText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
