import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../components/custom_button.dart';
import '../../../../../../components/rounded_icon_btn.dart';
import '../../../../../../services/translation_key.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';
import '../../controller/new_product_controller.dart';


class NewProductScreenBody extends StatefulWidget {

  const NewProductScreenBody({super.key});

  @override
  State<NewProductScreenBody> createState() => _BodyState();
}

class _BodyState extends State<NewProductScreenBody> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewProductController>(
      init: NewProductController(context),
      builder: (NewProductController controller) {
        return controller.isLoading.value?CircularProgressIndicator():Form(
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
                    // Render images dynamically from the controller's image list
                    ...List.generate(
                      controller.productImages.length,
                          (index) => controller.buildSmallProductPreview(index),
                    ),
                    const Spacer(),
                    // Minus button
                    RoundedIconBtn(
                      icon: Icons.remove,
                      press: () {
                        controller.removeImage();
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    // Plus button
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
                controller.buildProductNameAraField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                controller.buildDescriptionField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                controller.buildProductCodeField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : controller.buildProductGroupField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : controller.buildProductclassificationField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : controller.buildProductBrandField(),
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
                    KeyboardUtil.hideKeyboard(context);
                    controller.createProduct(context);
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
              ],
            ),
          ),
        );
      },
    );
  }
}

