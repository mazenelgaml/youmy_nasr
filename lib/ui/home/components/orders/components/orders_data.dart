import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/empty_view.dart';
import 'package:merchant/components/order_card.dart';
import 'package:merchant/data/model/Order.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../util/size_config.dart';

class OrdersData extends StatelessWidget {
  const OrdersData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoOrders.length,
                    (index) {
                  return OrderCard(order: demoOrders[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
