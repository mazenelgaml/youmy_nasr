import 'package:flutter/material.dart';
import 'package:merchant/ui/profile/notification/notification_details/notification_details_screen.dart';

import '../data/model/NotificationData.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    this.width = 30,
    this.height = 20,
    this.aspectRatio = 1.02,
    required this.notification,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final NotificationData notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(
            context,
            NotificationDetailsScreen.routeName,
            arguments: NotificationDetailsArguments(notificationData: widget.notification),
          )
        },
        child: Column(
          children: [
            Container(
              width: getProportionateScreenWidth(double.infinity),
              height: getProportionateScreenHeight(120),
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                  tag: widget.notification.id.toString(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: getProportionateScreenWidth(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            text: widget.notification.title,
                            fontWeight: widget.notification.isReaded?FontWeight.normal:FontWeight.bold,
                            fontSize: 20,
                            fontColor: KPrimaryColor,
                            align: Alignment.topLeft,),
                          SizedBox(height: getProportionateScreenHeight(5)),
                          CustomText(text: widget.notification.description, fontSize: 18),
                          SizedBox(height: getProportionateScreenHeight(10)),


                        ],
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}





