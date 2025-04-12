import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/Constants.dart';
import '../auth/login/controller/login_controller.dart';

class PrivacyScreen extends StatelessWidget {
  final String text;

  const PrivacyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (LoginController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: KPrimaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              "About Us",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            color: Colors.grey[100],
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
