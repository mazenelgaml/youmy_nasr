import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/product/new_product/components/body.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';

class NewProductScreen extends StatefulWidget {
  final int id;
  const NewProductScreen({Key? key, required this.id}) : super(key: key);
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
        title:  CustomText(
          text: createNewProduct.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body:  Body( id: widget.id,),
    );
  }
}
