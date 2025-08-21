import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/auth/forget_password/forget_password_screen.dart';

import '../../../../services/memory.dart';

class ConfirmVerificationController extends GetxController {
  bool isLoading = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> forgetPassword(BuildContext context, String email, String code) async {
    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/users/isVerifyCodeCorrect",
        data: {
          "userVerifyCode": code,
          "userEmail": email
        },
      );

      if (response.statusCode == 200) {
        if(response.data==true) {
          Get.to(() => ForgetPasswordScreen(email: email,));
        }else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("the code is wrong"),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }


      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An unexpected error occurred: Api is wrong"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      print("Error: $e");
    }
  }
}
