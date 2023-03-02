import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/app_theme.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const AuthButton({
    super.key,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width - 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: AppColors.primary),
        child: Center(
          child: Text(text,
              //textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  )),
        ),
      ),
    );
  }
}
