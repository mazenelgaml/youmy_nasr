import 'package:flutter/material.dart';
import 'package:merchant/data/model/Comment.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    this.width = 30,
    this.height = 20,
    this.aspectRatio = 1.02,
    required this.comment,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final Comment comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: GestureDetector(
        onTap: () => {
          // Navigator.pushNamed(
          //   context,
          //   DetailsScreen.routeName,
          //   arguments: commentDetailsArguments(comment: comment),
          // );
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                  tag: widget.comment.id.toString(),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/profile.png',
                        width: 59,
                        height: 59,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Column(
                        children: [
                          CustomText(
                            text: widget.comment.username,
                            fontSize: 25,
                            fontColor: KPrimaryColor,
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          CustomText(text: widget.comment.text, fontSize: 18),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          CustomText(text: widget.comment.date, fontSize:16),
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
