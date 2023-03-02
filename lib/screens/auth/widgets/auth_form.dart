import 'package:fiverrr/screens/auth/widgets/phone_number_otp_form.dart';
import 'package:fiverrr/screens/auth/widgets/take_phone_number.dart';
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
  String _phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 72,
            width: 72,
            color: Colors.purple,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(_phoneNumberAuthState == PhoneNumberAuthState.PHONE_NUMBER
              ? "Kayıt Ol"
              : "Kodu doğrula"),
          const SizedBox(
            height: 40,
          ),
          Text(
            _phoneNumberAuthState == PhoneNumberAuthState.PHONE_NUMBER
                ? "Kurumları Organize Edip \nCanları Kurtar!"
                : "$_phoneNumber adresine gönderdiğimiz 4 haneli kodu girerek hesabını onayla:",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          _getPhoneNumberAuthWidget(_phoneNumberAuthState)
        ],
      ),
    );
  }

  Widget _getPhoneNumberAuthWidget(PhoneNumberAuthState phoneNumberAuthState) {
    switch (phoneNumberAuthState) {
      case PhoneNumberAuthState.PHONE_NUMBER:
        return TakePhoneNumberForm(
          getPhoneNumberCallback: (phoneNumber) {
            _phoneNumber = phoneNumber;
          },
          changeState: () {
            setState(() {
              _phoneNumberAuthState = PhoneNumberAuthState.OTP;
            });
          },
        );

      case PhoneNumberAuthState.OTP:
        return OtpForm(
          changeState: () {},
          phoneNumber: _phoneNumber,
        );
    }
  }
}
