import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/comments_card.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../controller/products_controller.dart';
import '../show_all_branches/product_branches_filter_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(context),
    builder: (ProductsController controller) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:  CustomText(
          text: commentsTitle.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
              ),
              SizedBox(height: getProportionateScreenWidth(10)),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: controller.
                branches.map((String name) => GestureDetector(
                  child: Chip(
                    avatar: CircleAvatar(
                      child: Text(name.substring(0, 1)),
                    ),
                    label: Text(
                      name,
                    ),
                  ),
                  onTap: () async{

                    if(name=="All")
                    {
                      Navigator.pushNamed(context, ProductBranchesFilterScreen.routeName);
                    }
                    else{
                      int branchCode=  controller.branchesNames.firstWhere((branch) => branch.branchName == name).branchCode??0;
                      await controller.productsOfBranchList( branchCode);
                    }
                  },
                ))
                    .toList(),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: controller.isLoading.value?const CircularProgressIndicator():Column(
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
          ),
        ),
      ),
    );});
  }
}
