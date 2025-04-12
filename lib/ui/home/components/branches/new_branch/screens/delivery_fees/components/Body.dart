import 'package:flutter/material.dart';
import '../../../../../../../../components/delivery_card.dart';
import '../../../../../../../../util/size_config.dart';
import '../branch_dlivery_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

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
                },
              ),

            ],
          ),
        ),



      ],
    );
  }
}
