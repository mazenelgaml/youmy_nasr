import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/branches/components/branches_data.dart';
import 'package:merchant/ui/home/components/branches/controller/new_branch_controller.dart';
import 'package:merchant/ui/home/components/branches/new_branch/new_branch_screen.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../util/size_config.dart';
import 'controller/branches_controller.dart';

class BranchesScreen extends StatelessWidget {

  const BranchesScreen({Key? key}) : super(key: key);
  static var routeName = "/branches";
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: BranchesController(),
    builder: (BranchesController controller) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:  CustomText(
          text: branchesScreenTitle.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
              ? Center(child: CircularProgressIndicator()) :Column(
            children: [
              controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
                  ? Center(child: CircularProgressIndicator()) :  BranchesData(),
              SizedBox(height: getProportionateScreenWidth(30)), // Now safe to use
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          Get.put(NewBranchController(context));
          Navigator.pushNamed(context, NewBranchScreen.routeName);
        },
        child: const Icon(
          Icons.add, size: 29,
        ),
      ),
    );});
  }
}
