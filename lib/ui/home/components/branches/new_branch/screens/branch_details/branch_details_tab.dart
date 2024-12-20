import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/profile_image_widget.dart';
import '../../../../../../../services/translation_key.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import 'package:get/get.dart';

import 'body_branch_details_tab.dart';


class BranchDetailsTab extends StatelessWidget {
  const BranchDetailsTab({Key? key}) : super(key: key);

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
             CustomText(text: branchDetails.tr,align: Alignment.center,fontColor: KPrimaryColor,fontWeight: FontWeight.bold,),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                const BranchDetailsBody(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
