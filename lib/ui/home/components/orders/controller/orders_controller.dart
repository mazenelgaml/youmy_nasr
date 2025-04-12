import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/data/model/Product.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../data/model/Branch.dart';
import '../../../../../data/model/Order.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../models/orders_list_model.dart' as model;
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../search/components/body.dart';

class OrdersController extends GetxController {
  List<model.Order> ordersNames = [];
  List<Order> orders = [];
  List<Order> ordersD = [];// List of orders to show
  var isLoading = false.obs; // Track loading state
  List<String> branchess = [];
  final RxList<Order> filteredOrders = <Order>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await getOrdersLists();
    await BranchesLists();
    ordersD=orders;
    filteredOrders .value= ordersD;// Fetch order data when the controller initializes
  }
  List<Branches> branchesNames = [];
  List<Branch> branches = [];
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
        branches = branchesNames.map((branchData) {
          return Branch(
              id: branchData.branchCode,
              name: branchData.branchName,
              address: "${branchData.branchName}, Egypt",
              isOpen: true,
              rating: branchData.branchRate
          );
        }).toList() ?? [];
        branchess = branchesNames?.map((branch) => branch.branchName ?? '').toList() ?? [];
        print(branchesNames); // Save full job data if needed
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
            clientNo: orderData.creatorUserId??"no is not provided",
            clientName: orderData.creatorUserName??"name is not provided",
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
            productList: demoProducts,
          );
        }).toList();
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load orders')),
        );
      }
    } catch (e) {
      print(e);
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

  final List<String> searchOptions = [
    selectSearchType.tr,
    orderNo.tr,
    clientNo.tr,
    clientName.tr,
  ];

  var selectedOption=selectSearchType.tr;
  SearchOption searchoption=SearchOption.ORDER_NO;
  void runFilter(String enteredKeyword, SearchOption searchOption) {
    // Keep a separate variable for filtered results
    List<Order> filteredResults = [];
    isLoading.value = true;

    // If the search keyword is empty, show the original list
    if (enteredKeyword.isEmpty) {
      filteredResults = ordersD; // Show all data if no search keyword
    } else {
      // Apply filtering based on the selected search option
      switch (searchOption) {
        case SearchOption.ORDER_NO:
          filteredResults = ordersD
              .where((order) => order.orderNo
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
              .toList();
          break;
        case SearchOption.CLIENT_NO:
          filteredResults = ordersD
              .where((order) => order.clientNo
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
              .toList();
          break;
        case SearchOption.CLIENT_NAME:
          filteredResults = ordersD
              .where((order) => order.clientName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
              .toList();
          break;
      }
    }

    // Assign the filtered results to a separate observable list for the UI
    filteredOrders.value = filteredResults;

    // Indicate loading is done
    isLoading.value = false;

    // Notify UI to refresh
    update();
  }

  DropdownButton<String> buildSearchField() {
  return DropdownButton(
  hint:  CustomText(
  text: selectSearchType.tr,
  ),
  iconSize: 40,
  isExpanded: true,
  value: selectedOption,
  items: searchOptions.map((String option) {
  return DropdownMenuItem<String>(
  child: Text(option),
  value: option,
  );
  }).toList(),
  onChanged: (value) {

  selectedOption = value.toString();
  switch(selectedOption)
  {
  case  "Order No"||"رقم الطلب":
  searchoption=SearchOption.ORDER_NO;
  break;
  case  "Client No"||"رقم العميل":
  searchoption=SearchOption.CLIENT_NO;
  break;
  case "Client Name"||"اسم العميل":
  searchoption=SearchOption.CLIENT_NAME;
  break;

  }
update();
  },
  );
  }
  void sortOrders([String? enteredKeyword]) {
    List<Order> results = [];
    isLoading.value = true;

    if (enteredKeyword == null || enteredKeyword.isEmpty) {
      // Sort the original list by date (newest to oldest)
      results = List.from(ordersNames)
        ..sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
    } else {
      // Filter and then sort by date (newest to oldest)
      results = orders
          .where((order) => order.clientName
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList()
        ..sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
    }

    orders = results; // Update the sorted list
    isLoading.value = false;
    update();
  }

  void sortOrdersOldestToNewest([String? enteredKeyword]) {
    List<Order> results = [];
    isLoading.value = true;

    if (enteredKeyword == null || enteredKeyword.isEmpty) {
      // Sort the original list by date (oldest to newest)
      results = List.from(ordersNames)
        ..sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
    } else {
      // Filter and then sort by date (oldest to newest)
      results = orders
          .where((order) => order.clientName
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList()
        ..sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
    }

    orders = results; // Update the sorted list
    isLoading.value = false;
    update();
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
