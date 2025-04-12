import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/product_card.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../util/size_config.dart';
import '../controller/products_controller.dart';

class ProductsData extends StatefulWidget {
  bool isGridView = true;

  ProductsData({Key? key, required this.isGridView}) : super(key: key);

  @override
  State<ProductsData> createState() => _ProductsDataState();
}

class _ProductsDataState extends State<ProductsData> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
        init: ProductsController(context),
    builder: (ProductsController controller) {
    return controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
        ? Center(child: CircularProgressIndicator()) :widget.isGridView
        ?controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
        ? Center(child: CircularProgressIndicator()) : GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(8),
            childAspectRatio: 1.1,
            children: controller.productsD
                .map((product) => ProductCard1(product: product))
                .toList())
        :
    ListView.builder(
      padding: const EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 15),
            itemCount: controller.productsD.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(controller.productsD[index].id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    controller.productsD.removeAt(index);
                    // controller.productDelete(controller.productsD[index].id);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: ProductCard1(product: controller.productsD[index]),
              ),
            ),
          );});
  }
}
