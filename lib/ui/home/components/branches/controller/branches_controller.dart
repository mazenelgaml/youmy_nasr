import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/model/Branch.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../services/memory.dart';

class BranchesController extends GetxController {
  List<Branches> branchesNames = [];
  List<Branch> branches = []; // List of job names to show in the dropdown
  var isLoading = false.obs; // Track loading state

  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await BranchesLists(); // Fetch job data when the controller initializes
  }

  Future<void> BranchesLists() async {
    String? token = await Get.find<CacheHelper>().getData(key: "token");
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://apiezz.dalia-ezzat.com/api",
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    isLoading.value = true; // Start loading

    try {
      final response = await dio.post(
        "/v1/branches/searchData",
        data: {
          "search": {
            "companyCode": 1,
            "LangId": 2
          },
          "request": 2
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
            id: branchData.id,
            name: branchData.branchName,
            address: "${branchData.branchName}, Egypt",
            status: StoreState.BUSY,
            rating: branchData.branchRate
          );
        }).toList() ?? [];

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
}
