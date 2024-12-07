import 'package:flutter/material.dart';
import 'package:merchant/util/Constants.dart';



class CardWidget extends StatelessWidget {

  const CardWidget( { Key? key,this.cardChild}) : super(key: key);
  final Widget? cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: KOpacityPrimaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
