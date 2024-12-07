import 'package:flutter/material.dart';

import '../util/Constants.dart';
import '../util/size_config.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.press,
    this.backgroundColor=KPrimaryColor,
  }) : super(key: key);
  final String? text;
  final Color backgroundColor;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(46),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          disabledBackgroundColor: Colors.white,
          backgroundColor: backgroundColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
