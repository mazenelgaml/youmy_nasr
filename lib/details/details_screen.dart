import 'package:flutter/material.dart';
import 'package:merchant/components/action_button.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/home/components/product/comments/comments_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/CustomAlertDialog.dart';
import 'package:merchant/util/size_config.dart';

import '../data/model/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: KBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        actions: [

          Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(10)),
            child: ActionButton(
              icon: Icon(Icons.delete, color: Colors.white),
              color: KInActiveColor,
              onPressed: () {
                _displayDialog(
                    context, 'Alert', 'Do you want to delete this product?!');
              },
            ),
          ),
          SizedBox(
            width:  getProportionateScreenWidth(10),
          ),
          ActionButton(
            icon: Icon(
              Icons.comment,
              color: Colors.white,

            ),
            onPressed: () {
              Navigator.pushNamed(context,CommentsScreen.routeName);
            },
          ),
          SizedBox(
            width:  getProportionateScreenWidth(10),
          ),
        ],
      ),
      body: Body(product: agrs.product),
    );
  }

  _displayDialog(BuildContext context, String title, String message) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    color: KPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(message),
              actions: [
                MaterialButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.pop(context)),
                MaterialButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context))
              ]);
        });
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
