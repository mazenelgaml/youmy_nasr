import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../data/model/Branch.dart';
import '../../../../../data/model/Comment.dart';
import '../../../../../data/model/Product.dart';
import '../../../../../data/model/courier.dart';
import '../../../../../models/branch_comments_model.dart';
import '../../../../../models/branch_details_model.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../models/couriers_model.dart';
import '../../../../../models/delivery_distance_model.dart' as d;
import '../../../../../models/products_list_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../util/Constants.dart';

class BranchesController extends GetxController {
  ScrollController scroll=ScrollController();
  List<Branches> branchesNames = [];
  List<Branch> branches = [];
  List<String> branchess = [];// List of job names to show in the dropdown
  var isLoading = false.obs; // Track loading state

  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await BranchesLists();
    products=productsD;
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

  List<ProductDetails> productsNames = [];
  List<Product> productsD = [];
 // Track loading state

  List<CommentsListB>commentsNames=[];
  List<Comment>commentsD=[];
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
  List<Product>products=[];
  Future<void> productsOfBranchList(int branchCode) async {
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
    // Start loading

    try {
      final response = await dio.post(
        "/api/v1/items/searchProductStock",
        data: {
          "search": {"companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branchCode,
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,},
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        ProductsListModel couriesListModel =
        ProductsListModel.fromJson(response.data);
        productsNames = couriesListModel.data ?? [];
        productsD = productsNames.map((productData) {
          return Product(

              id: productData.itemCode??"",
              isActive: true, images: [], colors: [], title: Get.find<CacheHelper>()
              .activeLocale == SupportedLocales.english? productData.itemNameEng??"":productData.itemNameAra??"",
              price: productData.defaultSellPrice?.toDouble()??0, description: productData.defaultUnitName??"");
        }).toList();

        print(productsD);
        print(productsNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load products')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  List<CouriersDetails> couriersNames = [];
  BranchDetailsModel? branchDetailsModel;
  List<Courier> couriersD = [];
  Future<void> CouriersLists(int branch) async {
    print(branch);
    couriersNames=[];
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
            "branchCode": branch,
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
          SnackBar(content: Text('Failed to load couriers')),
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
  void runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = productsD;
    } else {
      results = productsD
          .where((product) => product.title
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    products = results;
    update();
  }
  void sortProducts([String? enteredKeyword]) {
    List<Product> results = [];
    isLoading.value=true;
    if (enteredKeyword == null || enteredKeyword.isEmpty) {
      // Sort the original list alphabetically
      results = List.from(productsD)..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    } else {
      // Filter and then sort the results
      results = productsD
          .where((product) => product.title
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList()
        ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    }

    // Assign the sorted list to the target list
    productsD = results;
    isLoading.value=false;
    update();
  }
  void sortProductsByPrice([String? enteredKeyword]) {
    List<Product> results = [];
    isLoading.value=true;
    update();
    // Check if a keyword is provided
    if (enteredKeyword == null || enteredKeyword.isEmpty) {
      // Sort the original list by price (high to low)
      results = List.from(productsD)..sort((a, b) => b.price.compareTo(a.price));
    } else {
      // Filter and then sort by price (high to low)
      results = productsD
          .where((product) => product.title
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList()
        ..sort((a, b) => b.price.compareTo(a.price));
    }

    // Assign the sorted list to the target list
    productsD = results;
    isLoading.value=false;
    update();
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
        "/api/v1/employees/$empId",
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
  Future<void> commentsOfBranchList(int branchCode) async {

    print(branchCode);
    commentsNames=[];
    commentsD=[];
    isLoading.value=true;
    update();
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    // Start loading

    try {
      final response = await dio.post(
        "/api/v1/branchcomments/search",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branchCode,

          },

        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        print("sucessssssss");
        // Successful response
        BranchCommentsModel commentsOfBranchListModel =
        BranchCommentsModel.fromJson(response.data);
        commentsNames = commentsOfBranchListModel.data ?? [];
        commentsD = commentsNames.map((commentsNames) {
          return Comment(
            id:commentsNames.id??0, username: commentsNames.userName??"UserName isn't provided", text: commentsNames.comment??"", date: "${commentsNames.commentDate?.year}-${commentsNames.commentDate?.month.toString().padLeft(2, '0')}-${commentsNames.commentDate?.day.toString().padLeft(2, '0')}", );
        }).toList();
        print(commentsD);
        print(commentsNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load product\'s comments')),
        );
      }
    } catch (e) {
      print(e);
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> branchDetails(int branch) async {
    print(branch);
    couriersNames=[];
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
        "/api/v1/branches/searchDetail",
        data: {
          "search": {"companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branch,
           },

        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        BranchDetailsModel couriesListModel =
        BranchDetailsModel.fromJson(response.data);
        branchDetailsModel = couriesListModel;
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load branch details')),
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
  List<d.Datum>?deliveryCosts=[];
  Future<void> branchDeliveryCosts(int branch) async {
    print(branch);
    couriersNames=[];
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
        "/api/v1/branches/searchDetail",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branch

          },

        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        d.DeliveryDistanceModel deliveryDistanceModel =
        d.DeliveryDistanceModel.fromJson(response.data);
        deliveryCosts = deliveryDistanceModel.data;
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load branch delivery details')),
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


