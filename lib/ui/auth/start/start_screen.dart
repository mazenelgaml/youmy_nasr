import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:merchant/ui/auth/start/start_controller.dart';

import '../../../components/colored_custom_text.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../components/form_error.dart';
import '../../../services/localization_services.dart';
import '../../../services/memory.dart';
import '../../../services/translation_key.dart';
import '../../../util/Constants.dart';
import '../../../util/keyboard.dart';
import '../../../util/size_config.dart';
import '../../home/home_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../login/controller/login_controller.dart';
import '../signup/controller/signup_controller.dart';
import '../signup/signup_screen.dart';
class StartScreen extends StatelessWidget {
  static var routeName = "/login";

  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<StartController>(
      init: StartController(),
      builder: (StartController controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Form(
              key: controller.startFormKey,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.topRight, // Align settings button to top-right
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
                        Center(
                          child: Image.asset(
                            'assets/images/trans.png',
                            width: 200,
                            height: 200,
                            alignment: Alignment.center,
                          ),
                        ),
                        // Settings Button

                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5,
                        left: 20,
                        right: 20,
                        bottom: 5,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Center(
                            child: CustomText(
                              text: signInTitle.tr,
                              fontSize: 25,
                              fontColor: KPrimaryColor,
                              fontFamily: 'Roboto Italic',
                              align: Get.find<CacheHelper>()
                                  .activeLocale == SupportedLocales.english ?Alignment.centerLeft:Alignment.centerRight,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(12)),
                          // Email Field
                          controller.buildApiField(),
                          SizedBox(height: getProportionateScreenHeight(12)),
                          controller.buildReportApiField(),
                          SizedBox(height: getProportionateScreenHeight(12)),
                          controller.buildEmailField(),
                          SizedBox(height: getProportionateScreenHeight(12)),
                          // Password Field
                          controller.buildPasswordField(),
                          SizedBox(height: getProportionateScreenHeight(12)),





                          // Settings Fields (Merchant Name & Year) shown when showSettingsFields is true
                           controller
                              .isLoading // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
                              ? Center(child: CircularProgressIndicator()) :
                          // Merchant Name
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: ShopName.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: controller.companyLogin?.map((MerchantName) => DropdownMenuItem<String>(
                              value: MerchantName,
                              child: Text(MerchantName),
                            ))
                                .toList(),
                            onChanged: (value) {
                              controller.merchantName = value!;
                            },
                          ),
                            SizedBox(height: getProportionateScreenHeight(15)),

                            // Year
                            TextFormField(
                              controller: controller.yearController,
                              decoration: InputDecoration(
                                labelText: year.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                controller.year = value;
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),


                          // Error messages
                          FormError(errors: controller.errors),
                          SizedBox(height: getProportionateScreenHeight(10)),



                          // Login Button
                          CustomButton(
                            text: signInTextBTN.tr,
                            press: () async{
                              if (controller.startFormKey.currentState!.validate()) {
                                controller.startFormKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                controller.signIn(context);
                                controller.emailController.clear();
                                controller.passwordController.clear();
                                // Get.delete<LoginController>();
                                await controller.getBranches();
                              }
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
