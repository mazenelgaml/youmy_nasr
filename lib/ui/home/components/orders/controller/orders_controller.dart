import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/model/Branch.dart';
import '../../../../../data/model/Order.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../models/orders_list_model.dart' as model;
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';

class OrdersController extends GetxController {
  List<model.Order> ordersNames = [];
  List<Order> orders = []; // List of orders to show
  var isLoading = false.obs; // Track loading state

  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await getOrdersLists(); // Fetch order data when the controller initializes
  }

  Future<void> getOrdersLists() async {
    isLoading.value = true; // Start loading
    orders.clear();
    ordersNames.clear();

    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    try {
      final response = await dio.post(
        "/api/v1/salesorderstatuses/search",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "LangId": Get.find<CacheHelper>().activeLocale == SupportedLocales.english ? 2 : 1,
          },
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        model.OrdersListModel ordersListModel = model.OrdersListModel.fromJson(response.data);
        ordersNames = ordersListModel.data ?? [];
        orders = ordersNames.map((orderData) {
          return Order(
            clientName: orderData.creatorUserName??"null",
            branchId:orderData.branchCode??0,
            id: orderData.id ?? 0,
            status: Get.find<CacheHelper>().activeLocale == SupportedLocales.english
                ? _mapEnglishStatus(orderData.orderStatusNameEng)
                : _mapArabicStatus(orderData.orderStatusNameAra),
            orderNo: "${orderData.id}",
            date: orderData.creationTime.toString(),
            statusDescription: Get.find<CacheHelper>().activeLocale == SupportedLocales.english
                ? orderData.orderStatusNameEng ?? ""
                : orderData.orderStatusNameAra ?? "",
            productList: [],
          );
        }).toList();
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load orders')),
        );
      }
    } catch (e) {
      // Handle errors during API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading.value = false; // Stop loading
      update(); // Update UI
    }
  }

  // Map English order statuses
  OrderState _mapEnglishStatus(String? status) {
    switch (status) {
      case "In Progress":
      case "New":
        return OrderState.InProgress;
      case "Delivery Done":
      case "Arrival Done":
      case "Receive Done":
        return OrderState.DELIEVERED;
      case "In Way":
        return OrderState.InWay;
      default:
        return OrderState.CANCELLED;
    }
  }

  // Map Arabic order statuses
  OrderState _mapArabicStatus(String? status) {
    switch (status) {
      case "قيد التنفيذ":
      case "جديد":
        return OrderState.InProgress;
      case "في الطريق":
        return OrderState.InWay;
      case "تم التوصيل":
      case "تم الوصول":
      case "تم الاستلام":
        return OrderState.DELIEVERED;
      default:
        return OrderState.CANCELLED;
    }
  }
}
