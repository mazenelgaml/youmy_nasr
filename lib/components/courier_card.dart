import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/components/action_button.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/new_courier_screen.dart';
import '../data/model/courier.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class CourierCard extends StatefulWidget {
  const CourierCard({
    Key? key,
    this.width = 30,
    this.height = 20,
    this.aspectRatio = 1.02,
    required this.courier,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final Courier courier;

  @override
  State<CourierCard> createState() => _CourierCardState();
}

class _CourierCardState extends State<CourierCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(context, NewCourierScreen.routeName)
        },
        child: Column(
          children: [
            Container(
              width: getProportionateScreenWidth(double.infinity),
              height: getProportionateScreenHeight(150),
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                  tag: widget.courier.id.toString(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/profile.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: getProportionateScreenWidth(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            text: widget.courier.name,
                            fontSize: 23,
                            align: Alignment.topLeft,),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          CustomText(text: widget.courier.mobile, fontSize: 18),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: const Icon(
                                  Icons.delete,
                                  color: KInActiveColor,
                                  size: 30,
                                ),
                                onTap: () {
                                  _displayDialog(context,'Alert','Do you want to delete  ${widget.courier.name} courier?!');
                                },
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.edit,
                                  color: KActiveColor,
                                  size: 30,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, NewCourierScreen.routeName);
                                },
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),

                              InkWell(
                                child: Icon(
                                  widget.courier.isActive
                                      ? Icons.remove_red_eye
                                      : Icons
                                      .airline_seat_individual_suite_rounded,
                                  color: KPrimaryColor,
                                  size: 30,
                                ),
                                onTap: () {
                                  var activeStatus=widget.courier.isActive?'InActive':'Active';
                                  _displayDialog(context,'Alert','Do you want to $activeStatus ${widget.courier.name} courier?!');
                                },
                              ),
                            ],
                          ),
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


_displayDialog(BuildContext context, String title, String message) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  color: KPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(message),
            actions: [
              MaterialButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.pop(context)),
              MaterialButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context))
            ]);
      });
}



