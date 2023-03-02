import 'package:fiverrr/services/auth_service.dart';
import 'package:fiverrr/services/temp_service.dart';
import 'package:fiverrr/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';
import 'widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegisterLoading = false;
  bool isLoginLoading = false;
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [isRegister? : PhoneNumberAuthForm()],
            ),
          ),
        ),
      ),
    );
  }
}
