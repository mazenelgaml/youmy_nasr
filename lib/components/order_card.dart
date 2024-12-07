import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:merchant/ui/home/components/orders/order_details/order_details_screen.dart';
import '../data/model/Order.dart';
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
              height: getProportionateScreenHeight(200),
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
                       align: Alignment.topLeft,),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      CustomText(text: widget.order.clientName, fontSize: 22,fontColor: KPrimaryColor),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      CustomText(text: widget.order.clientNo, fontSize: 18),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      CustomText(text: widget.order.date, fontSize: 18,),

                      SizedBox(height: getProportionateScreenHeight(10)),
                      Row(
                        children: [
                          _getStatusIcon(widget.order.status),
                          SizedBox(width: getProportionateScreenWidth(4),),
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
                  )),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



_getStatusIcon(OrderState status)
{
  switch(status)
  {

      case OrderState.DELIEVERED:
        // IconData(),
        return Icon(Icons.done,color: KActiveColor,);
      case OrderState.ONWAY:
        return Icon(Icons.train,color: accentColor,);
      case OrderState.CANCELLED:
        return Icon(Icons.cancel,color: KInActiveColor,);

    }
}
