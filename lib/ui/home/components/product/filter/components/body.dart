import 'package:flutter/material.dart';
import 'package:merchant/components/custom_action_chip.dart';
import 'package:merchant/components/custom_button.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/data/model/Brand.dart';
import 'package:merchant/data/model/Category.dart';
import 'package:merchant/data/model/SubCategory.dart';
import 'package:merchant/data/model/SubSubCategory.dart';
import '../../../../../../components/custom_chip.dart';
import '../../../../../../components/product_card.dart';
import '../../../../../../data/model/Product.dart';
import '../../../../../../util/Constants.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CustomText(
              text: 'Categories',
              fontSize: 20,
              align: Alignment.topLeft,
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: demoCategories
                  .map((category) =>
                  CustomChip(type: 2,  label: category.title, onSelected: () {},onPressed: (){},)).toList(),
              // children: List.generate(
              //     5, (index) => CustomChip(type: 2,  label: "label", onSelected: () {},onPressed: (){},)),
            ),
            const Divider(),
            const CustomText(
              text: 'Sub Categories',
              fontSize: 20,
              align: Alignment.topLeft,
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: demoSubCategories
                  .map((subCategory) =>
                  CustomChip(type: 2,  label: subCategory.title, onSelected: () {},onPressed: (){},)).toList(),
            ),
            const Divider(),
            const CustomText(
              text: 'Child Sub Categories',
              fontSize: 20,
              align: Alignment.topLeft,
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: demoSubSubCategories
                  .map((subCategory) =>
                  CustomChip(type: 2,  label: subCategory.title, onSelected: () {},onPressed: (){},)).toList(),
            ),
            const Divider(),
            const CustomText(
              text: 'Brands',
              fontSize: 20,
              align: Alignment.topLeft,
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 4,
                children: demoBrandsList
                    .map((brand) =>
                    CustomChip(type: 2,  label: brand.title, onSelected: () {},onPressed: (){},)).toList()
            ),
            const Divider(),
            SizedBox(height: getProportionateScreenHeight(30),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: 'Apply',press: (){
                Navigator.pop(context);
              },),
            )
          ],
        ),
      ),
    );
  }
}
