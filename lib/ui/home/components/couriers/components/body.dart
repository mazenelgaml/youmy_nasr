import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/branches/components/branches_data.dart';
import 'package:merchant/ui/home/components/couriers/components/couriers_data.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/new_courier_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/data/model/courier.dart' as your_courier;

import '../../../../../util/size_config.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:  CustomText(
          text: couriersTitle.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const CouriersData(),
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
    );
  }
}
