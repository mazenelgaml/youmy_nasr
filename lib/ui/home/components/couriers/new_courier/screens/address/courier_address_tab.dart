import 'package:flutter/material.dart';
import 'package:merchant/components/custom_button.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/ui/auth/signup/screens/address/address_form.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/address/branch_address_body.dart';

import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import '../../../../../home_screen.dart';

final List<String> cities = [
  "Select City",
  "Cairo",
  "Alexandria",
  "Luxor",
  "Sharkia",
  "Marsa Matrouh",
  "Suiez",
  "Phayioum"
];

final List<String> regions = [
  "Select Region",
  "Maddi",
  "Tahrir",
  "Down Town",
  "5th Setellment",
  "Aobour",
  "Nasr City",
  "Hadayek Helwan"
];
var selectedCity = cities.first;
var selectedRegion = regions.first;

class CourierAddressTab extends StatefulWidget {
  const CourierAddressTab({Key? key}) : super(key: key);

  @override
  State<CourierAddressTab> createState() => _CourierAddressTabState();
}

class _CourierAddressTabState extends State<CourierAddressTab> {
  //region variables
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
                const CustomText(text: 'Address',align: Alignment.center,fontColor: KPrimaryColor,fontWeight: FontWeight.bold,),
                SizedBox(height: SizeConfig.screenHeight * 0.02),// 4%
                const BranchAddressBody(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  //endregion

}
