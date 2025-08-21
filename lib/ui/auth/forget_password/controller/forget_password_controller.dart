import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../services/memory.dart';
import '../../../../services/translation_key.dart';
import '../../../../util/Constants.dart';

class ForgetPasswordController extends GetxController{
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();

  String? password;

  String? confirmPassword;

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

  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
        obscureText: true,
        textInputType: TextInputType.visiblePassword,
        hintText:signUpConfirmPassword.tr,
        textInputAction: TextInputAction.done,
        suffixIcon: const Icon(Icons.visibility_off),
        onPressed: (newValue) => confirmPassword = newValue,
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kConfirmPassNullError);
          } else if (value.isNotEmpty && password == confirmPassword) {
            removeError(error: kMatchPassError);
          }
          confirmPassword = value;
        },
        onValidate: (value) {
          if (value!.isEmpty) {
            addError(error: kConfirmPassNullError);
            return "";
          } else if ((password != value)) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        });
  }

  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      obscureText: true,
      hintText: signUpPassword.tr,
      textInputType: TextInputType.visiblePassword,
      suffixIcon: const Icon(Icons.visibility_off),
      onPressed: (newValue) => password = newValue,
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
    );
  }
TextEditingController passwordController =TextEditingController();
  Future<void> resetPassword(BuildContext context, String email) async {
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status < 500;
      },

    ));

    try {
      final response = await dio.post(
        "/api/users/forgetPasswordDoReset",
        data: {
          "email":email,
          "password":passwordController.text.trim()
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        if(response.data==true) {
          Get.to(() => LoginScreen());
        }else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Something went wrong!"),
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