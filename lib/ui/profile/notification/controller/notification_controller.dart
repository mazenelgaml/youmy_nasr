import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/model/NotificationData.dart';
import '../../../../models/notification_list_model.dart';
import '../../../../services/memory.dart';

class NotificationController extends GetxController{
  List<NotificationData> demoNotificationDatas=[];
  List<Datum>? notifications;
  var isLoading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await  getNotifications();

  }
  Future<void> getNotifications() async {
    notifications = [];
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
        "/api/v1/dashboard/dashboardNotificationList",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
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
        NotificationListModel branchesListModel = NotificationListModel.fromJson(response.data);
        notifications = branchesListModel.data ?? [];
        demoNotificationDatas=notifications?.map((productData) {
          return NotificationData(
              id: productData.id??0,
            title:productData.trxTypeName??"",
            description: productData.description??"",
          );
        }).toList()??[];
        print(notifications); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load notifications')),
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