import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/home/components/orders/order_details/order_details_screen.dart';
import '../data/model/Order.dart';
import '../services/localization_services.dart';
import '../services/memory.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key? key,
    this.width = 30,
    this.height = 20,
    this.aspectRatio = 1.02,
    required this.order,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final Order order;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(
            context,
            OrderDetailsScreen.routeName,
            arguments: OrderDetailsArguments(order: widget.order),
          )
        },
        child: Column(
          children: [
            Container(
              width: getProportionateScreenWidth(double.infinity),
              height: getProportionateScreenHeight(220),
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                tag: widget.order.id.toString(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: widget.order.orderNo,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      align: Get.find<CacheHelper>().activeLocale ==
                          SupportedLocales.english
                          ? Alignment.topLeft
                          : Alignment.topRight,
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    CustomText(
                      text: widget.order.clientName,
                      fontSize: 22,
                      fontColor: KPrimaryColor,
                      align: Get.find<CacheHelper>().activeLocale ==
                          SupportedLocales.english
                          ? Alignment.topLeft
                          : Alignment.topRight,
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    CustomText(
                      text: widget.order.clientNo,
                      fontSize: 18,
                      align: Get.find<CacheHelper>().activeLocale ==
                          SupportedLocales.english
                          ? Alignment.topLeft
                          : Alignment.topRight,
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    CustomText(
                      text: widget.order.date,
                      fontSize: 18,
                      align: Get.find<CacheHelper>().activeLocale ==
                          SupportedLocales.english
                          ? Alignment.topLeft
                          : Alignment.topRight,
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        _getStatusIcon(widget.order.status),
                        SizedBox(width: getProportionateScreenWidth(4)),
                        CustomText(
                          text: widget.order.statusDescription,
                          fontColor: getStatus(widget.order.status),
                          fontSize: 21,
                          align: Alignment.bottomRight,
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon(OrderState status) {
    switch (status) {
      case OrderState.DELIEVERED:
        return Icon(Icons.done, color: KActiveColor);
      case OrderState.InWay:
        return Icon(Icons.train, color: accentColor);
      case OrderState.CANCELLED:
        return Icon(Icons.cancel, color: KInActiveColor);
      case OrderState.InProgress: // Add a default icon for "In Progress"
        return Icon(Icons.hourglass_empty, color: Colors.orange);
      default:
        return Icon(Icons.error, color: Colors.red); // Fallback for unexpected cases
    }
  }
}
