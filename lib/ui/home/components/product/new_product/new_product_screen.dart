import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/product/new_product/components/body.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);
  static var routeName = "/new_product";

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
          text: 'Create New Product',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: const Body(),
    );
  }
}
