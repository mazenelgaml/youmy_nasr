import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../data/model/Branch.dart';
import '../../../../../util/size_config.dart';

class BranchFilterWidget extends StatefulWidget {
  const BranchFilterWidget({Key? key,
    this.width = 30,
    this.height = 20,
    this.aspectRatio = 1.02,
    required this.branch,
    required this.onPress})
      : super(key: key);

  final Function onPress;
  final double width, height, aspectRatio;
  final Branch branch;

  @override
  State<BranchFilterWidget> createState() => _BranchFilterWidgetState();
}

class _BranchFilterWidgetState extends State<BranchFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress(),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: CustomText(text:widget.branch.name,),
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: KOpacityPrimaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
