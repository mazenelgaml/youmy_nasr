import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/product_card.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../util/size_config.dart';

class ProductsData extends StatefulWidget {
  bool isGridView = true;

  ProductsData({Key? key, required this.isGridView}) : super(key: key);

  @override
  State<ProductsData> createState() => _ProductsDataState();
}

class _ProductsDataState extends State<ProductsData> {
  @override
  Widget build(BuildContext context) {
    return widget.isGridView
        ? GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(8),
            childAspectRatio: 1,
            children: demoProducts
                .map((product) => ProductCard1(product: product))
                .toList())
        :
    ListView.builder(
      padding: const EdgeInsets.all(8),
            itemCount: demoProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(demoProducts[index].id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    demoProducts.removeAt(index);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: ProductCard1(product: demoProducts[index]),
              ),
            ),
          );
  }
}
