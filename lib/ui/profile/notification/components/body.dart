import 'package:flutter/material.dart';
import 'package:merchant/data/model/NotificationData.dart';

import '../../../../components/courier_card.dart';
import '../../../../components/notification_card.dart';
import '../../../../data/model/courier.dart';
import '../../../../util/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SafeArea(
        child: Column(
          children: [
            ...List.generate(
              demoNotificationDatas.length,
                  (index) {
                return NotificationCard(notification: demoNotificationDatas[index]);// here by default width and height is 0
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );
  }
}
