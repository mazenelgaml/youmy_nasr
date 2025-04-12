import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/components/order_card.dart';
import 'package:merchant/data/model/Order.dart';
import 'package:merchant/services/translation_key.dart';
import '../../../../../../components/custom_text.dart';
import '../../../../../../util/keyboard.dart';
import '../../controller/orders_controller.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Order> _orders = [];



  @override



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: OrdersController(),
        builder: (OrdersController controller) {
          return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: controller.buildSearchField()
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                onChanged: (value) => controller.runFilter(value,controller.searchoption),
                decoration: InputDecoration(
                  hintText: searchHintText.tr,
                  suffixIcon: IconButton(
                    onPressed: () => {KeyboardUtil.hideKeyboard(context)},
                    icon: Icon(Icons.search),
                  ),
                ),
              )),
          ...List.generate(
            controller.filteredOrders.length,
                (index) {
              return OrderCard(order: controller.filteredOrders[index]);// here by default width and height is 0
            },
          ),

        ],
      ),
    );});
  }




}
enum SearchOption { ORDER_NO, CLIENT_NO, CLIENT_NAME}


