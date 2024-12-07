import 'package:flutter/material.dart';
import 'package:merchant/data/model/Attachment.dart';
import '../details/details_screen.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class AttachmentCard extends StatefulWidget {
  const AttachmentCard({
    Key? key,
    this.width = double.infinity,
    this.aspectRetio = 1.02,
    required this.attachment,
  }) : super(key: key);

  final double width, aspectRetio;
  final Attachment attachment;

  @override
  State<AttachmentCard> createState() => _AttachmentCardState();
}

class _AttachmentCardState extends State<AttachmentCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(widget.width),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          // arguments: ProductDetailsArguments(attachment: attachment),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                tag: widget.attachment.id.toString(),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      children: [
                        const Icon(Icons.list_alt_outlined),
                        SizedBox(
                          width: getProportionateScreenWidth(8),
                        ),
                        CustomText(
                          text: widget.attachment.title,
                          fontSize: 20,
                          fontColor: KPrimaryColor,
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomText(
                        text: widget.attachment.description, fontSize: 18),
                    SizedBox(height: getProportionateScreenHeight(30)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
