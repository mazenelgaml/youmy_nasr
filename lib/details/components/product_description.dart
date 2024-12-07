import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/util/CustomAlertDialog.dart';

import '../../data/model/Product.dart';
import '../../util/Constants.dart';
import '../../util/size_config.dart';

var isActive = false;

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.product.price.toString(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.product.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(2),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RatingBar.builder(
                  itemSize: 20,
                  initialRating: widget.product.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),

            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color:
                  widget.product.isActive ? KActiveColor : KInActiveColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                _displayDialog(context, 'Change Status',
                    'Do you want to change product to InActive!!');
              },
              child: Stack(
                children: [
                   CustomText(
                    text: widget.product.isActive
                        ?'ON'
                        :"OFF",
                     fontColor: Colors.white,
                  ),
                  SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    color: widget.product.isActive
                        ? KActiveColor
                        : KInActiveColor,
                    height: getProportionateScreenWidth(16),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {
              _showToast('See More is clicked');
            },
            child: Row(
              children: const [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: KPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: KPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: KPrimaryColor,
        fontSize: 16.0);
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


}
