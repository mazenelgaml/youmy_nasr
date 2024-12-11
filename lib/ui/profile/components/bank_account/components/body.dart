import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:merchant/components/form_error.dart';
import 'package:merchant/util/keyboard.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../../profile_controller/profile_controller.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables


//endregion

  //region events
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
    builder: (ProfileController controller) {
    return Form(
      key:  controller.formKey,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const CustomText(
                      text: 'Add Bank Account',
                      fontSize: 25,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    controller.buildAccountOwnerNameField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    controller.buildBankNameField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    controller.buildBranchNameField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    controller.buildAccountOwnerField(),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    FormError(errors:  controller.errors),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    CustomButton(
                      text: "Save",
                      press: () {
                        if ( controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          controller.AddBankAccount(context);
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
    );});
  }
//endregion

}
