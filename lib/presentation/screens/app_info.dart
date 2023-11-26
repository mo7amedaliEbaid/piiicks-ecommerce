import 'package:flutter/material.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

import '../../core/constant/strings.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key, required this.screenTitle});

  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenTitle, true),
      body: SingleChildScrollView(
        child: Padding(
          padding: Space.all(1, .1),
          child: Column(
            children: [
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(1.5),
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(1.5),
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(1.5),
              const Text(
                infoText,
                style: TextStyle(height: 2),
              ),
              Space.yf(2.5),
            ],
          ),
        ),
      ),
    );
  }
}
