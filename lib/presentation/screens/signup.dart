import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/presentation/widgets/auth_error_dialog.dart';
import 'package:piiicks/presentation/widgets/credential_failure_dialog.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/successful_auth_dialog.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

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
      appBar: CustomAppBar("SIGNUP", context, automaticallyImplyLeading: true),
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
                buildTextFormField(_nameController, "Full Name"),
                Space.yf(1.5),
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
                buildTextFormField(_passwordController, "Password",
                    isObscure: true),
                Space.yf(1.5),
                Text(
                  "Confirm Password*",
                  style: AppText.b1b,
                ),
                Space.y!,
                buildTextFormField(_confirmPasswordController, "Password",
                    isObscure: true),
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
                      showSuccessfulAuthDialog(context, "Registered");
                    } else if (state is UserLoggedFail) {
                      if (state.failure is CredentialFailure) {
                        showCredentialErrorDialog(context);
                      } else {
                        showAuthErrorDialog(context);
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
                    child:
                        Text(
                      isLoading == true ? "Wait..." : "Signup",
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
                TransparentButton(
                    context: context,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.login);
                    },
                    buttonText: "Login")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
