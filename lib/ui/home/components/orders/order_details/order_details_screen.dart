import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:merchant/components/action_button.dart';
import 'package:merchant/components/product_card.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/data/model/courier.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/orders/client_location/location_screen.dart';
import 'package:merchant/ui/home/components/orders/order_change_courier/order_courier_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:merchant/models/order_details_model.dart' as d;
import '../../../../../components/custom_text.dart';
import '../../../../../data/model/Order.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import 'package:timelines_plus/timelines_plus.dart';


import '../controller/orders_controller.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int id;
  const OrderDetailsScreen({super.key, required this.id, required this.empId});
  static var routeName = "/order_details";
final int empId;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: OrdersController(),
    builder: (OrdersController controller) {

    d.Datum? details= controller.findOrderById(widget.id);
    Courier? courier= controller.findCourierById(details?.courierCode??0);
    Order? order= controller.findOrdersById(widget.id);
    List<Product>orderProducts=details?.fullSellOrderDetailMobileDto?.map((product){return Product(id: product.id.toString(), images: [], colors: [], title: product.itemName??"", price: product.price?.toDouble()??0, quantity: product.quantity??0, description: '' );}).toList()??[];
          return  Scaffold(
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
                      Get.to(()=>OrderChangeCourierScreen(id: order?.id??0,));
                    }  if(choice=="Cancel Order") {
                      controller.orderDelete(order?.id??0);
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
                    text: widget.id.toString(),
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
                  text: order?.date??"",
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Branch Name: "),
                CustomText(
                  text: details?.branchName??"",
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              children: [
                _getStatusIcon(order?.status ?? OrderState.InProgress),
                SizedBox(width: getProportionateScreenWidth(8)),
                DropdownButton<String>(
                  value: order?.statusDescription ?? "InProgress",
                  underline: SizedBox(), // Removes default underline
                  items: orderStatusList.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: CustomText(
                        text: status,
                        fontColor: getStatus(_mapEnglishStatus(status)),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null && value != order?.statusDescription) {
                      setState(() {
                        // Update locally
                        order?.statusDescription = value;
                        order?.status = _mapEnglishStatus(value);
                      });
                      // Update on backend
                      controller.updateOrderStatus(order?.id??0, value);
                      print("ORDERRRRRRRRRRRRRRRRRRRRRRRRRRSSSSSSSSSSSSSSSSSSS${order?.id}");
                    }
                  },
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
            ...List.generate(orderProducts.length,
                (index) => ProductCard(product: orderProducts[index])),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Delivery  Fees: "),
                SizedBox(
                  width: getProportionateScreenWidth(4),
                ),
                 CustomText(
                  text: "${details?.deliveryFee}"+"LE",
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
                   CustomText(
                    text:"${details?.totalValue??0}",
                    align: Alignment.center,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
             CustomText(
              text: details?.invoiceTypeName??"",
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
              text: details?.notes??"No notes",
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
                  text: order?.clientName??"Not available",
                ),
                ActionButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _makePhoneCall(details?.customerMobile??"Not available");
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
                  text: details?.customerMobile??"Not available",
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                CustomText(text: "Address: "),
                CustomText(
                  text:details?.customerAddress??"Not available" ,
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
                  text: details?.salesManName??"Not available",
                ),
                ActionButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _makePhoneCall(courier?.mobile??"Not available");
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
                const CustomText(text: "Courier Number: "),
                CustomText(
                  text: courier?.mobile??"Not available",
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
          ],
        ),
      ),
    );});
  }
}

Icon _getStatusIcon(OrderState status) {
  switch (status) {
    case OrderState.DELIEVERED:
      return const Icon(
        Icons.done,
        color: KActiveColor,
      );
    case OrderState.InWay:
      return const Icon(
        Icons.train,
        color: accentColor,
      );
    case OrderState.CANCELLED:
      return const Icon(
        Icons.cancel,
        color: KInActiveColor,
      );
    case OrderState.InProgress:
    // Handle the InProgress state, for example:
      return const Icon(
        Icons.access_time,
        color: Colors.orange, // Or any other color or icon that fits
      );
    default:
      throw UnimplementedError();
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
OrderState _mapEnglishStatus(String? status) {
  switch (status) {
    case "In Progress":
    case "New":
      return OrderState.InProgress;
    case "Delivery Done":
    case "Arrival Done":
    case "Receive Done":
      return OrderState.DELIEVERED;
    case "In Way":
      return OrderState.InWay;
    default:
      return OrderState.CANCELLED;
  }
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
