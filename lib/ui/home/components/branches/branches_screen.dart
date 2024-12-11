import 'package:flutter/material.dart';
import 'package:merchant/components/branch_card.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/ui/home/components/branches/components/branches_data.dart';
import 'package:merchant/ui/home/components/branches/new_branch/new_branch_screen.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../util/size_config.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig here
    SizeConfig().init(context);

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
              const BranchesData(),
              SizedBox(height: getProportionateScreenWidth(30)), // Now safe to use
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, NewBranchScreen.routeName);
        },
        child: const Icon(
          Icons.add, size: 29,
        ),
      ),
    );
  }
}
