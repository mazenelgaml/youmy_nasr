
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_courier/components/branch_courier_data.dart';
import '../../../../../../../../components/custom_text.dart';
import '../../../../../../../../util/Constants.dart';
import '../../../../../../../../util/size_config.dart';
import '../../../../../couriers/components/couriers_data.dart';
import '../../../../../couriers/new_courier/new_courier_screen.dart';
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
                text: couriersTitle.tr,
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              const BranchCourierData(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, NewCourierScreen.routeName);
        },
        child:  const Icon(
          Icons.add,size: 29,
        ),
      ),
    );});
  }
}