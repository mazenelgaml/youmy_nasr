import 'package:flutter/material.dart';
import 'package:merchant/services/translation_key.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../util/keyboard.dart';
import '../../../../../../../util/size_config.dart';
import '../../../../../home_screen.dart';
import 'package:get/get.dart';

import '../../../controller/new_branch_controller.dart';

class BranchAddressBody extends StatefulWidget {
  const BranchAddressBody({Key? key}) : super(key: key);

  @override
  _BranchAddressBodyState createState() => _BranchAddressBodyState();
}

class _BranchAddressBodyState extends State<BranchAddressBody> {




  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewBranchController(context),
        builder: (NewBranchController controller) {
          return Form(
            key: controller.formKey4,
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
    if (controller.formKey4.currentState!.validate()) {
      (controller.formKey4.currentState!.save());
      KeyboardUtil.hideKeyboard(context);
      controller.createBranch(context);
      Get.delete<NewBranchController>();
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
