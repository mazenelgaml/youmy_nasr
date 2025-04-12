import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:merchant/components/branch_card.dart';

import '../../../../../data/model/Branch.dart';
import '../../../../../util/size_config.dart';
import '../controller/branches_controller.dart';


class BranchesData extends StatelessWidget {
  const BranchesData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
              ? Center(child: CircularProgressIndicator()) :Column(
            children: [
              ...List.generate(
                controller.branchesNames?.length??0,
                    (index) {
                      return controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
                          ? Center(child: CircularProgressIndicator()): BranchCard(branch:controller.branches[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );});
  }
}
