import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/domain/usecases/user/sign_in_usecase.dart';
import 'package:piiicks/presentation/widgets/auth_error_dialog.dart';
import 'package:piiicks/presentation/widgets/credential_failure_dialog.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/successful_auth_dialog.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

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
  void _startLoading() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar("LOGIN", context, automaticallyImplyLeading: true),
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
                buildTextFormField(_passwordController, "Password",
                    isObscure: true),
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
                        _startLoading();
                      });
                    } else if (state is UserLogged) {
                      showSuccessfulAuthDialog(context, "logged in");
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
                        context.read<UserBloc>().add(
                              SignInUser(
                                SignInParams(
                                  username: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              ),
                            );
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
                    child: Text(
                      isLoading == true ? "Wait..." : "Login",
                      style: AppText.h3b?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Space.yf(1.5),
                Center(
                  child: Text(
                    "Don’t have an Account?",
                    style: AppText.b1b,
                  ),
                ),
                Space.y1!,
                transparentButton(
                  context: context,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.signup);
                  },
                  buttonText: "Signup",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
