import 'package:merchant/components/colored_custom_text.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_phone_verified.dart';
import 'package:flutter/material.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../components/custom_button.dart';
import '../../../../util/keyboard.dart';
import '../../../../util/size_config.dart';
import '../../../home/home_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      color: KOpacityPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
                Image.asset(
                  'assets/images/trans.png',
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            const CustomText(
              text: 'Enter the confirmation code',
              align: Alignment.center,
              fontSize: 16,
              fontFamily: 'Roboto Bold',
              fontColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextPhoneVerified(context: context, autoFocus: true),
                  CustomTextPhoneVerified(context: context, autoFocus: false),
                  CustomTextPhoneVerified(context: context, autoFocus: false),
                  CustomTextPhoneVerified(
                      context: context,
                      textInputAction: TextInputAction.done,
                      autoFocus: false),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: "Send",
                press: () {
                  // if all are valid then go to success screen
                  KeyboardUtil.hideKeyboard(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomeScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            TweenAnimationBuilder(
              tween: Tween(begin: 59.0, end: 0),
              duration: const Duration(seconds: 59),
              builder: (BuildContext context, num value, Widget? child) =>
                  CustomText(
                text: "00:${value.toInt()}",
                align: Alignment.center,
                fontColor: KPrimaryColor,
              ),
              onEnd: () {},
            ),
            SizedBox(height: getProportionateScreenHeight(27)),
            GestureDetector(
              child: const CustomRichText(
                align: Alignment.center,
                text1: 'Did n\'t receive the code ?',
                text2: ' Resend',
              ),
              onTap: () {
           //resend your otp
              },
            ),SizedBox(height: getProportionateScreenHeight(30)),
          ],
        ),
      ),
    );
  }
}
