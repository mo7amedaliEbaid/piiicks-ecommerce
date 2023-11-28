import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/custom_textfield.dart';
import 'package:piiicks/presentation/widgets/mobile_number_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constant/strings.dart';
import '../widgets/textfield_toptext.dart';

class ContactScreen extends StatelessWidget {
   ContactScreen({super.key});

  final TextEditingController _contactTextEditingController=TextEditingController();

  void launchWhatsApp(
      {required String phone,
        required String message,
      }) async {
    String url() {
      if (Platform.isAndroid) {
       return "https://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("CONTACT", context, automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      onPressed: () async{
                        launchWhatsApp(phone: phoneNumber, message: 'Hello');
                      },
                      child: Text(
                        "Contact",
                        style: AppText.b1b?.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: Space.all(1,1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("GET IN TOUCH",style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),),
                  TextFieldTopText("Full Name*"),
                  buildTextFormField(_contactTextEditingController, "Name"),
                  Space.yf(.5),
                  TextFieldTopText("Email Address*"),
                  buildTextFormField(_contactTextEditingController, "Address"),
                  Space.yf(.5),
                  TextFieldTopText("Mobile Number*"),
                  MobileNumberTextField(_contactTextEditingController, "mobile number"),
                  Space.yf(.5),
                  TextFieldTopText("Message*"),
                  buildTextFormField(_contactTextEditingController, "message"),
                  Space.yf(1.2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: Text(
                    "Send",
                    style: AppText.h3b
                        ?.copyWith(color: Colors.white),
                  ),
                ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
