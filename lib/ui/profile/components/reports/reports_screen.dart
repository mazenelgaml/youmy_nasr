import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/profile/components/reports/screens/delivered_settlements/body_delivered_settlements.dart';
import 'package:merchant/ui/profile/components/reports/screens/my_settlements/body_my_settlements.dart';
import 'package:merchant/ui/profile/components/reports/screens/un_delivered_settlements/body_un_delivered_settlements.dart';
import 'package:merchant/util/Constants.dart';

class ReportScreen extends StatelessWidget {
  static var routeName = "/report";

  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const CustomText(
              text: 'Settlements Reports',
              align: Alignment.center,
              fontColor: KPrimaryColor,
            ),
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
            bottom: const TabBar(
              labelStyle: tabBarStyle,
              labelColor: KPrimaryColor,
              tabs: [
                Tab(
                  child: CustomText(
                    text: "Mine",
                  ),
                ),
                Tab(
                  child: CustomText(
                    fontSize:17 ,
                    text: "Un Delivered",
                  ),
                ),
                Tab(
                  child: CustomText(
                    text: "Delivered",
                  ),
                ),
              ],
            )),
        body: const TabBarView(
          children: [
            BodyMySettlements(),
            BodyUnDeliveredSettlements(),
            BodyDeliveredSettlements(),
          ],
        ),
      ),
    );
  }
}
