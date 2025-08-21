import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/ui/auth/confirm_verification/confirm_verification_screen.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/form_error.dart';
import '../../../../services/localization_services.dart';
import '../../../../services/memory.dart';
import '../../../../services/translation_key.dart';
import '../../../../util/keyboard.dart';
import '../../../../util/size_config.dart';
import '../controller/forget_password_controller.dart';

class Body extends StatefulWidget {
  final String email;
  const Body({super.key, required this.email});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables
  final String TAG = "LOG IN: ";



  //endregion

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
    builder: (ForgetPasswordController controller) {
    return Form(
      key: controller.formKey,
      child: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        color: Colors.white,
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
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 40),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                   CustomText(
                     align:Get.find<CacheHelper>()
                         .activeLocale == SupportedLocales.english?Alignment.topLeft:Alignment.topRight ,
                    text: Get.find<CacheHelper>()
                        .activeLocale == SupportedLocales.english?'Password Reset':"إعادة تعيين كلمة المرور",
                    fontSize: 25,
                    fontColor: KPrimaryColor,
                    fontFamily: 'Roboto Bold',
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  controller.buildPasswordField(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  controller.buildConfirmPasswordField(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  FormError(errors: controller.errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomButton(
                    text:  merchantConfirm.tr,
                    press: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        // if all are valid then go to success screen
                        KeyboardUtil.hideKeyboard(context);
                        controller.resetPassword(context, widget.email);
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
          ],
        ),
      ),
    );});
  }

}
