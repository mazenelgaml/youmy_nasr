

import 'package:flutter/material.dart';

import '../../../../../../../../components/courier_card.dart';
import '../../../../../../../../data/model/courier.dart';
import '../../../../../../../../util/size_config.dart';

class BranchCourierData extends StatefulWidget {
  const BranchCourierData({Key? key}) : super(key: key);

  @override
  State<BranchCourierData> createState() => _BranchCourierDataState();
}

class _BranchCourierDataState extends State<BranchCourierData> {
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
                demoCouriers.length,
                    (index) {
                  return CourierCard(courier: demoCouriers[index]);// here by default width and height is 0
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
