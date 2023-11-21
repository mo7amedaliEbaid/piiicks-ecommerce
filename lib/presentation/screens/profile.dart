import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piiicks/core/constant/assets.dart';

import '../../core/constant/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Column(
          children: [
            SizedBox(height: 100,),
            Stack(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    color: Colors.cyanAccent,
                    child: SvgPicture.asset(
                      Assets.Profile_bg,
                      color: AppColors.CommonCyan,
                    )),
                Text("jhj")
              ],
            )
          ],
      ),
       ),
    );
  }
}
