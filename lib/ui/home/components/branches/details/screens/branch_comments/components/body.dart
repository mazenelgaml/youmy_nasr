import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_comments/components/branch_comments_data.dart';
import '../../../../../../../../components/custom_text.dart';
import '../../../../../../../../util/Constants.dart';
import '../../../../../../../../util/size_config.dart';
import '../../../../controller/branches_controller.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(10)),
              CustomText(
                text: commentsTitle.tr,
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              const BranchCommentsData(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );});
  }
}
