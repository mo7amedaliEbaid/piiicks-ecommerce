import 'package:flutter/material.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/app_dimensions.dart';

Widget LoadingShimmer({required bool isSquare}) {
  return Padding(
    padding: Space.v1!,
    child: Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
      child: Card(
        color: Colors.grey.shade100,
        elevation: 4,
        margin: const EdgeInsets.only(right: 16),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: AppDimensions.normalize(70),
          width: isSquare ? AppDimensions.normalize(70) : double.infinity,
        ),
      ),
    ),
  );
}
Widget placeholderShimmer(){
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.white,
    child: Container(),
  );
}
