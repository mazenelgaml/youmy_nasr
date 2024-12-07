import 'dart:ui';

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Alignment align;
  final double fontSize;
  final Color fontColor;
  final String fontFamily;
  final FontWeight fontWeight;
  final int maxLine;

  const CustomText(
      {Key? key,
      this.text = '',
      this.fontColor = Colors.black,
      this.align = Alignment.topLeft,
      this.fontSize = 18.0,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = 'Roboto Regular',
      this.maxLine=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: align,
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: fontColor,
              fontFamily: fontFamily),
        ));
  }
}
