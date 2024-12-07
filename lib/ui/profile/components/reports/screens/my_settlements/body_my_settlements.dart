import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/profile/components/reports/components/card_widget.dart';
import 'package:merchant/ui/profile/components/reports/components/card_widget_content.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../../components/custom_button.dart';
import '../../../../../../util/size_config.dart';

class BodyMySettlements extends StatefulWidget {
  const BodyMySettlements({Key? key}) : super(key: key);

  @override
  State<BodyMySettlements> createState() => _BodyMySettlementsState();
}

class _BodyMySettlementsState extends State<BodyMySettlements> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CustomText(
                text: "Last Settlements Date",
                fontSize: 16,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "20 March 2022",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          Row(
            children: const [
              Expanded(
                  child: CardWidget(
                cardChild: RCardContent(
                  labelName: 'Total',
                  total: '15000',
                  currency: 'LE',
                ),
              )),
              Expanded(
                  child: CardWidget(
                cardChild: RCardContent(
                  labelName: 'Mine',
                  total: '1200',
                  currency: 'LE',
                ),
              ))
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          Row(
            children: const [
              Expanded(
                  child: CardWidget(
                cardChild: RCardContent(
                  labelName: 'Application',
                  total: '300',
                  currency: 'LE',
                ),
              )),
              Expanded(
                  child: CardWidget(
                cardChild: RCardContent(
                  labelName: 'Debit',
                  total: '200',
                  currency: 'LE',
                ),
              ))
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16)),
            child: CustomButton(
                text: "Pay",
                press: () {
                  Navigator.pop(context);
                }),
          ),
        ]));
  }
}
