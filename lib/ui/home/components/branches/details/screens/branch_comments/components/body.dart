import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_comments/components/branch_comments_data.dart';

import '../../../../../../../../components/custom_text.dart';
import '../../../../../../../../util/Constants.dart';
import '../../../../../../../../util/size_config.dart';

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
                text: 'Comments',
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              const BranchCommentsData(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );
  }
}
