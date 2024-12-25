import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/services/memory.dart';

import '../services/localization_services.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Alignment align;
  final double fontSize;
  final Color fontColor;
  final String fontFamily;
  final FontWeight fontWeight;
  final int maxLine;
  final TextOverflow? over;

  const CustomText(
      {Key? key,
      this.text = '',
      this.fontColor = Colors.black,
      this.align = Alignment.topLeft,
      this.fontSize = 18.0,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = 'Roboto Regular',
      this.maxLine=1,
      this.over})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: align,
        child: Text(
          text,
          overflow:over,
          maxLines: 1,
          textAlign:Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english ?TextAlign.left:TextAlign.right
          ,style: TextStyle(

              fontWeight: fontWeight,
              fontSize: fontSize,
              color: fontColor,
              fontFamily: fontFamily),
        ));
  }
}
