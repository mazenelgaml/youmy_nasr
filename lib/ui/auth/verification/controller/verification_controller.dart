import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/auth/confirm_verification/confirm_verification_screen.dart';

import '../../../../components/custom_text_form_field.dart';
import '../../../../services/memory.dart';
import '../../../../services/translation_key.dart';

class VerificationController extends GetxController{
  bool isLoading=true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      hintText: signInTextEmail.tr,
      onPressed: (value) {
        emailController.text = value;
      },
      onChange: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kEmailNullError); // Remove empty email error
        // }
        // if (value.isValidEmail()) {
        //   removeError(error: kInvalidEmailError); // Remove invalid email error
        // }
      },
      onValidate: (value) {
        // if (value == null || value.isEmpty) {
        //   addError(error: kEmailNullError); // Add error if email is empty
        //   return "Email cannot be empty";
        // }
        // if (!value.isValidEmail()) {
        //   addError(error: kInvalidEmailError); // Add error if email is invalid
        //   return "Enter a valid email address";
        // }
        return null;
      },
    );
  }
  TextEditingController emailController = TextEditingController();
  Future<void> forgetPassword(BuildContext context) async {
    final Dio dio = Dio(BaseOptions(
      baseUrl:Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/v1/emailSettings/sendEmailForForgetPassword",
        data: {
          "search": {
            "toMail":emailController.text.trim()
          }
        },
      );

      if (response.statusCode == 200) {
        print("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
        print(response.data);
        Get.to(()=>ConfirmVerificationScreen(email: emailController.text.trim(),));

    } }catch (e) {
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