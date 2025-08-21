import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/models/order_details_model.dart' as d;
import '../../../../../components/custom_text.dart';
import '../../../../../data/model/Branch.dart';
import '../../../../../data/model/Order.dart';
import '../../../../../data/model/courier.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../models/couriers_model.dart';
import '../../../../../models/orders_list_model.dart' as model;
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../search/components/body.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  List<model.Order> ordersNames = [];
  List<d.Datum>? orderDetails=[];
  List<Order> orders = [];
  List<Order> ordersDetails = [];
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
    await getOrdersDetails();
    ordersD=orders;
    filteredOrders .value= ordersD;// Fetch order data when the controller initializes
  }
  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final url = Uri.parse("https://api.yomycart.com/api/v1/sellOrderHeaders/$orderId");
    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },

      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
           SnackBar(content: Text("Order updated to $newStatus ✅")),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Failed to update status ❌")));
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
         SnackBar(content: Text("Error: $e")),
      );
    }
  }

  List<Branches> branchesNames = [];
  List<Branch> branches = [];
  Future<void> updateSalesMan(int id,int salesCode) async {
    final dio = Dio();
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    String url = "https://api.yomycart.com/api/v1/sellOrderHeaders/$id";

    final data = {
      "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
      "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
      "id": id,
      "SalesManCode": "$salesCode" // Ensure it's a String
    };

    try {
      final response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print("✅ Update successful: ${response.data}");
    } catch (e) {
      print("❌ Error updating: $e");
    }
  }
  Future<void> orderDelete(int orderId) async {
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
        "/api/v1/sellOrderHeaders/$orderId",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('order deleted successfully')),
        );
        int id=response.data;
        print(id);// Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to delete the order')),
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
  List<CouriersDetails> couriersNames = [];
  List<Courier> couriersD = [];
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
  Courier? findCourierById(int id) {
    try {
      print("Looking for order with id: $id");
      print(couriersD); // Log the orderDetails list to see its contents
      return couriersD.firstWhere((courier) => courier.id == id);
    } catch (e) {
      print("Order not found with id: $id");
      return null;
    }
  }
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
  Future<void> getOrdersDetails() async {
    isLoading.value = true; // Start loading

    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    try {
      final response = await dio.post(
        "/api/v1/sellOrderHeaders/fullOrderSearch",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
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
        d.OrderDetailsModel ordersDetailsModel = d.OrderDetailsModel.fromJson(response.data);
        orderDetails = ordersDetailsModel.data ?? [];
        print(orderDetails?[0].sellOrdersSerial);
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load orders details')),
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
  d.Datum? findOrderById(int id) {
    try {
      print("Looking for order with id: $id");
      print(orderDetails?[1].sellOrderStatusCode); // Log the orderDetails list to see its contents
      return orderDetails?.firstWhere((order) => order.id == id);
    } catch (e) {
      print("Order not found with id: $id");
      return null;
    }
  }

  Order? findOrdersById(int id) {
    try {
      print(orders);
      return orders?.firstWhere((order) => order.id == id);
    } catch (e) {
      print("Order not found with id11111: $id");
      return null;
    }
  }


}
