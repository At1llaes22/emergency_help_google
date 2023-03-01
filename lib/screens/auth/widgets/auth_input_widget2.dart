import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Row(
          children: [
            //PHONE SELECTION
            Container(
              height: 46,
              width: 0.8,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 180,
                    child: TextField(
                      controller: widget.textController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                    )),
              ],
            ),
          ],
        ),
        Container(
          height: 0.8,
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
    );
  }
}
