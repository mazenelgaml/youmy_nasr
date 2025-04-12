import 'package:flutter/material.dart';

import '../../util/Constants.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String fontFamily;
  final double fontSize;
  final Widget? suffixIcon;
  final Function onPressed;
  final Function onValidate;
  final Function onChange;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffixList;
  final bool? obscureText;
  const CustomTextFormField(
      {Key? key,
      this.obscureText,
      this.textInputType = TextInputType.text,
      this.hintText = '',
      this.fontFamily = 'Roboto Regular',
      this.fontSize = 16,
      this.suffixIcon,
      this.textInputAction = TextInputAction.next,
      this.readOnly = false,
       required this.onPressed,
        required this.onChange,
        required this.onValidate,  this.controller, this.suffixList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller ,
      readOnly: readOnly,
      onTap: () => onPressed,
      maxLines: 1,
      validator: (value) => onValidate(value),
      onChanged: (value) => onChange(value),
      obscureText: obscureText??false,
      decoration: InputDecoration(
          suffix: suffixList,
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
              fontSize: fontSize, fontFamily: fontFamily, color: KHintColor)),
      keyboardType: textInputType,
      textInputAction: textInputAction,
    );
  }
}
