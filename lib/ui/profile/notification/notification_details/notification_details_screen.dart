import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/NotificationData.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../util/size_config.dart';

class NotificationDetailsScreen extends StatelessWidget {
  static var routeName = "/notification_details";


  const NotificationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationDetailsArguments args =
    ModalRoute.of(context)!.settings.arguments as NotificationDetailsArguments;
    return Scaffold(
      appBar: AppBar(title: const CustomText(text: 'Notification Details',fontColor: KPrimaryColor,),),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),vertical:getProportionateScreenHeight(20) ),
        child:   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomText(
              text: args.notificationData.title,
              fontSize: 25,
              fontColor: KPrimaryColor,
              align: Alignment.center,),
            SizedBox(height: getProportionateScreenHeight(20)),
            CustomText(text: args.notificationData.description, fontSize: 21),
            SizedBox(height: getProportionateScreenHeight(10)),


          ],
        ),
    ),
    );
  }
}

class NotificationDetailsArguments {
  final NotificationData notificationData;

  NotificationDetailsArguments({required this.notificationData});
}
