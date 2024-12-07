import 'package:flutter/material.dart';
import '../data/model/Delivery.dart';
import '../details/details_screen.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

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
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          // arguments: ProductDetailsArguments(Delivery: Delivery),
        ),
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
                        text: "From : ${widget.delivery.from.toString()} KM", fontSize: 18),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomText(
                        text:"To: ${ widget.delivery.to.toString()} KM", fontSize: 18),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomText(
                        text: "Cost: ${widget.delivery.cost.toString()} LE", fontSize: 18),
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
