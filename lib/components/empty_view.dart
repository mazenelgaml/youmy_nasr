import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../util/size_config.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20))),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset(
              'assets/images/empty_data.png',
              width: 200,
              height: 200,
            ),
            const CustomText(
              text: 'No Data Available',
              fontColor: KPrimaryColor,
              fontSize: 20,
              align: Alignment.center,
            )
          ],
        ),
      ),
    ]);
  }
}
