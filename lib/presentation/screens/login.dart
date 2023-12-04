import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/domain/usecases/user/sign_in_usecase.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../core/constant/colors.dart';
import '../../core/error/failures.dart';
import '../../core/router/app_router.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("LOGIN",context),
      body: SingleChildScrollView(
        child: Padding(
          padding: Space.all(1, 1.3),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LOGIN",
                  style: AppText.h2b?.copyWith(color: AppColors.CommonCyan),
                ),
                Space.y!,
                Text(
                  "Login Into Your Account",
                  style: AppText.h3?.copyWith(color: AppColors.GreyText),
                ),
                Space.y2!,
                Text(
                  "Email Address*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(_emailController, "Email Address"),
                Space.yf(1.5),
                Text(
                  "Password*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(_passwordController, "Password",isObscure: true),
                Space.y1!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password",
                      style: AppText.h3?.copyWith(color: AppColors.CommonCyan),
                    )
                  ],
                ),
                Space.yf(1.7),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    } else if (state is UserLogged) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                height: AppDimensions.normalize(70),
                                padding: Space.all(1, 1),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SUCCESSFULLY Logged In",
                                        style: AppText.b1b,
                                      ),
                                      Space.yf(.6),
                                      Text(
                                        "Congratulations,\nYou Have Been Successfully Logged In!",
                                        style: AppText.b1?.copyWith(height: 1.5),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              context.read<CartBloc>().add(const GetCart());
                                              context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                AppRouter.mainscreen,
                                                ModalRoute.withName(''),
                                              );
                                            },
                                            child: Text(
                                              "Ok",
                                              style: AppText.h3b?.copyWith(
                                                  color: AppColors.CommonCyan),
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
                    } else if (state is UserLoggedFail) {
                      if (state.failure is CredentialFailure) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: AppDimensions.normalize(60),
                                  padding: Space.all(1, .5),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email/Password Wrong!",
                                          style: AppText.b1b,
                                        ),
                                        Space.yf(.5),
                                        Text(
                                          "Try Again!",
                                          style: AppText.b1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Dismiss",
                                                  style: AppText.h3b?.copyWith(
                                                      color:
                                                          AppColors.CommonCyan),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: AppDimensions.normalize(50),
                                  padding: Space.all(1, .5),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Error",
                                          style: AppText.b1b,
                                        ),
                                        Space.yf(.5),
                                        Text(
                                          "Try Again!",
                                          style: AppText.b1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Dismiss",
                                                  style: AppText.h3b?.copyWith(
                                                      color:
                                                          AppColors.CommonCyan),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UserBloc>().add(SignInUser(SignInParams(
                              username: _emailController.text,
                              password: _passwordController.text,
                            )));
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size(
                          double.infinity,
                          AppDimensions.normalize(20),
                        ),
                      ),
                    ),
                    child: isLoading == true
                        ? Padding(
                            padding: Space.vf(.3),
                            child: SizedBox(
                              height: AppDimensions.normalize(5),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: AppDimensions.normalize(2),
                              ),
                            ),
                          )
                        : Text(
                            "Login",
                            style: AppText.h3b?.copyWith(color: Colors.white),
                          ),
                  ),
                ),
                Space.yf(1.5),
                Center(
                    child: Text(
                  "Don’t have an Account?",
                  style: AppText.b1b,
                )),
                Space.y1!,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.signup);
                  },
                  child: Container(
                    height: AppDimensions.normalize(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:
                            Border.all(width: 1, color: AppColors.CommonCyan)),
                    child: Center(
                      child: Text(
                        "Signup",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
