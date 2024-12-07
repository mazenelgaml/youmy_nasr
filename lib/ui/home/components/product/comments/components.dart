import 'package:flutter/material.dart';
import 'package:merchant/components/comments_card.dart';
import 'package:merchant/data/model/Comment.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const CustomText(
          text: 'Comments',
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
                spacing: 8,
                runSpacing: 4,
                children: [
                  "All",
                  "Maadi",
                  "Helwan",
                  "Tahrir",
                  "H-Kopa",
                  "New Cairo",
                ]
                    .map((String name) => Chip(
                  avatar: CircleAvatar(
                    child: Text(name.substring(0, 1)),
                  ),
                  label: Text(
                    name,
                  ),
                ))
                    .toList(),
              ),

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
          ),
        ),
      ),
    );
  }
}
