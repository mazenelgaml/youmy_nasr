import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/auth/signup/screens/attachments/attachments_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'controller/signup_controller.dart';
import 'screens/general_information/body_general_information.dart';
import 'screens/merchant_details/body_merchant_details.dart';
import 'screens/address/new_address/new_adress_screen.dart';

class SignUpScreen extends StatelessWidget {
  static var routeName = "/signup";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            bottom: const TabBar(
              labelStyle:tabBarStyle,
              labelColor: KPrimaryColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.manage_accounts,size:40,),

                ),
                Tab(
                  icon: Icon(Icons.store,size:40,),
                ),
                Tab(
                  icon: Icon(Icons.list_alt,size:40,),
                ),
                Tab(
                  icon: Icon(Icons.location_on,size:40,),
                ),
              ],
            )),
        body: const TabBarView(

          children: [
            BodyPersonalInformation(),
            BodyMerchantDetails(),
            BodyAttachments(),
            BodyNewAddressScreen(),
          ],
        ),
      ),
    );
  }
}
