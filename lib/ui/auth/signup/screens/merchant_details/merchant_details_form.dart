import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/colored_custom_text.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/form_error.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/keyboard.dart';
import '../../../../../util/size_config.dart';
import '../../../login/login_screen.dart';
import '../../controller/signup_controller.dart';


class SignUpFormMerchantDetails extends StatefulWidget {
  const SignUpFormMerchantDetails({Key? key}) : super(key: key);

  @override
  _SignUpFormMerchantDetailsState createState() =>
      _SignUpFormMerchantDetailsState();
}

class _SignUpFormMerchantDetailsState extends State<SignUpFormMerchantDetails> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(context),
    builder: (SignupController controller) {
    return  Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
    controller.buildNameMerchantField(),
          SizedBox(height: getProportionateScreenHeight(10)),
    controller.buildCompanyTypesField(),
          SizedBox(height: getProportionateScreenHeight(10)),
    controller.buildSummaryField(),
          SizedBox(height: getProportionateScreenHeight(120)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              text:
              merchantNecessary.tr,
              align: Alignment.center,
              fontSize: 13,
              fontColor: Colors.grey,
            ),
          ),
          FormError(errors: controller.errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          CustomButton(
            text: next.tr,
            press: () async{
    if (controller.formKey.currentState!.validate()) {
      controller.formKey.currentState!.save();
      await Get.find<CacheHelper>().saveData(key: "merchantName",
          value: controller.merchantNameController.text.trim());
      await Get.find<CacheHelper>().saveData(key: "merchantSummary",
          value: controller.summaryController.text.trim());
      DefaultTabController.of(context).animateTo(2);
    }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          GestureDetector(
            onTap: () {

              KeyboardUtil.hideKeyboard(context);
              Navigator.popAndPushNamed(context, LoginScreen.routeName);
            },
            child:  CustomRichText(
              align: Alignment.center,
              text1: haveAnAccount.tr,
              text2: signInTextBTN.tr,
            ),

          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
        }
        );
  }


}
