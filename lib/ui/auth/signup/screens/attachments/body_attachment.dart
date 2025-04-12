import 'package:flutter/material.dart';
import 'package:merchant/components/attachment_card.dart';
import 'package:merchant/ui/auth/signup/screens/attachments/attachments_screen.dart';
import '../../../../../util/size_config.dart';


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
                  return demoAttachments[index]!=null
                      ? AttachmentCard(attachment: demoAttachments[index])
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
