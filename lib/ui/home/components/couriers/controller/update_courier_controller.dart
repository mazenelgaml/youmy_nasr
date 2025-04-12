import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/ui/home/components/couriers/controller/couriers_controller.dart';
import 'package:merchant/ui/home/components/couriers/courier_screen.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../models/sign_up_error_model.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';

class UpdateCourierController extends GetxController{
  BuildContext context;
  UpdateCourierController(this.context);
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController mobileNoController=TextEditingController();
  TextEditingController salesManNameEngController=TextEditingController();
  TextEditingController salesManNameAraController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  var pickedImage = File("");
  String? email, name, mobile, job, password, confirmPassword,address;
  bool remember = false;
  final List<String?> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {

        errors.add(error);
     update();
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {

        errors.remove(error);
    update();
    }
  }
  CustomTextFormField buildAddressField() {
    return CustomTextFormField(
      controller: addressController,
      hintText: merchantAdrress.tr,
      suffixIcon: const Icon(Icons.location_on),
      onPressed: (value) => address = value,
      onChange: (value) {
        if (value.isNotEmpty) removeError(error: kAddressNullError);
        address = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
    );
  }



  bool _isPasswordVisible = false; // Add this as a state variable

  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      obscureText: !_isPasswordVisible, // Toggle visibility
      hintText: signUpPassword.tr,
      suffixList: GestureDetector(
        onTap: () {
            _isPasswordVisible = !_isPasswordVisible;
          update();
        },
        child: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
      ),
      onPressed: (value) => password = value,
      onChange: (value) {
        if (value.isNotEmpty) removeError(error: kPassNullError);
        if (value.length >= 8) removeError(error: kShortPassError);
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


  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      textInputType:TextInputType.emailAddress,
      controller: emailController,
      hintText: signInTextEmail.tr,
      suffixIcon: const Icon(Icons.email),
      onPressed: (value) => email = value,
      onChange: (value) {
        if (value.isNotEmpty) removeError(error: kEmailNullError);
        if (emailValidatorRegExp.hasMatch(value)) removeError(error: kInvalidEmailError);
        email = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
    );
  }

  CustomTextFormField buildNameARField() {
    return CustomTextFormField(
      controller: salesManNameAraController,
      hintText: newCourierNameArabic.tr,
      onPressed: (value) => name = value,
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) removeError(error: kNameNullError);
      },
    );
  }

  CustomTextFormField buildNameENField() {
    return CustomTextFormField(
      controller: salesManNameEngController,
      hintText: newCourierNameEnglish.tr,
      onPressed: (value) => name = value,
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) removeError(error: kNameNullError);
      },
    );
  }

  CustomTextFormField buildMobileField() {
    return CustomTextFormField(
      textInputType:TextInputType.phone,
      controller: mobileNoController,
      hintText: mobileNO.tr,
      onPressed: (value) => mobile = value,
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) removeError(error: kNameNullError);
      },
    );
  }

  void pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(chooseImageSource.tr),
        actions: [
          TextButton(
            child: Text(camera.tr),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          TextButton(
            child: Text(gallery.tr),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (source != null) {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {

          pickedImage = File(pickedFile.path);
      update();
      }
    }
  }

  ImageProvider getImage(File file) {
    return file.path.isEmpty
        ? const AssetImage("assets/images/profile.png")
        : FileImage(file) as ImageProvider;
  }
  Future<void> updateCourier(BuildContext context,int courierId) async {

    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    ));

    try {
      final response = await dio.put(
        "/api/v1/salesMans/$courierId",
        data: {
          "id":courierId,
          "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
          "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
          "salesManCode": "${courierId}",
          "salesManNameAra": salesManNameAraController.text.trim(),
          "salesManNameEng": salesManNameEngController.text.trim(),
          "email":emailController.text.trim(),
          "password":passwordController.text.trim(),
          "mobileNo":mobileNoController.text.trim(),
          "address":addressController.text.trim()
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("ttttttttttttttttttttttttttt");
        int?code=response.data;
        print(code);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("success"),
              content: Text("Courier updated successfully"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Get.delete<CouriersController>();
                    Get.to(()=>CourierScreen());
                  },
                ),
              ],
            );
          },
        );



      } else {
        // Log the entire response for debugging
        print("Response Data: ${response.data}");

        // Handle error model
        SignUpErrorModel responseModel = SignUpErrorModel.fromJson(response.data);

        // Use messages if available
        String errorMessage = "An error occurred, but no detailed message was provided.";

        // Check if messages are available and not empty
        if (responseModel.messages?.isNotEmpty == true) {
          errorMessage = responseModel.messages!.join(", ");
        }
        // Check if vendorCode errors are available and not empty
        else if (responseModel.errors?.vendorCode?.isNotEmpty == true) {
          errorMessage = responseModel.errors!.vendorCode!.join(", ");
        }

        print("Messages: ${responseModel.messages}");
        print("VendorCode Errors: ${responseModel.errors?.vendorCode}");

        // Show error dialog
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
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Catch and log unexpected errors
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
                  Get.back();
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