import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../core/error/failures.dart';
import '../../core/router/app_router.dart';
import '../../domain/usecases/user/sign_up_usecase.dart';
import '../widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("SIGNUP"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Space.all(1, 1.3),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SIGNUP",
                  style: AppText.h2b?.copyWith(color: AppColors.CommonCyan),
                ),
                Space.y!,
                Text(
                  "Create New Account",
                  style: AppText.h3?.copyWith(color: AppColors.GreyText),
                ),
                Space.y2!,
                Text(
                  "Full Name*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(_nameController, "Full Name", false),
                Space.yf(1.5),
                Text(
                  "Email Address*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(_emailController, "Email Address", false),
                Space.yf(1.5),
                Text(
                  "Password*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(_passwordController, "Password", true),
                Space.yf(1.5),
                Text(
                  "Confirm Password*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(
                    _confirmPasswordController, "Password", true),
                Space.yf(1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: isChecked
                          ? const Icon(
                              Icons.check_box,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank_outlined,
                              color: Colors.black,
                            ),
                    ),
                    Space.x!,
                    Text(
                      "I Accept All Privacy Policies And Terms & Conditions Of ",
                      style: AppText.l1,
                    ),
                    Text(
                      "Piicks!",
                      style: AppText.b2b,
                    )
                  ],
                ),
                Space.yf(1.5),
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
                                padding: Space.all(1, 1.05),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SUCCESSFULLY REGISTERED",
                                        style: AppText.b1b,
                                      ),
                                      Space.yf(.6),
                                      Text(
                                        "Congratulations,\nYour Account Has Been Successfully Registered!",
                                        style: AppText.b2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                  AppRouter.mainscreen,
                                                  ModalRoute.withName(''),
                                                );
                                              },
                                              child: Text(
                                                "Ok",
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
                                          "Username/Password Wrong!",
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
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                        } else {
                          context.read<UserBloc>().add(SignUpUser(SignUpParams(
                                firstName: _nameController.text,
                                lastName: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              )));
                        }
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
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: AppDimensions.normalize(2),
                            ),
                          )
                        : Text(
                            "Signup",
                            style: AppText.h3b?.copyWith(color: Colors.white),
                          ),
                  ),
                ),
                Space.yf(1.5),
                Center(
                    child: Text(
                  "Already Have an Account?",
                  style: AppText.b1b,
                )),
                Space.y1!,
                Container(
                  height: AppDimensions.normalize(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border:
                          Border.all(width: 1, color: AppColors.CommonCyan)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
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
