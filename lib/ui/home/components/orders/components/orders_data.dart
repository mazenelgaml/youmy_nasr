import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/empty_view.dart';
import 'package:merchant/components/order_card.dart';
import 'package:merchant/util/Constants.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../util/size_config.dart';
import '../controller/orders_controller.dart';

class OrdersData extends StatelessWidget {
  const OrdersData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      init: OrdersController(),
      builder: (OrdersController controller) {
        // Show loading indicator
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show empty state if no orders exist
        if (controller.orders.isEmpty) {
          return  EmptyView(
            message: Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english? 'No orders found.':'لم يتم العثور على طلبات',
          );
        }

        // Show the list of orders
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...List.generate(
                    controller.orders.length,
                        (index) => OrderCard(order: controller.orders[index]),
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
