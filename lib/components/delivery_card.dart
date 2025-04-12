import 'package:flutter/material.dart';
import 'package:merchant/services/translation_key.dart';
import '../data/model/Delivery.dart';
import '../details/details_screen.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';
import 'package:get/get.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({
    Key? key,
    this.width = double.infinity,
    this.aspectRetio = 1.02,
    required this.delivery,
  }) : super(key: key);


  final double width, aspectRetio;
  final Delivery delivery;

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(widget.width),
      child: GestureDetector(
        // onTap: () => Navigator.pushNamed(
        //   context,
        //   DetailsScreen.routeName,
        //   // arguments: ProductDetailsArguments(Delivery: Delivery),
        // ),
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
                tag: widget.delivery.id.toString(),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      children: [
                        const Icon(Icons.delivery_dining),
                        SizedBox(
                          width: getProportionateScreenWidth(8),
                        ),
                        CustomText(
                          text:widget.delivery.title,
                          fontSize: 20,
                          fontColor: KPrimaryColor,
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomText(
                        text: "${fromText.tr}: ${widget.delivery.from.toString()} ${kmText.tr}", fontSize: 18),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomText(
                        text:"${toText.tr}: ${ widget.delivery.to.toString()}${kmText.tr}", fontSize: 18),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomText(
                        text: "${costText.tr}: ${widget.delivery.cost.toString()} ${leText.tr}", fontSize: 18),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
