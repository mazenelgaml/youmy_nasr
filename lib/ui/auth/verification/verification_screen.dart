import 'package:flutter/material.dart';
import '../verification/components/body.dart';

class VerificationScreen extends StatelessWidget {
  static var routeName = "/verification";

  const VerificationScreen({Key? key}) : super(key: key);

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
