import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text_form_field.dart';

import '../../../../../../components/product_card.dart';
import '../../../../../../data/model/Product.dart';
import '../../../../../../util/keyboard.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> _products = [];

  @override
  initState() {
    _products = demoProducts;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = demoProducts;
    } else {
      results = demoProducts
          .where((product) => product.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _products = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  hintText: "Enter data ...",
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
              children: _products.isNotEmpty
                  ? _products
                      .map((product) => ProductCard1(product: product))
                      .toList()
                  : _products
                      .map((product) => ProductCard1(product: product))
                      .toList()),
        ],
      ),
    );
  }
}
