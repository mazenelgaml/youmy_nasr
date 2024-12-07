import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/util/extensions.dart';

import '../../../../components/custom_text_form_field.dart';
import '../../../../models/error_model.dart';
import '../../../../models/login_model.dart';
import '../../../../services/memory.dart';
import '../../../../util/Constants.dart';
import '../../../home/home_screen.dart';

class LoginController extends GetxController{

  final String TAG = "LOG IN: ";

  final formKey = GlobalKey<FormState>();

  String? email,password;

  List<String?> errors = [];

//endregion

  //region helper functions
  void addError({String? error}) {
    if (!errors.contains(error)) {

        errors.add(error!);
      update();
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {

        errors.remove(error);
      update();
    }
  }

  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      onPressed: (value) {
        password = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      hintText: 'Password',
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      suffixIcon: const Icon(Icons.visibility_off),
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      hintText: 'Email/Phone No',
      onPressed: (value) {
        email = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (value.toString().isValidEmail()) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
    );
  }

  TextEditingController emailController =TextEditingController();

  TextEditingController passwordController =TextEditingController();

  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
  }

  Future<void> signIn(BuildContext context) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://apiezz.dalia-ezzat.com/api",
        validateStatus: (status) {
          return status != null && status < 500;
          // Process any status code < 500 without throwing exceptions
        },
      ),
    );

    try {
      final response = await dio.post(
        "/tokens?Tenant=root",
        data: {
          "userNameOrEmail": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        // Successful login
        LoginModel loginModel = LoginModel.fromJson(response.data);

        if (loginModel.isHasPermission==true) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Logged in successfully."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Get.offAndToNamed(HomeScreen.routeName); // Navigate to home screen
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // No permission case
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Permission Denied"),
                content: Text("You don't have the required permissions."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle error responses (e.g., 401, 400, etc.)
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        String errorMessage = responseModel.messages?.join(", ") ?? "An error occurred";

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle unexpected exceptions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An unexpected error occurred: $e"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Get.back(); // Close the dialog
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