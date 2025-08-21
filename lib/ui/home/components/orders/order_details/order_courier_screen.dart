import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:merchant/ui/home/components/orders/order_details/order_details_screen.dart';

import '../../../../../components/courier_card.dart';

import '../../../../../util/size_config.dart';
import '../../couriers/controller/couriers_controller.dart';
import '../../product/show_all_branches/product_branches_filter_screen.dart';




class CouriersData1 extends StatefulWidget {
  final int id;
  const CouriersData1({Key? key, required this.id}) : super(key: key);

  @override
  State<CouriersData1> createState() => _CouriersDataState();
}

class _CouriersDataState extends State<CouriersData1> {
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
                Padding(
                  padding: const EdgeInsets.only(left: 3,right: 3,bottom:10),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 5,
                    children: controller.branches
                        .map((String name) => GestureDetector(
                      child: Chip(
                        avatar: CircleAvatar(
                          child: Text(name.substring(0, 1)),
                        ),
                        label: Text(
                          name,
                        ),
                      ),
                      onTap: () async{

                        if(name=="All")
                        {
                          Navigator.pushNamed(context, ProductBranchesFilterScreen.routeName);
                        }
                        else{
                          int branchCode=  controller.branchesNames?.firstWhere((branch) => branch.branchName == name).branchCode??0;
                          await controller.CouriersListsOfBranch(branchCode);
                        }
                      },
                    ))
                        .toList(),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
                      ? Center(child: CircularProgressIndicator()) :Column(
                    children: [
                      ...List.generate(
                        controller.couriersD.length,
                            (index) {
                          return  InkWell(onTap:(){
                            controller.updateSalesMan(widget.id, controller.couriersD[index].id??0);
                          },child: CourierCard(courier:controller.couriersD[index]));// here by default width and height is 0
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
