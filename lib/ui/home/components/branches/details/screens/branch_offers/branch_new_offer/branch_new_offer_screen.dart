import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/product/offers/new_offer/body.dart';

import '../../../../../../../../components/custom_text.dart';
import '../../../../../../../../util/Constants.dart';

class BranchNewOfferScreen extends StatefulWidget {
  const BranchNewOfferScreen({Key? key}) : super(key: key);
  static var routeName = "/branch_new_offer";

  @override
  State<BranchNewOfferScreen> createState() => _BranchNewOfferScreenState();
}

class _BranchNewOfferScreenState extends State<BranchNewOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
          text: 'Create New Offer',
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
