import 'package:flutter/cupertino.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/auth/signup/screens/address/new_address/new_address_body.dart';
import '../../../../../../components/custom_text.dart';
import '../../../../../../util/Constants.dart';
import '../../../../../../util/size_config.dart';
import 'package:get/get.dart';

import '../../../controller/signup_controller.dart';

class BodyNewAddressScreen extends StatelessWidget {
  const BodyNewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(context),
    builder: (SignupController controller) {
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
                 CustomText(text:merchantAdrress.tr ,align: Alignment.center,fontColor: KPrimaryColor,fontWeight: FontWeight.bold,),
                SizedBox(height: SizeConfig.screenHeight * 0.02),// 4%
                 const SignUpFormNewAddress(),

              ],
            ),
          ),
        ),
      ),
    );});
  }
}
