import 'package:fiverrr/screens/auth/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../constants/app_theme.dart';

class OtpForm extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback changeState;
  const OtpForm({
    Key? key,
    required this.changeState,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool isLoading = false;
  OtpFieldController controller = OtpFieldController();
  String codeString = "";
  int? code;
  String? validationError;
  String? serverError;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            OTPTextField(
              otpFieldStyle: OtpFieldStyle(
                  backgroundColor: AppColors.primary.withOpacity(0.5),
                  borderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                  focusBorderColor: Colors.transparent),
              fieldWidth: 48,
              controller: controller,
              spaceBetween: 0,
              outlineBorderRadius: 5,
              fieldStyle: FieldStyle.box,
              keyboardType: TextInputType.number,
              width: 240,
              length: 4,
              style: const TextStyle(fontSize: 20),
              onCompleted: (pin) {
                codeString = pin;
                print("Changed: $pin");
              },
              onChanged: (pin) {
                codeString = pin;
                print("Changed: $pin");
              },
              textFieldAlignment: MainAxisAlignment.spaceAround,
            ),
            const SizedBox(height: 8),
            validationError != null || serverError != null
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      validationError ?? serverError ?? "",
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 80,
        ),
        isLoading
            ? const CircularProgressIndicator()
            : AuthButton(
                text: "Devam Et",
                onClicked: () async {
                  if (validate()) {
                    setState(() {
                      code = int.parse(codeString);
                      isLoading = true;
                      validationError = null;
                    });
                  }
                }),
        SizedBox(
          height: 10,
        ),
        Text(
          "Kod Gelmedi mi?",
          style: TextStyle(decoration: TextDecoration.underline, fontSize: 12),
        )
      ],
    );
  }

  String? validateCode(String? formCode) {
    if (formCode == null || formCode.isEmpty || formCode.length < 6)
      return 'Please fill all of the boxes';

    return null;
  }

  bool validate() {
    validationError = validateCode(codeString);

    setState(() {});

    return validationError == null;
  }
}
