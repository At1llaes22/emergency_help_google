import 'package:flutter/material.dart';

class PhoneNumberAuthForm extends StatefulWidget {
  const PhoneNumberAuthForm({Key? key}) : super(key: key);

  @override
  State<PhoneNumberAuthForm> createState() => _PhoneNumberAuthFormState();
}

enum PhoneNumberAuthState { PHONE_NUMBER, OTP }

class _PhoneNumberAuthFormState extends State<PhoneNumberAuthForm> {
  PhoneNumberAuthState _phoneNumberAuthState =
      PhoneNumberAuthState.PHONE_NUMBER;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 72,
          width: 72,
          color: Colors.purple,
        ),
        Text(_phoneNumberAuthState == PhoneNumberAuthState.PHONE_NUMBER
            ? "Kayıt Ol"
            : "Kodu doğrula"),
        Text(_phoneNumberAuthState == PhoneNumberAuthState.PHONE_NUMBER
            ? "Kurumları Organize Edip Canları Kurtar!"
            : "ornek@example.com adresine gönderdiğimiz 4 haneli kodu girerek hesabını onayla:")
      ],
    ));
  }
}
