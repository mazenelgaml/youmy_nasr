import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant/components/action_button.dart';
import 'package:merchant/components/product_card.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/ui/home/components/orders/client_location/location_screen.dart';
import 'package:merchant/ui/home/components/orders/order_change_courier/order_courier_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../data/model/Order.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import 'package:timelines/timelines.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);
  static var routeName = "/order_details";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final OrderDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as OrderDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const CustomText(
          text: "Order Details",
          fontSize: 23,
          fontColor: KPrimaryColor,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Cancel Order', 'Change Courier'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  onTap: () {
                    if(choice=="Change Courier") {
                      _showToast(choice);
                      Navigator.pushNamed(context, OrderChangeCourierScreen.routeName);
                    }
                    else
                      _showToast(choice);

                  },
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "Order Number: ",
                ),
                CustomText(
                    text: args.order.id.toString(),
                    fontSize: 22,
                    fontColor: KPrimaryColor),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Date: "),
                CustomText(
                  text: args.order.date,
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Branch Name: "),
                CustomText(
                  text: args.order.branchName,
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              children: [
                _getStatusIcon(args.order.status),
                SizedBox(
                  width: getProportionateScreenWidth(4),
                ),
                CustomText(
                  text: args.order.statusDescription,
                  fontColor: getStatus(args.order.status),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(150),
              child: Timeline.tileBuilder(
                scrollDirection: Axis.horizontal,
                builder: TimelineTileBuilder.fromStyle(
                  contentsAlign: ContentsAlign.basic,
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: InkWell(
                      child: CustomText(text: '${orderStatusList[index]}'),
                      onTap: () {
                        _showToast(
                            'Want to Change order from ${orderStatusList[index]}');
                      },
                    ),
                  ),
                  itemCount: orderStatusList.length,
                ),
              ),
            ),
            const Divider(),
            ...List.generate(subList.length,
                (index) => ProductCard(product: subList[index])),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Delivery  Fees: "),
                SizedBox(
                  width: getProportionateScreenWidth(4),
                ),
                const CustomText(
                  text: "10 LE",
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Container(
              width: getProportionateScreenWidth(double.infinity),
              height: getProportionateScreenHeight(50),
              color: KPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CustomText(
                    text: "Total ",
                    align: Alignment.center,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(4),
                  ),
                  const CustomText(
                    text: "380 LE",
                    align: Alignment.center,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            const CustomText(
              text: "Cash ",
              align: Alignment.centerLeft,
              fontWeight: FontWeight.bold,
            ),
            const Divider(),
            SizedBox(height: getProportionateScreenHeight(16)),
            CustomText(
              text: "Notes",
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: "PLease don't forget to ring before leave",
            ),
            const Divider(),
            SizedBox(height: getProportionateScreenHeight(16)),
            CustomText(
              text: "Client Details",
              fontWeight: FontWeight.bold,
            ),
    SizedBox(
    height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: getProportionateScreenWidth(50),
                    child: Image.asset('assets/images/profile.png')),

                CustomText(
                  text: args.order.clientName,
                ),
                ActionButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _makePhoneCall(args.order.clientNo);
                  },
                ),
                ActionButton(
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _openClientLocation(context);
                  },
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Client Number: "),
                CustomText(
                  text: args.order.clientNo,
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(text: "Address: "),
                CustomText(
                  text: "10 yehia zakaria st.",
                ),
              ],
            ),
             const Divider(),
            const CustomText(
              text: "Courier Details",
              fontWeight: FontWeight.bold,
            ),

            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: getProportionateScreenWidth(50),
                    child: Image.asset('assets/images/profile.png')),
                CustomText(
                  text: args.order.clientName,
                ),
                ActionButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _makePhoneCall(args.order.clientNo);
                  },
                ),
                ActionButton(
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _openClientLocation(context);
                  },
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Client Number: "),
                CustomText(
                  text: args.order.clientNo,
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(text: "Address: "),
                CustomText(
                  text: "10 yehia zakaria st.",
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
          ],
        ),
      ),
    );
  }
}

_getStatusIcon(OrderState status) {
  switch (status) {
    case OrderState.DELIEVERED:
      // IconData(),
      return const Icon(
        Icons.done,
        color: KActiveColor,
      );
    case OrderState.ONWAY:
      return const Icon(
        Icons.train,
        color: accentColor,
      );
    case OrderState.CANCELLED:
      return const Icon(
        Icons.cancel,
        color: KInActiveColor,
      );
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

void _openClientLocation(BuildContext context) {
  Navigator.pushNamed(context, LocationScreen.routeName);
}

void handleClick(String value) {
  switch (value) {
    case 'Cancel Order':
      break;
    case 'Change Courier':

      break;
  }
}

class OrderDetailsArguments {
  final Order order;

  OrderDetailsArguments({required this.order});
}

void _showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: KPrimaryColor,
      fontSize: 16.0);
}
