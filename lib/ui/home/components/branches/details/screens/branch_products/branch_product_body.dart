
import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_products/branch_product_data.dart';

import '../../../../../../../components/custom_text.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import '../../../../product/new_product/new_product_screen.dart';

bool haveData = true;

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(10)),
              CustomText(
                text: 'Products',
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),

              const BranchProductData(  ),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, NewProductScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          size: 29,
        ),
      ),
    );
  }
}