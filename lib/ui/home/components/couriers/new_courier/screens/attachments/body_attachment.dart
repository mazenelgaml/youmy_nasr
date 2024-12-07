import 'package:flutter/material.dart';
import 'package:merchant/components/attachment_card.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Attachment.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../../../data/model/Product.dart';
import '../../../../../../../util/size_config.dart';

class CourierAttachmentBody extends StatefulWidget {
  const CourierAttachmentBody({Key? key}) : super(key: key);

  @override
  _CourierAttachmentBodyState createState() => _CourierAttachmentBodyState();
}

class _CourierAttachmentBodyState extends State<CourierAttachmentBody> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoCourierAttachments.length,
                    (index) {
                  if (demoProducts[index].isActive) {
                    return AttachmentCard(attachment: demoCourierAttachments[index]);
                  }
                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),

            ],
          ),
        ),



      ],
    );

  }

}
