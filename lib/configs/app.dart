import 'package:flutter/material.dart';

import 'space.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';
import 'ui.dart';
import 'ui_props.dart';
import 'app_theme.dart';

class App {
  static bool? isLtr;
  static bool showAds = false;

  static init(BuildContext context) {
    UI.init(context);
    AppDimensions.init();
    AppTheme.init(context);
    UIProps.init();
    Space.init();
    AppText.init();
    isLtr = Directionality.of(context) == TextDirection.ltr;
  }

  static flag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );
  }
}
