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
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/textfield_toptext.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final TextEditingController _contactTextEditingController =
      TextEditingController();

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrl(Uri.parse(url));
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: AppDimensions.normalize(7)),
                          child: SvgPicture.asset(AppAssets.Whatsapp),
                        ),
                        Space.yf(.8),
                        Text(
                          "CONTACT US ON WHATSAPP",
                          style: AppText.b1b
                              ?.copyWith(color: AppColors.CommonCyan),
                        )
                      ]),
                  SizedBox(
                    width: AppDimensions.normalize(45),
                    child: ElevatedButton(
                      onPressed: () async {
                        _openUrl("https://wa.me/+201016381636");
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
              padding: Space.all(1, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GET IN TOUCH",
                    style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                  ),
                  TextFieldTopText("Full Name*"),
                  buildTextFormField(_contactTextEditingController, "Name"),
                  Space.yf(.5),
                  TextFieldTopText("Email Address*"),
                  buildTextFormField(_contactTextEditingController, "Address"),
                  Space.yf(.5),
                  TextFieldTopText("Mobile Number*"),
                  MobileNumberTextField(
                      _contactTextEditingController, "mobile number"),
                  Space.yf(.5),
                  TextFieldTopText("Message*"),
                  buildTextFormField(_contactTextEditingController, "message"),
                  Space.yf(1.2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: AppDimensions.normalize(75),
                                  padding: Space.all(1, 1.5),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "THANKS",
                                          style: AppText.b1b,
                                        ),
                                        Space.yf(.5),
                                        Text(
                                          "Thanks For Your Message!\nWe Will Contact You Soon.",
                                          style:
                                              AppText.b1?.copyWith(height: 1.8),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                _contactTextEditingController
                                                    .clear();
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Ok",
                                                style: AppText.h3b?.copyWith(
                                                  color: AppColors.CommonCyan,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "Send",
                        style: AppText.h3b?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
