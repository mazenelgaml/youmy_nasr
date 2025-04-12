import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
import '../forget_password/forget_password_screen.dart';
import '../signup/controller/signup_controller.dart';
import '../signup/signup_screen.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  static var routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        SizeConfig().init(context);
        return Scaffold(
          resizeToAvoidBottomInset: true, // Ensure proper handling of the keyboard
          body: SingleChildScrollView(
            child: Form(
              key: controller.loginFormKey,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight, // Align settings button to top-right
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 0.3, // Adjust height for responsiveness
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
                            width: SizeConfig.screenWidth! * 0.5, // Adjust image width responsively
                            height: SizeConfig.screenWidth! * 0.5, // Adjust image height responsively
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(10)),
                          // Title text with dynamic alignment based on locale
                          CustomText(
                            text: signInTitle.tr,
                            fontSize: 25,
                            fontColor: KPrimaryColor,
                            fontFamily: 'Roboto Italic',
                            align: Get.find<CacheHelper>().activeLocale == SupportedLocales.english
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomText(
                              align: Get.find<CacheHelper>().activeLocale == SupportedLocales.english
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              text: Get.find<CacheHelper>().getData(key: "companyName"),
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontFamily: 'Roboto Italic',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomText(
                              align: Get.find<CacheHelper>().activeLocale == SupportedLocales.english
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              text: Get.find<CacheHelper>().getData(key: "year"),
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontFamily: 'Roboto Italic',
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(12)),

                          // Email Field
                          controller.buildEmailField(),
                          SizedBox(height: getProportionateScreenHeight(12)),

                          // Password Field
                          controller.buildPasswordField(),
                          SizedBox(height: getProportionateScreenHeight(12)),

                          // Branch Dropdown moved below email and password
                          if (controller.isLoading)
                            Center(child: CircularProgressIndicator())
                          else
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'الفروع',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: controller.branchesLogin
                                  ?.map((branch) => DropdownMenuItem<String>(
                                value: branch,
                                child: Text(branch),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                controller.selectedBranch = value!;
                              },
                            ),
                          SizedBox(height: getProportionateScreenHeight(15)),

                          // Settings Fields (Merchant Name & Year) shown when showSettingsFields is true
                          if (controller.showSettingsFields) ...[
                            controller.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'اسم المتجر',
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
                            TextFormField(
                              controller: controller.yearController,
                              decoration: InputDecoration(
                                labelText: 'السنة',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                controller.year = value;
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(15)),
                          ],

                          // Error messages
                          FormError(errors: controller.errors),
                          SizedBox(height: getProportionateScreenHeight(15)),

                          GestureDetector(
                            onTap: () => Get.toNamed(ForgetPasswordScreen.routeName),
                            child: CustomText(
                              text: signInTextForgetPass.tr,
                              fontFamily: 'Roboto Bold',
                              fontSize: 16,
                              fontColor: KPrimaryColor,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),

                          // Login Button
                          CustomButton(
                            text: signInTextBTN.tr,
                            press: () {
                              if (controller.loginFormKey.currentState!.validate()) {
                                controller.loginFormKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                controller.signInBranches(context);
                              }
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.put<SignupController>(SignupController(context), permanent: true);
                        Get.toNamed(SignUpScreen.routeName);
                      },
                      child: CustomRichText(
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
          ),
        );
      },
    );
  }
}
