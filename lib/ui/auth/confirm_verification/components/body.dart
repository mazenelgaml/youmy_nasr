import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_phone_verified.dart';
import 'package:merchant/util/Constants.dart';
import '../../../../components/custom_button.dart';
import '../../../../util/keyboard.dart';
import '../../../../util/size_config.dart';
import '../../../home/home_screen.dart';
import '../controller/confirm_verification_controller.dart';

class Body extends StatefulWidget {
  final String email;
  const Body({super.key, required this.email});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isResendActive = false;
  int timerSeconds = 59;
  Key timerKey = UniqueKey();

  final TextEditingController code1Controller = TextEditingController();
  final TextEditingController code2Controller = TextEditingController();
  final TextEditingController code3Controller = TextEditingController();
  final TextEditingController code4Controller = TextEditingController();
  final TextEditingController code5Controller = TextEditingController();
  final TextEditingController code6Controller = TextEditingController();
  final TextEditingController code7Controller = TextEditingController();
  final TextEditingController code8Controller = TextEditingController();

  void restartTimer() {
    setState(() {
      timerSeconds = 59;
      isResendActive = false;
      timerKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmVerificationController>(
      init: ConfirmVerificationController(),
      builder: (ConfirmVerificationController controller) {
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
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
                            bottomRight: Radius.circular(40),
                          ),
                        ),
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
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: true,
                          controller: code1Controller,
                        ),
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: false,
                          controller: code2Controller,
                        ),
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: false,
                          controller: code3Controller,
                        ),
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: false,
                          controller: code4Controller,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: false,
                          controller: code5Controller,
                        ),
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: false,
                          controller: code6Controller,
                        ),
                        CustomTextPhoneVerified(
                          context: context,
                          autoFocus: false,
                          controller: code7Controller,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomButton(
                      text: "Send",
                      press: () {
                        KeyboardUtil.hideKeyboard(context);
                        final code = code1Controller.text +
                            code2Controller.text +
                            code3Controller.text +
                            code4Controller.text +
                            code5Controller.text +
                            code6Controller.text +
                            code7Controller.text;

                        controller.forgetPassword(context, widget.email, code);
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),

                  /// 🔁 التايمر
                  TweenAnimationBuilder(
                    key: timerKey,
                    tween: Tween(begin: timerSeconds.toDouble(), end: 0),
                    duration: Duration(seconds: timerSeconds),
                    builder: (BuildContext context, num value, Widget? child) {
                      return CustomText(
                        text: "00:${value.toInt().toString().padLeft(2, '0')}",
                        align: Alignment.center,
                        fontColor: KPrimaryColor,
                      );
                    },
                    onEnd: () {
                      setState(() {
                        isResendActive = true;
                      });
                    },
                  ),

                  SizedBox(height: getProportionateScreenHeight(27)),

                  /// 🔘 زرار الإعادة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Didn't receive the code? ",
                        fontSize: 14,
                        fontColor: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: isResendActive
                            ? () {
                          restartTimer();
                          // ممكن تبعتي API هنا لو حبيتي
                        }
                            : null,
                        child: CustomText(
                          text: 'Resend',
                          fontSize: 14,
                          fontColor: isResendActive ? KPrimaryColor : Colors.grey,
                          fontFamily: 'Roboto Bold',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: getProportionateScreenHeight(30)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
