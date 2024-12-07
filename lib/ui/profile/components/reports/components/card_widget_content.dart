import 'package:flutter/material.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';

class RCardContent extends StatelessWidget {
  const RCardContent(
      {Key? key,
      required this.labelName,
      required this.total,
      required this.currency})
      : super(key: key);

  final String labelName, total, currency;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: KOpacityPrimaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CustomText(
              align: Alignment.center,
              text: labelName,
              fontColor: KPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                CustomText(
                  text: total,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text:currency,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )
            , const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
