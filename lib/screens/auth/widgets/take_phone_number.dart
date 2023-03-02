import 'package:fiverrr/screens/auth/widgets/phone_number_textfield.dart';
import 'package:fiverrr/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'auth_button.dart';
import 'auth_input_widget2.dart';

class TakePhoneNumberForm extends StatefulWidget {
  const TakePhoneNumberForm(
      {Key? key,
      required this.getPhoneNumberCallback,
      required this.changeState})
      : super(key: key);
  final Function(String) getPhoneNumberCallback;
  final VoidCallback changeState;

  @override
  State<TakePhoneNumberForm> createState() => _TakePhoneNumberFormState();
}

class _TakePhoneNumberFormState extends State<TakePhoneNumberForm> {
  TextEditingController controller = TextEditingController();
  String? validationError;
  bool isLoading = false;
  PhoneNumber? _phoneNumber = null;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*NewAuthInputWidget(
            text: "kek",
            textController: controller,
            validationError: validationError,
          ),*/
          _getPhoneForm(false),
          SizedBox(
            height: 80,
          ),
          AuthButton(
            text: "Kayıt Ol",
            onClicked: () async {
              if (validate()) {
                setState(() {
                  isLoading = true;
                  validationError = null;
                });

                widget.getPhoneNumberCallback(_phoneNumber!.phoneNumber!);
                setState(() {
                  widget.changeState();
                });
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          AppButton(label: "Yardım Haritası"),
        ],
      ),
    );
  }

  bool validate() {
    validationError = validatePhoneNumber(controller.text);

    setState(() {});

    return (true);
  }

  String? validatePhoneNumber(String? formNumber) {
    if (formNumber == null || formNumber.isEmpty) {
      return 'Phone number is required.';
    }

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formNumber)) return 'Invalid E-mail Address format.';

    return null;
  }

  Widget _getPhoneForm(bool isPhoneError) {
    return Column(
      children: [
        SizedBox.square(dimension: 10),
        PhoneNumberField(
          isPhoneError: isPhoneError,
          isForRegister: false,
          setPhoneNumber: (PhoneNumber phoneNumber) {
            _phoneNumber = phoneNumber;
          },
          validatePhoneNumber: (isPhoneNumberValid) {
            // this.isPhoneNumberValid = isPhoneNumberValid;
          },
          isPhoneNumberValid: () => true,
        ),
        SizedBox.square(dimension: 10),
      ],
    );
  }
}
