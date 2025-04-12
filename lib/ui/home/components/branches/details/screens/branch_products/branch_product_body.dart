
import 'package:flutter/material.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_products/branch_product_data.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/home/components/product/new_product/new_product_screen.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';

import '../../../../product/update_product/update_product_screen.dart';
import '../../../controller/branches_controller.dart';

bool haveData = true;

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller.scroll,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(10)),
              CustomText(
                text: productScreenTitle.tr,
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),

               BranchProductData(  ),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          Get.to(()=> NewProductScreen( ));
        },
        child: const Icon(
          Icons.add,
          size: 29,
        ),
      ),
    );});
  }
}