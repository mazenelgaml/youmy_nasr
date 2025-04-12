import 'package:flutter/material.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../services/memory.dart';
import '../../../../../../../util/size_config.dart';
import 'package:get/get.dart';

import '../../../controller/new_branch_controller.dart';


class BranchDetailsBody extends StatefulWidget {
  const BranchDetailsBody({Key? key}) : super(key: key);

  @override
  _BranchDetailsBodyState createState() => _BranchDetailsBodyState();
}

class _BranchDetailsBodyState extends State<BranchDetailsBody> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewBranchController(context),
        builder: (NewBranchController controller) {
          return Form(
      key: controller.formKey1,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(5)),
          controller.buildNameField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildMobileField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildConfirmPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: controller.errors),
          SizedBox(height: getProportionateScreenHeight(60)),
          CustomButton(
            text: next.tr,
            press: () async{
               if (controller.formKey1.currentState!.validate()) {
                 (controller.formKey1.currentState!.save());
              await Get.find<CacheHelper>().saveData(key: "Name", value: controller.merchantNameController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "mobileNumber", value: controller.mobileNumberController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "password", value: controller.passwordController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "confirmPassword", value: controller.confirmPasswordController.text.trim());
                DefaultTabController.of(context).animateTo(1);
               }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(16)),

        ],
      ),
    );});
  }


}
