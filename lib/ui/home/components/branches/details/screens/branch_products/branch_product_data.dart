import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../components/product_card.dart';
import '../../../../../../../data/model/Product.dart';
import '../../../controller/branches_controller.dart';

class BranchProductData extends StatefulWidget {
  const BranchProductData({Key? key}) : super(key: key);

  @override
  State<BranchProductData> createState() => _BranchProductDataState();
}

class _BranchProductDataState extends State<BranchProductData> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: controller.productsD
            .map((product) =>
            ProductCard1(product: product))
            .toList());});
  }
}
