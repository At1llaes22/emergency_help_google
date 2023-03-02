import 'package:fiverrr/constants/app_theme.dart';
import "package:flutter/material.dart";

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

/*
  //TODO: Dark modda error verdiğinde containerla bunun etrafını sardığımızdan arka plan da büyüyor
  //TODO: Bunu çöz
 */

// ignore: must_be_immutable
class PhoneNumberField extends StatelessWidget {
  final bool isPhoneError;
  final bool isForRegister;
  final Function setPhoneNumber;
  final Function validatePhoneNumber;
  final Function isPhoneNumberValid;
  final GlobalKey<FormState>? formKey;

  bool inputIsValid = false;

  PhoneNumberField(
      {required this.isPhoneError,
      required this.isForRegister,
      required this.setPhoneNumber,
      required this.isPhoneNumberValid,
      required this.validatePhoneNumber,
      this.formKey});

  @override
  Widget build(BuildContext context) {
    if (formKey != null && isPhoneError) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        formKey!.currentState!.validate();
      });
    }

    final Widget input = InternationalPhoneNumberInput(
      onInputChanged: (value) {
        setPhoneNumber(value);
        print(value);
      },
      onInputValidated: (bool value) {
        print(value);
        inputIsValid = value;
        validatePhoneNumber(value);
        print("set " + isPhoneNumberValid.toString());
      },
      spaceBetweenSelectorAndTextField: 0,
      textStyle: Theme.of(context).textTheme.bodyText1,
      inputDecoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 0.0,
            color: Theme.of(context).errorColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 0.0,
            color: Theme.of(context).errorColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 0.0,
          ),
        ),
      ),
      initialValue: PhoneNumber(isoCode: "TR"),
      errorMessage: "Geçersiz numara.",
      selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          showFlags: true,
          leadingPadding: 0,
          useEmoji: false,
          trailingSpace: false),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 16, 10),
                child: Text("Telefon",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context)
                            .toggleButtonsTheme
                            .disabledColor)),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  width: 0.0),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: input,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _getErrorText() {
    if (isPhoneError) {
      if (isForRegister) {
        return "Numara zaten kayıtlı.";
      } else {
        return "Numara bulunamadı.";
      }
    } else
      return "Geçersiz numara.";

    // return null;
  }
}
