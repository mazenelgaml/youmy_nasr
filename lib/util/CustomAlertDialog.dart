import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  const CustomAlertDialog(
      {Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  CustomText(text: title,),
      content: CustomText(text: message,) ,
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: CustomText(
            text: 'OK',
                ),
          ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const CustomText(text: 'Cancel'),
        ),
      ],
    );
  }
}
