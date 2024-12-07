import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/personal_information/body_courier_personal_information_tab.dart';

import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import 'body_courier_vehicle_information_tab.dart';


class VehicleInformationTab extends StatelessWidget {
  const VehicleInformationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                const CustomText(text: 'Vehicle Details',align: Alignment.center,fontColor: KPrimaryColor,fontWeight: FontWeight.bold,),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                const VehicleInformationBody(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
