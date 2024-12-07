// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant/components/custom_button.dart';

import '../data/model/Product.dart';
import '../details/details_screen.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    Key? key,
    this.width = 250,
    this.height = 0,
    this.aspectRatio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final Product product;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  bool isClosed = false;
  final List<String> weekDays = [
    "Friday",
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "wednesday",
    "Thursday"
  ];
  final List<int> hoursList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int fromHour = 1, toHour = 1;
  String selectedDay = "Friday";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(2)),
      child: SizedBox(
        width: getProportionateScreenWidth(double.infinity),
        child: GestureDetector(
          onTap: () =>{
            // Navigator.pushNamed(
            //   context,
            //   DetailsScreen.routeName,
            //   arguments: ProductDetailsArguments(product: product),
            // );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Hero(
                  tag: widget.product.id.toString(),
                  child: Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row( children: const [ Icon(Icons.home),CustomText(text: 'Home',fontSize: 20,fontColor: KPrimaryColor,)],),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      CustomText(text: '10 Yehia zakaria st.',fontSize: 18),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      CustomText(text: 'Cairo,Egypt',fontSize: 18),
                      SizedBox(height: getProportionateScreenHeight(30)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }


}
