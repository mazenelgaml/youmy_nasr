

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../components/courier_card.dart';
import '../../../../../../../../data/model/courier.dart';
import '../../../../../../../../util/size_config.dart';
import '../../../../../orders/components/body.dart';
import '../../../../controller/branches_controller.dart';

class BranchCourierData extends StatefulWidget {
  const BranchCourierData({Key? key}) : super(key: key);

  @override
  State<BranchCourierData> createState() => _BranchCourierDataState();
}

class _BranchCourierDataState extends State<BranchCourierData> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return  Column(
      children: [
        Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),

        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:controller.isLoading.value? CircularProgressIndicator():Column(
            children: [
              ...List.generate(
                controller.couriersD.length,
                    (index) {
                  return CourierCard(courier: controller.couriersD[index]);// here by default width and height is 0
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
