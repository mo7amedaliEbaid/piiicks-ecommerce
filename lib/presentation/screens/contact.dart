import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("CONTACT", context,automaticallyImplyLeading: true),
      body: Column(
        children: [
          Container(
            color: AppColors.LightGrey,
            padding: Space.all(1, 1),
            margin: Space.vf(.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppDimensions.normalize(7)),
                    child: SvgPicture.asset(Assets.Whatsapp),
                  ),
                  Space.yf(.8),
                  Text(
                    "CONTACT US ON WHATSAPP",
                    style: AppText.b1b?.copyWith(color: AppColors.CommonCyan),
                  )
                ]),
                SizedBox(
                    width: AppDimensions.normalize(45),
                    child: ElevatedButton(
                        onPressed: null,
                        child: Text(
                          "Contact",
                          style: AppText.b1b?.copyWith(color: Colors.white),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
