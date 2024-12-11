import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../components/courier_card.dart';

import '../../../../../util/size_config.dart';
import '../../product/show_all_branches/product_branches_filter_screen.dart';
import '../controller/couriers_controller.dart';
 // Ensure correct import here



class CouriersData extends StatefulWidget {
  const CouriersData({Key? key}) : super(key: key);

  @override
  State<CouriersData> createState() => _CouriersDataState();
}

class _CouriersDataState extends State<CouriersData> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CouriersController(),
        builder: (CouriersController controller) {
          return
            Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            "Maadi",
            "Helwan",
            "Tahrir",
            "H-Kopa",
            "New Cairo",
            "All"
          ]
              .map((String name) => GestureDetector(
            child: Chip(
              avatar: CircleAvatar(
                child: Text(name.substring(0, 1)),
              ),
              label: Text(
                name,
              ),
            ),
            onTap: () {

              if(name=="All")
              {
                Navigator.pushNamed(context, ProductBranchesFilterScreen.routeName);
              }
              else
                controller.showToast("$name is Pressed");
            },
          ))
              .toList(),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                controller.couriersD.length,
                    (index) {
                      return  CourierCard(courier:controller.couriersD[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );});
  }

}
