import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../constants/app_theme.dart';

class NewAuthInputWidget extends StatefulWidget {
  final String text;
  final String? validationError;
  final String? serverError;
  final TextEditingController textController;

  const NewAuthInputWidget({
    super.key,
    required this.textController,
    required this.text,
    this.validationError,
    this.serverError,
  });

  @override
  State<NewAuthInputWidget> createState() => _NewAuthInputWidgetState();
}

class _NewAuthInputWidgetState extends State<NewAuthInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //PHONE SELECTION

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                  ),
                  /*Container(
                    width: 300,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: widget.textController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        fillColor: Colors.deepPurpleAccent, //<-- SEE HERE
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: IntlPhoneField(
                      controller: widget.textController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'TR',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  widget.validationError != null || widget.serverError != null
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.validationError ?? widget.serverError ?? "",
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
