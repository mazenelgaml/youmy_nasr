
import 'package:merchant/ui/auth/forget_password/components/body.dart';
import 'package:flutter/material.dart';
import '../login/login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final String email;
  const ForgetPasswordScreen({super.key, required this.email});
  static var routeName="forget_password";
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
      body:  Body(email: email,),
    );
  }
}
