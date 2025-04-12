import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../components/product_card.dart';
import '../../../../../../services/translation_key.dart';
import '../../../../../../util/keyboard.dart';
import '../../controller/products_controller.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(context),
    builder: (ProductsController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                onChanged: (value) => controller.runFilter(value),
                decoration: InputDecoration(
                  hintText: searchHintText.tr,
                  suffixIcon: IconButton(
                    onPressed: () => {KeyboardUtil.hideKeyboard(context)},
                    icon: Icon(Icons.search),
                  ),
                ),
              )),
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              childAspectRatio: 1,
              // children: demoProducts
              //     .map((product) => ProductCard1(product: product))
              //     .toList()),
              children: controller.products.isNotEmpty
                  ? controller.products
                      .map((product) => ProductCard1(product: product))
                      .toList()
                  : controller.products
                      .map((product) => ProductCard1(product: product))
                      .toList()),
        ],
      ),
    );});
  }
}
