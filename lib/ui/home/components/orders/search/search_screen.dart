import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/orders/search/components/body.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';

class OrderSearchScreen extends StatefulWidget {
  const OrderSearchScreen({Key? key}) : super(key: key);
  static var routeName = "/order_search";

  @override
  State<OrderSearchScreen> createState() => _OrderSearchScreenState();
}

class _OrderSearchScreenState extends State<OrderSearchScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const CustomText(
    text: 'Search',
    align: Alignment.center,
    fontColor: KPrimaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(
          text: 'Search',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ) ,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: Body(),
    );
  }

}
