
import 'package:merchant/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:merchant/ui/profile/components/security/components/body.dart';

import '../../../../util/Constants.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);
  static var routeName="security_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
          text: 'Security & Login',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: const Body(),
    );
  }
}
