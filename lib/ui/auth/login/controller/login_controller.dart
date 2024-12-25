import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/models/company_list_model.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/util/extensions.dart';

import '../../../../components/custom_text_form_field.dart';
import '../../../../models/branches_login_model.dart';
import '../../../../models/error_model.dart';
import '../../../../models/login_model.dart';
import '../../../../services/localization_services.dart';
import '../../../../services/memory.dart';
import '../../../../util/Constants.dart';
import '../../../home/home_screen.dart';
import '../login_screen.dart';

class LoginController extends GetxController {
  final String TAG = "LOG IN: ";
bool isLoading=true;
  final formKey = GlobalKey<FormState>();
  List<Company>? companyList;
  String? email, password,api,reportApi;
  List<String>? companyLogin;
  List<String?> errors = [];

  List<String>? branchesLogin;
  List<BranchesLogin>? branchesList;
  bool showSettingsFields = false;

  void toggleSettingsFields() {

    showSettingsFields = !showSettingsFields;
    update(); // Trigger UI update
  }

  // Helper functions for managing errors
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
      hintText: signInTextPass.tr,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      suffixIcon: const Icon(Icons.visibility_off),
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      hintText: signInTextEmail.tr,
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
  CustomTextFormField buildApiField() {
    return CustomTextFormField(
      controller: apiController,
      textInputType: TextInputType.text,
      hintText: Api.tr,
      onPressed: (value) {
        api = value;
      },
      onChange: (value) {
        // Handle API changes here
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: "API cannot be empty");
          return "API is required";
        }
        return null;
      },
    );
  }

  CustomTextFormField buildReportApiField() {
    return CustomTextFormField(
      controller: reportApiController,
      textInputType: TextInputType.text,
      hintText: ReportApi.tr,
      onPressed: (value) {
        reportApi = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Report API cannot be empty");
        }
        // Additional validation or logic here
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: "Report API cannot be empty");
          return "Report API is required";
        }
        return null;
      },
    );
  }

  TextEditingController apiController = TextEditingController();
  TextEditingController reportApiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  // Avoid recursion by checking if the value has changed, considering null safety
  String _merchantName="";
  String get merchantName => _merchantName;
  set merchantName(String? value) {
    // Explicitly check for null before comparing
    if (_merchantName != value) {
      _merchantName = value ?? '';
      update(); // Trigger UI update
    }
  }
  // Getter and setter for other fields
  String _selectedBranch = '';
  String get selectedBranch => _selectedBranch;
  set selectedBranch(String? value) {
    if (_selectedBranch != value) {
      _selectedBranch = value ?? '';
      update(); // Trigger UI update
    }
  }
  String _year = '';
  String get year => _year;
  set year(String? value) {
    if (_year != value) {
      _year = value ?? '';
      update(); // Trigger UI update
    }
  }

  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await getCompany();
    await getBranches();
  }
  Future<void> getCompany() async {
    isLoading=true;
    print("ho");
    final Dio dio = Dio(BaseOptions(
      baseUrl:baseUrl,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/v1/companies/loginsearch",
        data: {
          "search":{
            "langId":1
          }
        },
      );

      if (response.statusCode == 200) {
        CompanyListModel companyListModel = CompanyListModel.fromJson(response.data);
        companyList=companyListModel.data;
        companyLogin = companyList?.map((company) => Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english ?company.companyNameEng ?? '':company.companyNameAra??"").toList() ?? [];
        print(companyLogin);
        print(companyList);
        update();
        isLoading=false;
        update();
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> signIn(BuildContext context) async {
    int? companyCode = companyList?.firstWhere((company) => company.companyNameAra==merchantName ||company.companyNameEng == merchantName).companyCode;
    final Dio dio = Dio(BaseOptions(
      baseUrl:apiController.text.trim(),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/tokens?Tenant=root",
        data: {
          "userNameOrEmail": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "companyCode": companyCode,
          "branchCode":1,
          "year": yearController.text==""?2025:yearController.text
        },
      );

      if (response.statusCode == 200) {
        LoginModel loginModel = LoginModel.fromJson(response.data);
        await Get.find<CacheHelper>().saveData(key: "token", value: "${loginModel.token}");
        await Get.find<CacheHelper>().saveData(key: "Api", value:apiController.text.trim() );
        await Get.find<CacheHelper>().saveData(key: "companyCode", value: companyCode);
        await Get.find<CacheHelper>().saveData(key: "companyName", value: merchantName);
        await Get.find<CacheHelper>().saveData(key: "year", value: yearController.text.trim());

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
                      Get.offAllNamed(LoginScreen.routeName);
                    },
                  ),
                ],
              );
            },
          );
        } else {
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
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
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
  Future<void> signInBranches(BuildContext context) async {
    int? branchCode = branchesList?.firstWhere((branch) => branch.branchNameAra==selectedBranch ||branch.branchNameEng == selectedBranch).branchCode;
    final Dio dio = Dio(BaseOptions(
      baseUrl:Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/tokens?Tenant=root",
        data: {
          "userNameOrEmail": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
          "branchCode":branchCode,
          "year":  Get.find<CacheHelper>().getData(key: "year")
        },
      );

      if (response.statusCode == 200) {
        LoginModel loginModel = LoginModel.fromJson(response.data);
        await Get.find<CacheHelper>().saveData(key: "token", value: "${loginModel.token}");

        await Get.find<CacheHelper>().saveData(key: "branchCode", value: branchCode);
        if (loginModel.isHasPermission==true) {
          Get.offAllNamed(HomeScreen.routeName);
        } else {
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
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
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
  Future<void> getBranches() async {
    isLoading=true;
    print("ho");
    final Dio dio = Dio(BaseOptions(
      baseUrl:Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/v1/branches/loginsearch",
        data: {
          "search": {
            "companyCode":Get.find<CacheHelper>().getData(key: "companyCode"),
          }
        },
      );

      if (response.statusCode == 200) {
        BranchesLoginModel branchesLoginModel = BranchesLoginModel.fromJson(response.data);
        branchesList=branchesLoginModel.data;
        branchesLogin = branchesList?.map((branch) => Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english ?branch.branchNameEng ?? '':branch.branchNameAra??"").toList() ?? [];
        update();
       branchesLogin=branchesLogin?.toSet().toList();
        print(branchesList);
        print(branchesLogin);
        isLoading=false;
        update();
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}
