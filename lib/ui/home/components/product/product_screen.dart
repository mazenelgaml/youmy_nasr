import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/product/components/body.dart';
import 'package:merchant/ui/home/components/product/offers/offers_body.dart';

import '../../../../components/custom_text.dart';
import '../../../../util/Constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static var routeName = "/Products";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: TabBar(
                labelStyle: tabBarStyle,
                labelColor: KPrimaryColor,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.apps,
                      size: 40,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.local_offer_outlined,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [ProductsBody(), OffersBody()],
            ),
          ),
        ),
      ),
    );
  }
}
