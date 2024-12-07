import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:merchant/ui/home/components/branches/details/branch_details_screen.dart';
import '../data/model/Branch.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class BranchCard extends StatefulWidget {


  const BranchCard({
    Key? key,
    this.width = 30,
    this.height = 20,
    this.aspectRatio = 1.02,
    required this.branch,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final Branch branch;

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(
            context,
            BranchDetailsScreen.routeName,
            arguments: BranchDetailsArguments(branch: widget.branch),
          )
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
              // child: Hero(
              //   tag: widget.branch.id.toString(),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //     Image.asset(
              //               'assets/images/branch.png',
              //               width: 59,
              //               height: 59,
              //       alignment: Alignment.topLeft,
              //             ),
              //     ],
              //   ),
              // ),
              child: Hero(
                  tag: widget.branch.id.toString(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/images/branch.png',
                        width: 59,
                        height: 59,
                      ),
                      Column(
                        children: [
                          CustomText(
                              text: widget.branch.name,
                              fontSize: 20,
                              fontColor: KPrimaryColor),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          CustomText(text: widget.branch.address, fontSize: 18),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          RatingBar.builder(
                            itemSize: 30,
                            initialRating: widget.branch.rating,
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
                        ],
                      ),
                      Container(
                        color: getStatus(widget.branch.status),
                        width: 10,
                        height: getProportionateScreenHeight(150),
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