import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/core/constant/colors.dart';

import '../../application/filter_cubit/filter_cubit.dart';

class PriceRangeSlider extends StatefulWidget {
  final double initMin;
  final double initMax;

  const PriceRangeSlider({
    super.key,
    required this.initMin,
    required this.initMax,
  });

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  final double max = 10000;
  final double min = 0;
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.initMin, widget.initMax);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PriceRangeSlider oldWidget) {
    _currentRangeValues = RangeValues(widget.initMin, widget.initMax);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.LightGrey,
      padding: EdgeInsets.only(bottom: AppDimensions.normalize(7)),
      child: RangeSlider(
        values: _currentRangeValues,
        max: max,
        divisions: 10,
        activeColor: AppColors.CommonCyan,
        inactiveColor: Colors.grey,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          if (values.start < values.end) {
            setState(() {
              _currentRangeValues = values;
              context.read<FilterCubit>().updateRange(
                  _currentRangeValues.start, _currentRangeValues.end);
            });
          }
        },
      ),
    );
  }
}
