import 'package:flutter/material.dart';
import 'package:merchant/components/attachment_card.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Attachment.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../components/address_card.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../components/form_error.dart';
import '../../../../../components/working_hour_card.dart';
import '../../../../../data/model/Product.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../../../home/home_screen.dart';

class SignUpAttachment extends StatefulWidget {
  const SignUpAttachment({Key? key}) : super(key: key);

  @override
  _SignUpAttachmentState createState() => _SignUpAttachmentState();
}

class _SignUpAttachmentState extends State<SignUpAttachment> {



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
                demoAttachments.length,
                    (index) {
                  if (demoProducts[index].isActive) {
                    return AttachmentCard(attachment: demoAttachments[index]);
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
