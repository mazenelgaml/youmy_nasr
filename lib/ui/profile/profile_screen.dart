import 'package:flutter/material.dart';
import 'package:merchant/ui/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  static var routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
