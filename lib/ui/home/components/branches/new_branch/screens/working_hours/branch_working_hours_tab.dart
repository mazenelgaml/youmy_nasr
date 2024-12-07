import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/working_hours/body_branch_working_hours_tab.dart';

import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';

class BranchWorkingHoursTab extends StatelessWidget {
  const BranchWorkingHoursTab({Key? key}) : super(key: key);

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
                const CustomText(text: 'Working Hours',align: Alignment.center,fontColor: KPrimaryColor,fontWeight: FontWeight.bold,),
                SizedBox(height: SizeConfig.screenHeight * 0.02),// 4%
                const BranchWorkingHoursBody(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
