import 'package:flutter/material.dart';
import 'package:merchant/components/branch_card.dart';
import 'package:merchant/ui/home/components/product/show_all_branches/components/product_branch_card.dart';

import '../../../../../data/model/Branch.dart';
import '../../../../../util/size_config.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoBranches.length,
                    (index) {
                      return ProductBranchCard(branch: demoBranches[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
