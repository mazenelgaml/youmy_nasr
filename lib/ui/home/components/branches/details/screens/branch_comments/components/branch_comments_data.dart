import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/data/model/Comment.dart';

import '../../../../../../../../components/comments_card.dart';
import '../../../../../../../../util/size_config.dart';
import '../../../../controller/branches_controller.dart';

class BranchCommentsData extends StatelessWidget {
  const BranchCommentsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return Column(
      children: [
        Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),

        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
              ? Center(child: CircularProgressIndicator()) :Column(
            children: [
              ...List.generate(
                controller.commentsD.length,
                    (index) {
                  return CommentCard(comment: controller.commentsD[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );});
  }
}
