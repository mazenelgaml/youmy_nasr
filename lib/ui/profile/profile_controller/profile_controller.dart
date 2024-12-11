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
import '../../../models/respone_bank_error.dart';


class ProfileController extends GetxController{
  TextEditingController ownerNameController =TextEditingController();
  TextEditingController bankNameController =TextEditingController();
  TextEditingController branchNameController =TextEditingController();
  TextEditingController accountNumberrController =TextEditingController();

  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
  }

  final String TAG = "Add Bank Account ";
  String? accountOwnerName, bankName, branchName, accountOwner;
  final formKey = GlobalKey<FormState>();

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

  CustomTextFormField buildAccountOwnerNameField() {
    return CustomTextFormField(
      controller:ownerNameController ,
      textInputType: TextInputType.text,
      hintText: 'Account Owner Name',
      onPressed: (value) {
        accountOwnerName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEPersonalAccountNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEPersonalAccountNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildBankNameField() {
    return CustomTextFormField(
      controller: bankNameController,
      textInputType: TextInputType.text,
      hintText: 'Bank Name',
      onPressed: (value) {
        bankName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEBankNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEBankNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildBranchNameField() {
    return CustomTextFormField(
      controller: branchNameController,
      textInputType: TextInputType.text,
      hintText: 'Branch Name',
      onPressed: (value) {
        branchName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEBranchNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEBranchNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildAccountOwnerField() {
    return CustomTextFormField(
      controller: accountNumberrController,
      textInputType: TextInputType.text,
      hintText: 'Account Number',
      onPressed: (value) {
        accountOwner = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEAccountOwnerNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEAccountOwnerNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
    );
  }

  Future<void> AddBankAccount(BuildContext context) async {
    String? token = await Get.find<CacheHelper>().getData(key: "token");
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
        "/v1/vendorbankaccounts",
          data: {
            "companyCode": 1,
            "branchCode": 1,
            "descriptionAra": "xxx",
            "descriptionEng": "rrr",
            "vendorCode": "1",
            "bankAccountName": ownerNameController.text.trim(),
            "bankCode": bankNameController.text.trim(),
            "bankBranchCode": branchNameController.text.trim(),
            "bankAccountNumber": accountNumberrController.text.trim()// Updated to a unique value
          },

          options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if (response.statusCode == 200) {
        // Successful login

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Bank Account added in successfully."),
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

      } else {
        // Handle error responses (e.g., 401, 400, etc.)
        ResponseBankErrorModel responseModel = ResponseBankErrorModel.fromJson(response.data);

        // Access the 'bankAccountNumber' list from the 'errors' object and join the errors
        String errorMessage = responseModel.errors?.bankAccountNumber?.join(", ") ?? "An error occurred";
         print(response.data);
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