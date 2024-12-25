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
import '../../../models/add_bank_account_error_model.dart';
import '../../../models/bank_accounts_list_model.dart';
import '../../../models/respone_bank_error.dart';
import '../../../services/localization_services.dart';
import '../../../services/translation_key.dart';


class ProfileController extends GetxController{
  TextEditingController ownerNameController =TextEditingController();
  TextEditingController bankNameController =TextEditingController();
  TextEditingController branchNameController =TextEditingController();
  TextEditingController accountNumberrController =TextEditingController();
  List<BankAccount> bankAccounts = [];
  // List of job names to show in the dropdown
  var isLoading = false.obs;
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await  getBankAccounts();
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
      hintText: accountOwnerNameF.tr,
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
      hintText: bankNameF.tr,
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
      hintText: accountBranchNameF.tr,
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
      hintText: accountNumber.tr,
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
    print(Get.find<CacheHelper>().getData(key: "branchCode"));
    print(Get.find<CacheHelper>().getData(key: "companyCode"));
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
          // Process any status code < 500 without throwing exceptions
        },
      ),
    );

    try {
      final response = await dio.post(
        "/api/v1/vendorbankaccounts",
          data: {
            "companyCode":Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
            "descriptionAra": "xxx",
            "descriptionEng": "rrr",
            "vendorCode": "111",
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
        AddBankAccountErrorModel responseModel = AddBankAccountErrorModel.fromJson(response.data);

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
  Future<void> getBankAccounts() async {
    bankAccounts = [];
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl:Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    isLoading.value = true; // Start loading

    try {
      final response = await dio.post(
        "/api/v1/vendorbankaccounts/searchData",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          },
        },
        options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if (response.statusCode == 200) {
        // Successful response
        BankAccountsListModel branchesListModel = BankAccountsListModel.fromJson(response.data);
        bankAccounts = branchesListModel.data ?? [];
        print(bankAccounts); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load bank accounts')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading.value = false; // Stop loading
    }

    update(); // Update UI
  }


}