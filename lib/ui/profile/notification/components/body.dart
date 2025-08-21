import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../components/notification_card.dart';
import '../../../../util/size_config.dart';
import '../controller/notification_controller.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NotificationController(),
    builder: (NotificationController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SafeArea(
        child: controller.isLoading.value?Center(child: CircularProgressIndicator(),):Column(
          children: [
            ...List.generate(
              controller.demoNotificationDatas.length,
                  (index) {
                return NotificationCard(notification: controller.demoNotificationDatas[index]);// here by default width and height is 0
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );});
  }
}
