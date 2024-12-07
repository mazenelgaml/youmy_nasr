import 'package:flutter/material.dart';
import 'package:merchant/ui/auth/confirm_verification/components/body.dart';

class ConfirmVerificationScreen extends StatelessWidget {
  const ConfirmVerificationScreen({Key? key}) : super(key: key);
  static var routeName = "/confirm_verification";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: const Body(),
    );
  }
}
