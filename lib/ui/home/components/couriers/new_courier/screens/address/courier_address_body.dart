import 'package:flutter/material.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../services/translation_key.dart';
import '../../../../../../../util/keyboard.dart';
import '../../../../../../../util/size_config.dart';
import '../../../../../home_screen.dart';
import 'package:get/get.dart';

import '../../../controller/new_courier_controller.dart';

class CourierAddressBody extends StatefulWidget {
  const CourierAddressBody({Key? key}) : super(key: key);

  @override
  _CourierAddressBodyState createState() => _CourierAddressBodyState();
}

class _CourierAddressBodyState extends State<CourierAddressBody> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewCourierController(context),
    builder: (NewCourierController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          controller.buildLocationOnMapField(context),
          SizedBox(height: getProportionateScreenHeight(20)),
          controller.buildCountryField(),
          SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildCityField(),
          SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildRegionField(),
          SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildStreetField(),
          SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildBuildingField(),
          SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildFloorField(),
          SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildFlatField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: controller.errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomButton(
            text: "Finish",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              // if all are valid then go to success screen
              KeyboardUtil.hideKeyboard(context);
            controller.createCourier(context);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
        ],
      ),
    );});
  }

}
