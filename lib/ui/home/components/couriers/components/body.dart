import 'package:flutter/material.dart';
import 'package:merchant/components/branch_card.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/ui/home/components/branches/components/branches_data.dart';
import 'package:merchant/ui/home/components/couriers/components/couriers_data.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/new_courier_screen.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../util/size_config.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const CustomText(
          text: 'Couriers',
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
