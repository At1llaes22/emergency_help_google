import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezen_leven/screens/auth/widgets/auth_button.dart';
import 'package:lezen_leven/screens/main_control/main_control_screen.dart';

import '../../../constants/app_theme.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/app_button.dart';
import 'auth_input_widget.dart';
import 'auth_input_widget2.dart';

class RegisterFormWidget extends StatefulWidget {
  final PageController controller;
  final VoidCallback switchToLogin;
  const RegisterFormWidget(
      {Key? key, required this.controller, required this.switchToLogin})
      : super(key: key);

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isRegisterLoading = false;
  bool isLoginLoading = false;

  String? emailValidationError;
  String? passwordValidationError;
  String? emailServerError;
  String? passwordServerError;
  String? usernameValidationError;
  String? usernameServerError;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          children: [
            const SizedBox(
              height: 38,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: NewAuthInputWidget(
                    textController: usernameController,
                    validationError: usernameValidationError,
                    serverError: usernameServerError,
                    icon: (const AssetImage(
                        "assets/images/auth_icons/username_icon.png")),
                    text: "GEBRUIKERSNAAM")),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: NewAuthInputWidget(
                    textController: emailController,
                    validationError: emailValidationError,
                    serverError: emailServerError,
                    icon: const AssetImage(
                        "assets/images/auth_icons/email_icon.png"),
                    text: "E-MAIL")),
            //const SizedBox(width: 22),
            const SizedBox(
              height: 30,
            ),

            Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: NewAuthInputWidget(
                    textController: passwordController,
                    validationError: passwordValidationError,
                    serverError: passwordServerError,
                    isPass: true,
                    icon: (const AssetImage(
                        "assets/images/auth_icons/password_icon.png")),
                    text: "WATCHWOORD")),
            const SizedBox(
              height: 24,
            ),
            isLoginLoading
                ? CircularProgressIndicator()
                : AuthButton(
                    text: "Registeren",
                    onClicked: () async {
                      if (validate()) {
                        setState(() {
                          isLoginLoading = true;
                        });
                        RegisterErrorResponse errorResponse =
                            await AuthService.register(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                          username: usernameController.text,
                        );

                        setState(() {
                          isLoginLoading = false;
                        });

                        if (errorResponse.isValid) {
                          print("Kaydoldun");
                          widget.switchToLogin();
                        } else {
                          setState(() {
                            emailServerError = errorResponse.emailError
                                ? "An user with this email already exists"
                                : null;
                            passwordServerError = errorResponse.passwordError
                                ? "Password is not correct"
                                : null;
                          });
                          print(errorResponse.emailError);
                          print(emailServerError);
                        }
                      }
                    },
                  ),
            const SizedBox(height: 72),
            InkWell(
              onTap: () {
                widget.controller.animateToPage(0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Heeft u al een account? ",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.of(context).secondaryToWhite),
                  ),
                  Text("Log in",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.of(context).secondaryToWhite))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validate() {
    emailValidationError = validateEmail(emailController.text);
    passwordValidationError = validatePassword(passwordController.text);
    usernameValidationError = validateUsername(usernameController.text);

    setState(() {});

    return emailValidationError == null &&
        usernameValidationError == null &&
        passwordValidationError == null;
  }

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'E-mail address is required.';
    }

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return 'Password is required.';

    if (formPassword.length < 6)
      return 'Password must be at least 6 characters.';

    return null;
  }

  String? validateUsername(String? formUsername) {
    if (formUsername == null || formUsername.isEmpty) {
      return 'Username is required.';
    }

    if (formUsername.length < 3)
      return 'Username must be at least 3 characters.';

    return null;
  }
}

class RegisterErrorResponse {
  final bool isValid;
  final bool passwordError;
  final bool emailError;
  final bool usernameError;

  RegisterErrorResponse({
    this.isValid = true,
    this.passwordError = false,
    this.emailError = false,
    this.usernameError = false,
  });
}
