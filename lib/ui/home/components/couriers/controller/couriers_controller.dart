import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../data/model/courier.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../models/couriers_model.dart';
import '../../../../../models/sign_up_error_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../util/Constants.dart';
class CouriersController extends GetxController {
  List<CouriersDetails> couriersNames = [];
  List<Courier> couriersD = [];
  var isLoading = false.obs;
  List<Branches> branchesNames = [];
  List<String> branches = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await CouriersLists();
    await BranchesLists();
  }
  Future<void> BranchesLists() async {
    branches = [];
    branchesNames = [];
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
        "/api/v1/branches/searchData",
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
        BranchesListModel branchesListModel = BranchesListModel.fromJson(response.data);
        branchesNames = branchesListModel.data ?? [];
        branches = branchesNames?.map((branch) => branch.branchName ?? '').toList() ?? [];

        print(branches); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load jobs')),
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
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: KPrimaryColor,
        fontSize: 16.0);
  }
  Future<void> CouriersLists() async {
    couriersNames=[];
    couriersD=[];
    isLoading.value=true;
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    isLoading.value = true; // Start loading

    try {
      final response = await dio.post(
        "/api/v1/salesMans/searchData",
        data: {
          "search": {"companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": Get.find<CacheHelper>().getData(key: "branch"),
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,},
          "request": 2
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        CouriesListModel couriesListModel =
            CouriesListModel.fromJson(response.data);
        couriersNames = couriesListModel.data ?? [];
        couriersD = couriersNames.map((courierData) {
          return Courier(
              id: courierData.id,
              name: Get.find<CacheHelper>()
                  .activeLocale == SupportedLocales.english?courierData.salesManNameEng:courierData.salesManNameAra,
              mobile: courierData.mobile1,
              isActive: true);
        }).toList();
        print(couriersD);
        print(couriersNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load jobs')),
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
  Future<void> CouriersListsOfBranch(int branchCode) async {
    couriersNames=[];
    couriersD=[];
    isLoading.value=true;
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    isLoading.value = true; // Start loading

    try {
      final response = await dio.post(
        "/api/v1/salesMans/searchData",
        data: {
          "search": {"companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branchCode,
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,},
          "request": 2
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        CouriesListModel couriesListModel =
        CouriesListModel.fromJson(response.data);
        couriersNames = couriesListModel.data ?? [];
        couriersD = couriersNames.map((courierData) {
          return Courier(
              id: courierData.id,
              name: Get.find<CacheHelper>()
                  .activeLocale == SupportedLocales.english?courierData.salesManNameEng:courierData.salesManNameAra,
              mobile: courierData.mobile1,
              isActive: true);
        }).toList();
        print(couriersD);
        print(couriersNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load jobs')),
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
  Future<void> CouriersDelete(int empId) async {
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    isLoading.value = true; // Start loading

    try {
      final response = await dio.delete(
        "/api/v1/salesMans/$empId",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
      int id=response.data;
      print(id);// Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to delete couriers')),
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
  Future<void> toggleCourierStatus(int id, bool isCurrentlyActive) async {
    String? token = await Get.find<CacheHelper>().getData(key: "token");

    try {
      final dio = Dio(BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) => status != null && status < 500,
      ));

      final response = await dio.post(
        "/api/v1/vendors/setVendorOnOff",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "vendorCode": "$id",
            "IsNotActive": isCurrentlyActive, // عكسي عشان نغيّر الحالة
          }
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        // ✅ نحدث الـ status محلياً
        int index = couriersD.indexWhere((c) => c.id == id);
        if (index != -1) {
          couriersD[index] = Courier(
            id: couriersD[index].id,
            name: couriersD[index].name,
            mobile: couriersD[index].mobile,
            isActive: !couriersD[index].isActive, // Flip the status locally
          );
        }

        update(); // عشان UI يتحدث
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text("Courier status updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text("Failed to update status")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("Error while updating status: $e")),
      );
    }
  }


}
