import 'package:flutter/material.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../couriers/components/couriers_data.dart';
import '../order_details/order_courier_screen.dart';

class OrderChangeCourierScreen extends StatelessWidget {
  static var routeName="/order_change_courier";
   final int id;
  const OrderChangeCourierScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
               CouriersData1(id: id,),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );
  }
}
