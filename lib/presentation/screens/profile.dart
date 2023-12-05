import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/presentation/widgets/top_row.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../core/constant/colors.dart';
import '../../core/enums/enums.dart';
import '../../core/router/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Space.hf(1.1),
        child: SafeArea(
          minimum: EdgeInsets.only(top: AppDimensions.normalize(20)),
          child: Column(
            children: [
              TopRow(isFromHome: false, context: context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space.y!,
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLogged) {
                            return Container(
                              padding: Space.all(1.3, .7),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage(
                                      AppAssets.Profile_bg_png),
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey.shade700,
                                      BlendMode.colorBurn),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space.yf(1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.Profile,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.CommonCyan,
                                            BlendMode.srcIn),
                                        //    color: AppColors.CommonCyan,
                                        height: AppDimensions.normalize(19),
                                      ),
                                      SizedBox(
                                        width: AppDimensions.normalize(45),
                                        height: AppDimensions.normalize(22),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<UserBloc>()
                                                .add(SignOutUser());
                                            context
                                                .read<NavigationCubit>()
                                                .updateTab(
                                                    NavigationTab.homeTab);
                                            /* context.read<CartBloc>().add(const ClearCart());
                                            context
                                                .read<DeliveryInfoFetchCubit>()
                                                .clearLocalDeliveryInfo();
                                            context.read<OrderFetchCubit>().clearLocalOrders();*/
                                          },
                                          child: Text(
                                            "Logout",
                                            style: AppText.h3b
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Space.y1!,
                                  Text(
                                    "${state.user.firstName}!",
                                    style: AppText.h2b,
                                  ),
                                  Space.yf(.7),
                                  Text(
                                    state.user.email,
                                    style: AppText.h3,
                                  ),
                                  Space.yf(1.2),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              padding: Space.all(1.3, .7),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage(
                                      AppAssets.Profile_bg_png),
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey.shade700,
                                      BlendMode.colorBurn),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space.y1!,
                                  SvgPicture.asset(
                                    AppAssets.Profile,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.CommonCyan, BlendMode.srcIn),
                                    height: AppDimensions.normalize(19),
                                  ),
                                  Space.y1!,
                                  Text(
                                    "Login/Signup",
                                    style: AppText.h2b,
                                  ),
                                  Space.yf(.9),
                                  Text(
                                    "Join The Hub!",
                                    style: AppText.b1,
                                  ),
                                  Space.yf(1.2),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(AppRouter.login);
                                      },
                                      child: Text(
                                        "Login",
                                        style: AppText.h3b
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRouter.signup);
                                    },
                                    child: Container(
                                      padding: Space.vf(.75),
                                      margin: Space.v1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColors.CommonCyan,
                                              width: 1)),
                                      child: Center(
                                        child: Text(
                                          "Signup",
                                          style: AppText.h3b?.copyWith(
                                              color: AppColors.CommonCyan),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Space.yf(.6)
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                        if (state is UserLogged) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space.yf(1.9),
                              Text(
                                "MY ACCOUNT",
                                style: AppText.h3b
                                    ?.copyWith(color: AppColors.CommonCyan),
                              ),
                              Space.yf(.9),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.orders);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.Archive),
                                        Space.xf(),
                                        Text(
                                          "My Orders",
                                          style: AppText.b1b,
                                        )
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                              Space.yf(1.1),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.adress);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.Marker),
                                        Space.xf(),
                                        Text(
                                          "Address Book",
                                          style: AppText.b1b,
                                        )
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Space.yf(1.1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.Profile,
                                        // color: AppColors.CommonCyan,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.CommonCyan,
                                            BlendMode.srcIn),
                                      ),
                                      Space.xf(),
                                      Text(
                                        "Edit Account",
                                        style: AppText.b1b,
                                      )
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              Space.yf(1.1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.Lock),
                                      Space.xf(),
                                      Text(
                                        "Change Password",
                                        style: AppText.b1b,
                                      )
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                      Space.yf(1.9),
                      Text(
                        "SETTINGS",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                      Space.yf(.9),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRouter.notifications);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.Bell),
                                Space.xf(),
                                Text(
                                  "Notifications",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            SizedBox(
                              height: AppDimensions.normalize(10),
                              child: Switch(
                                value: true,
                                onChanged: null,
                                activeTrackColor: AppColors.CommonCyan,
                                thumbColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Space.yf(1.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.Globe),
                              Space.xf(),
                              Text(
                                "Preferred Language",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "English",
                                style: AppText.b2b
                                    ?.copyWith(color: AppColors.CommonCyan),
                              ),
                              Space.xf(.2),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ],
                      ),
                      Space.yf(1.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.Money),
                              Space.xf(),
                              Text(
                                "Currency",
                                style: AppText.b1b,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Dollars",
                                style: AppText.b2b
                                    ?.copyWith(color: AppColors.CommonCyan),
                              ),
                              Space.xf(.2),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ],
                      ),
                      Space.yf(2),
                      Text(
                        "SUPPORT",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                      Space.yf(1.2),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.appinfo,
                              arguments: "TERMS & CONDITIONS");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.Document),
                                Space.xf(),
                                Text(
                                  "Terms & Conditions",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      Space.yf(1.1),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.appinfo,
                              arguments: "PRIVACY POLICY");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.Document),
                                Space.xf(),
                                Text(
                                  "Privacy Policy",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      Space.yf(1.1),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.contact);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.Comments),
                                Space.xf(),
                                Text(
                                  "Contact",
                                  style: AppText.b1b,
                                )
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      Space.yf(2.9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "V.1.0",
                            style: AppText.b1b,
                          )
                        ],
                      ),
                      Space.yf(.3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.Whats,
                            height: AppDimensions.normalize(15),
                          ),
                          SvgPicture.asset(
                            AppAssets.Noti,
                            height: AppDimensions.normalize(15),
                          ),
                          SvgPicture.asset(
                            AppAssets.Music,
                            height: AppDimensions.normalize(15),
                          ),
                        ],
                      ),
                      Space.yf(1.3),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
