import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../components/colored_custom_text.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../components/form_error.dart';
import '../../../services/translation_key.dart';
import '../../../util/Constants.dart';
import '../../../util/keyboard.dart';
import '../../../util/size_config.dart';
import '../../home/home_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../signup/signup_screen.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  static var routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder(
      init: LoginController(),
      builder: (LoginController controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: controller.formKey,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 222,
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
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      bottom: 40,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10)),
                         CustomText(
                          text: signInTitle.tr,
                          fontSize: 25,
                          fontColor: KPrimaryColor,
                          fontFamily: 'Roboto Italic',
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        controller.buildEmailField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        controller.buildPasswordField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        FormError(errors: controller.errors),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        GestureDetector(
                          onTap: () => Get.toNamed(ForgetPasswordScreen.routeName),
                          child:  CustomText(
                            text: signInTextForgetPass.tr,
                            fontFamily: 'Roboto Bold',
                            fontSize: 16,
                            fontColor: KPrimaryColor,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(60)),
                        CustomButton(
                          text: signInTextBTN.tr,
                          press: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.formKey.currentState!.save();
                              // if all are valid then go to success screen
                              KeyboardUtil.hideKeyboard(context);
                              controller.signIn(context);
                              // Replaced Navigator.popAndPushNamed with Get.offAndToNamed
                            }
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(40)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(SignUpScreen.routeName); // Replaced Navigator.pushNamed with Get.toNamed
                    },
                    child:  CustomRichText(
                      align: Alignment.center,
                      text1: dontHaveAnAccount.tr,
                      text2: signUpTextBTN.tr,
                    ),
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
