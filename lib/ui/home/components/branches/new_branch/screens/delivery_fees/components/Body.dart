import 'package:flutter/material.dart';
import 'package:merchant/data/model/Delivery.dart';

import '../../../../../../../../components/attachment_card.dart';
import '../../../../../../../../components/delivery_card.dart';
import '../../../../../../../../data/model/Attachment.dart';
import '../../../../../../../../data/model/Product.dart';
import '../../../../../../../../util/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoDeliveries.length,
                    (index) {
                      return DeliveryCard(delivery: demoDeliveries[index]);
                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),

            ],
          ),
        ),



      ],
    );
  }
}
