import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/profile/components/reports/components/card_widget.dart';
import 'package:merchant/ui/profile/components/reports/components/card_widget_content.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../../components/custom_button.dart';
import '../../../../../../util/size_config.dart';

class BodyDeliveredSettlements extends StatefulWidget {
  const BodyDeliveredSettlements({Key? key}) : super(key: key);

  @override
  State<BodyDeliveredSettlements> createState() =>
      _BodyDeliveredSettlementsState();
}

class _BodyDeliveredSettlementsState
    extends State<BodyDeliveredSettlements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child:Center(child: CustomText(
          text: "No Design Provided for this screen",
    fontSize: 18,
    fontColor: KPrimaryColor,
    fontWeight: FontWeight.bold,
    ),)

    ));
  }
}
