import 'package:flutter/material.dart';
import 'package:merchant/util/Constants.dart';

class CustomRichText extends StatelessWidget {
  final String text1, text2;
  final Alignment align;
  final double fontSize;
  final Color fontColor;
  final String fontFamily;

  const CustomRichText(
      {Key? key,
      this.text1 = '',
      this.text2 = '',
      this.fontColor = Colors.black,
      this.align = Alignment.topLeft,
      this.fontSize = 16.0,
      this.fontFamily = 'Roboto Regular'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: align,
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
            text: text1,
            style: TextStyle(
                fontSize: fontSize, color: fontColor, fontFamily: fontFamily),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
                fontSize: fontSize, color: KPrimaryColor, fontFamily: fontFamily,fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
