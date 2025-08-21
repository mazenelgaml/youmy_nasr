import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/ui/auth/confirm_verification/confirm_verification_screen.dart';
import 'package:merchant/ui/auth/verification/controller/verification_controller.dart';
import 'package:merchant/util/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_button.dart';
import '../../../../services/localization_services.dart';
import '../../../../services/memory.dart';
import '../../../../util/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationController>(
        init: VerificationController(),
    builder: (VerificationController controller) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
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
                margin:
                    const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/mobile.png'),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child:  CustomText(
                            maxLine: 2,
                            over: TextOverflow.visible,
                            text:
                            Get.find<CacheHelper>()
                                .activeLocale == SupportedLocales.english?'Enter your Email address to receive \n verification code ':"أدخل البريد الالكتروني لاستلام\n رمز التحقق",
                            fontSize: 16,
                            fontFamily: 'Roboto Bold',
                            fontColor: KPrimaryColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: controller.buildEmailField()
                    ),
                  ),
                ],
              ),
            SizedBox(height: getProportionateScreenHeight(60)),
              Container(
                margin:
                    const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
                child: CustomButton(
                  text: Get.find<CacheHelper>()
                      .activeLocale == SupportedLocales.english?"Send":"ابعت",
                  press: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.forgetPassword(context);
      }
      
                  },
                ),
      
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
            ],
          ),
        ),
      ),
    );});
  }
}
