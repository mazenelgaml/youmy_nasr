import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/components/empty_view.dart';
import 'package:merchant/data/model/Category.dart';
import 'package:merchant/data/model/Product.dart';

import '../../../../../../components/custom_button.dart';
import '../../../../../../components/custom_text.dart';
import '../../../../../../components/custom_text_form_field.dart';
import '../../../../../../components/rounded_icon_btn.dart';
import '../../../../../../services/translation_key.dart';
import '../../../../../../util/Constants.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';
import '../../components/products_data.dart';
import '../../controller/products_controller.dart';
import '../../filter/filter_screen.dart';

class Body extends StatefulWidget {
  final int id;
  const Body({Key? key, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables


//endregion

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
        init: ProductsController(context),
        builder: (ProductsController controller) {
          return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              children: [
                controller.buildSmallProductPreview(0),
                controller.buildSmallProductPreview(0),
                controller.buildSmallProductPreview(0),
                Spacer(),
                RoundedIconBtn(
                  icon: Icons.remove,
                  press: () {

                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
                RoundedIconBtn(
                  icon: Icons.add,
                  showShadow: true,
                  press: () {
                    controller.pickImage();
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildProductNameField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildFactoryNameField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildDescriptionField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildCategoryField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildUOMField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildPriceField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            controller.buildPriceAfterDiscountField(),
            SizedBox(height: getProportionateScreenHeight(40)),
            CustomButton(
              text: create.tr,
              press: () {
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
                // if all are valid then go to success screen

                KeyboardUtil.hideKeyboard(context);
                controller.updateProduct( context,widget.id );
              },
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
          ],
        ),
      ),
    );});
  }



}
