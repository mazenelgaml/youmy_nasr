import 'package:flutter/material.dart';
import 'package:merchant/data/model/Comment.dart';

import '../../../../../../../../components/comments_card.dart';
import '../../../../../../../../util/size_config.dart';

class BranchCommentsData extends StatelessWidget {
  const BranchCommentsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),

        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoComments.length,
                    (index) {
                  return CommentCard(comment: demoComments[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
