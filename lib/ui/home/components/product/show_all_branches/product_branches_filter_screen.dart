import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/product/show_all_branches/products_filter_branches_data.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../branches/components/branches_data.dart';

class ProductBranchesFilterScreen extends StatefulWidget {
  const ProductBranchesFilterScreen({Key? key}) : super(key: key);
  static var routeName = "/ProductsBranchesFilterScreen";

  @override
  State<ProductBranchesFilterScreen> createState() =>
      _ProductBranchesFilterScreenState();
}

class _ProductBranchesFilterScreenState
    extends State<ProductBranchesFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const CustomText(
          text: 'Branches',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Body(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );
  }
}
