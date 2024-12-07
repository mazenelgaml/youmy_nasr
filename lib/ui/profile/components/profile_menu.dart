import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/util/Constants.dart';



class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextButton(
        onPressed: press,
        child: Row(
          children: [
            Icon(icon,size: 22,),
            SizedBox(width: 20),
            Expanded(child: CustomText(text: text,fontColor: Colors.grey,fontSize: 19,)),
          ],
        ),
      ),
    );
  }
}
