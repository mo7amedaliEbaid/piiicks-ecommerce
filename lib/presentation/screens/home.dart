import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/shared/constant/assets.dart';
import 'package:piiicks/shared/constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: Space.vf(3),
        child: Padding(
          padding: Space.h1!,
          child: Column(
            children: [
              SizedBox(
                height: AppDimensions.normalize(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      Assets.PiiicksAppBar,
                      width: AppDimensions.normalize(12),
                      height: AppDimensions.normalize(15),
                      fit: BoxFit.fill,
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite_border),
                        Space.xf(),
                        Icon(Icons.search),
                      ],
                    )
                  ],
                ),
              ),
              Space.yf(.2),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppDimensions.normalize(110),
                      child: Stack(
                        children: [
                          PageView.builder(
                              controller: _pageController,
                              onPageChanged: (pos) {
                                setState(() {
                                  currentPage = pos;
                                });
                              },
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return SvgPicture.asset(
                                  Assets.PiiicksIcon,
                                  fit: BoxFit.cover,
                                );
                              }),
                          Positioned(
                            bottom: AppDimensions.normalize(2),
                            left: 0,
                            right: 0,
                            child: _dotsindicator(
                              _pageController.hasClients
                                  ? _pageController.page?.round()
                                  : 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: Space.v2!,
                      child: Text(
                        "FEATURED CATEGORIES",
                        style: AppText.h2b?.copyWith(color: AppColors.CommonBlue),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dotsindicator(int? dotsindex) {
    return DotsIndicator(
      dotsCount: 3,
      position: dotsindex!,
      decorator: DotsDecorator(
          color: Colors.white,
          activeColor: Colors.black,
          size: Size.fromRadius(
            AppDimensions.normalize(2.5),
          ),
          activeSize: Size.fromRadius(AppDimensions.normalize(2.5))),
    );
  }
}
