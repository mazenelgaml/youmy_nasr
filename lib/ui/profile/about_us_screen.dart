import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../util/Constants.dart'; // Assuming this has KPrimaryColor or your color palette

import '../auth/login/controller/login_controller.dart';

class AboutUsScreen extends StatelessWidget {
  final String htmlData;

  const AboutUsScreen({super.key, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (LoginController controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: KPrimaryColor,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
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
                padding: EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Html(
                      data: htmlData,
                      style: {
                        "body": Style(
                          fontSize: FontSize(18.0),
                          lineHeight: LineHeight(1.6),
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                        "h1": Style(color: KPrimaryColor),
                        "h2": Style(color: KPrimaryColor),
                        "a": Style(color: Colors.blueAccent),
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
