import 'package:flutter/material.dart';

import '../../../../../../../components/product_card.dart';
import '../../../../../../../data/model/Product.dart';

class BranchProductData extends StatefulWidget {
  const BranchProductData({Key? key}) : super(key: key);

  @override
  State<BranchProductData> createState() => _BranchProductDataState();
}

class _BranchProductDataState extends State<BranchProductData> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: demoProducts
            .map((product) =>
            ProductCard1(product: product))
            .toList());
  }
}
