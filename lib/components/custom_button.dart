import 'package:flutter/material.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.press,
    this.backgroundColor = KPrimaryColor,
  });

  final String? text;
  final Color backgroundColor;
  final VoidCallback? press; // Use VoidCallback for the press event

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(46),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          disabledBackgroundColor: Colors.white,
          backgroundColor: backgroundColor,
        ),
        onPressed: press,
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
