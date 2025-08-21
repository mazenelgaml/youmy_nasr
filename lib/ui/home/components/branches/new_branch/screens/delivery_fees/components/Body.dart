import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../../../../../components/delivery_card.dart';
import '../../../../../../../../util/size_config.dart';
import '../../../../controller/new_branch_controller.dart';
import '../branch_dlivery_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewBranchController(context),
    builder: (NewBranchController controller) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: controller.isLoading?Center(child: CircularProgressIndicator(),):Column(
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
    });
  }
}
