
import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:merchant/data/model/Branch.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import '../../../new_branch/new_branch_screen.dart';

bool _switchValue = true;

class BranchGeneralDetailsTab extends StatefulWidget {
  const BranchGeneralDetailsTab({Key? key, required this.branch})
      : super(key: key);

  final Branch branch;

  @override
  State<BranchGeneralDetailsTab> createState() =>
      _BranchGeneralDetailsTabState();
}

class _BranchGeneralDetailsTabState extends State<BranchGeneralDetailsTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            const CustomText(
              text: 'Branch Details',
              align: Alignment.center,
              fontColor: KPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: getProportionateScreenWidth(300),
              height: getProportionateScreenHeight(200),
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: widget.branch.id??0,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            CustomText(
              text: widget.branch.name??"",
              fontSize: 25,
              fontColor: KPrimaryColor,
              align: Alignment.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: getStatusDescription(widget.branch.status),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontColor: getStatus(widget.branch.status),
                ),
                Switch(
                  value: isOpened(widget.branch.status),
                  activeColor: getStatus(widget.branch.status),
                  inactiveThumbColor: getStatus(widget.branch.status),
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            CustomText(
              text: widget.branch.address??"",
              align: Alignment.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RatingBar.builder(
              itemSize: 30,
              initialRating: widget.branch.rating??0,
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
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            CustomText(text:'Working Hours',fontColor: KPrimaryColor,
            fontWeight: FontWeight.bold,),
            CustomText(text:widget.branch.workingHours??""),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            CustomText(text:'Payment Methods', fontWeight: FontWeight.bold,fontColor: KPrimaryColor,),
            CustomText(text:widget.branch.paymentMethods??""),
            SizedBox(
              height: getProportionateScreenHeight(100),
            ),
            CustomButton(
              text: 'Edit',
              press: () {
                Navigator.pushNamed(context, NewBranchScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
