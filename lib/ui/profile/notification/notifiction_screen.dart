import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/profile/notification/components/body.dart';

import '../../../services/localization_services.dart';
import '../../../services/memory.dart';
import '../../../util/Constants.dart';

class NotificationScreen extends StatefulWidget {
  static var routeName = "/notification_screen";

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   CustomText(
          text: Get.find<CacheHelper>()
              .activeLocale == SupportedLocales.english?'Notifications':"الإشعارات",
          fontSize: 21,
          fontColor: KPrimaryColor,
          align: Alignment.center,
        ),
      ),
      body: const Body(),
    );
  }
}
