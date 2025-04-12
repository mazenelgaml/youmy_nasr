import 'package:flutter/material.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:get/get.dart';
import '../../../../../../components/custom_button.dart';
import '../../../../../../components/form_error.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';
import '../../../controller/signup_controller.dart';
class SignUpFormNewAddress extends StatefulWidget {
  const SignUpFormNewAddress({Key? key}) : super(key: key);
  @override
  State<SignUpFormNewAddress> createState() => _SignUpFormNewAddressState();
}
class _SignUpFormNewAddressState extends State<SignUpFormNewAddress> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(context),
        builder: (SignupController controller) {
          return Form(
            key: controller.formKey3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: getProportionateScreenWidth(15),
                ),
                controller.buildLocationOnMapField(context),
                SizedBox(height: getProportionateScreenHeight(15)),
                controller.buildCountryField(),
                SizedBox(height: getProportionateScreenHeight(15)),
                Container(width: Get.width*0.9,child: controller.buildCityField()),
                SizedBox(height: getProportionateScreenHeight(15)),
                controller.buildRegionField(),
                SizedBox(height: getProportionateScreenHeight(15)),
                controller.buildStreetField(),
                SizedBox(height: getProportionateScreenHeight(15)),
                controller.buildBuildingField(),
                SizedBox(height: getProportionateScreenHeight(15)),
                controller.buildFloorField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                controller.buildFlatField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                FormError(errors:controller.errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                CustomButton(
                  text: finishBTN.tr,
                  press: () {
    if (controller.formKey3.currentState!.validate()) {
    controller.formKey3.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    controller.createStore(context);
}
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
              ],
            ),
          );
        });
  }
}
