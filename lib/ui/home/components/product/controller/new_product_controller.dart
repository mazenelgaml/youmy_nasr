import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/data/model/Product.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../models/products_groups_list_model.dart';
import '../../../../../models/products_list_model.dart';
import '../../../../../models/products_types_list_model.dart';
import '../../../../../models/sign_up_error_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
class NewProductController extends GetxController {
  final String TAG = "Add New Product ";
  String? productName, factoryName, description, uml, price, priceAfterDiscount;
  final formKey = GlobalKey<FormState>();
  List<String?> errors = [];
  final List<String> uomList = [
    "Select Unit",
    "Unit 1",
    "Unit 2",
    "Unit 3",
    "Unit 4"
  ];
  TextEditingController productNameController=TextEditingController();
  TextEditingController productNameAraController=TextEditingController();
  TextEditingController factoryNameController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController umlController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController priceAfterDiscountController=TextEditingController();
  final List<String> categoriesList=["All"];
  var selectedUnit = "Select Unit";
  int selectedImage = 0;
  var _pickedImage = File("");
int?productGroup;
String selectedProductGroup="product groups";
  ListTile buildProductGroupField() {
    return ListTile(
      title: Text(selectedProductGroup ?? 'product groups'),
      trailing: Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Country'),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: productsGroupsD?.map((country) {
                      return ListTile(
                        leading: Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(country),
                        onTap: () async{
                          selectedProductGroup = country;
                          Navigator.pop(context); // Close the dialog
                          update();
                          // Update the UI
                        },
                      );
                    }).toList() ?? [],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
//endregion
  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {

        selectedImage = index;
        update();
      },
      child:  SizedBox(
        width: getProportionateScreenWidth(70),
        height: getProportionateScreenHeight(70),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: getImage(_pickedImage),
        ),
      ),
    );
  }
  void pickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Choose image source"), actions: [
            MaterialButton(
              child: const Text("Camera"),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            MaterialButton(
              child: const Text("Gallery"),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ]),
    ).then((source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        print('SOURCE ${pickedFile!.path}');


        _pickedImage = File(pickedFile.path);
        print('_pickedImage ${_pickedImage}');
        update();
      }
    });
  }
  ImageProvider getImage(File file) {
    if (file.path.isEmpty) {
      return const AssetImage("assets/images/logo.png");
    } else {
      return FileImage(file);
    }
  }
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
  CustomTextFormField buildProductNameField() {
    return CustomTextFormField(
      controller: productNameController,
      textInputType: TextInputType.text,
      hintText: productNameF.tr,
      onPressed: (value) {
        productName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPProductNameNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPProductNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPProductNameNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildFactoryNameField() {
    return CustomTextFormField(
      controller: factoryNameController,
      textInputType: TextInputType.text,
      hintText: factoryNameF.tr,
      onPressed: (value) {
        factoryName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPFactoryNameNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPFactoryNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPFactoryNameNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildDescriptionField() {
    return CustomTextFormField(
      controller: descriptionController,
      textInputType: TextInputType.text,
      hintText:descriptionF.tr,
      onPressed: (value) {
        description = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPDescriptionNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPDescriptionNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPDescriptionNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildUOMField() {
    return CustomTextFormField(
      controller: umlController,
      textInputType: TextInputType.text,
      hintText: productUnitF.tr,
      onPressed: (value) {
        description = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPDescriptionNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPDescriptionNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPDescriptionNullError);
        }
        return null;
      },
    );
  }
  // DropdownButton<Category> buildCategoryField() {
  //
  //
  //   return DropdownButton(
  //     hint: const CustomText(
  //       text: 'Category',
  //     ),
  //     iconSize: 40,
  //     isExpanded: true,
  //     value:  selectedCategory,
  //     items: demoCategories.map((category) {
  //       return DropdownMenuItem<Category>(
  //         child: Text(category.title),
  //         value: category,
  //       );
  //     }).toList(),
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCategory = value;
  //       });
  //     },
  //   );
  // }
  CustomTextFormField buildPriceField() {
    return CustomTextFormField(
      controller: priceController,
      textInputType: TextInputType.number,
      hintText: productPriceF.tr,
      onPressed: (value) {
        price = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPPriceNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPPriceNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPPriceNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildPriceAfterDiscountField() {
    return CustomTextFormField(
      controller: priceAfterDiscountController,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      hintText: productPriceAfterDiscountF.tr,
      onPressed: (value) {
        priceAfterDiscount = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPPriceAfterDiscountNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPPriceAfterDiscountNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPPriceAfterDiscountNullError);
        }
        return null;
      },
    );
  }
  BuildContext context;
  NewProductController(this.context);
  List<ProductDetails> productsNames = [];
  List<Product> productsD = [];
  List<ProductGroups> productsGroupsNames = [];
  List<String> productsGroupsD = [];
  List<ProductDetails> allProductsNames = [];
  List<Product> allProductsD = [];
  var isLoading = false.obs;
  var selectedCategory = productCategory.tr;
  List<String>? selectCategory=[];
  List<ProductsTypes>? categoryName=[];
  String? categoryCode;
  ListTile buildCategoryField() {

    return ListTile(
      title: Text(selectedCategory ?? 'Select category'),
      trailing: Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(merchantType.tr),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectCategory?.map((category) {
                      return ListTile(
                        leading: Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(category),
                        onTap: () {
                          selectedCategory = category;
                          Navigator.pop(context); // Close the dialog
                          update(); // Update the UI
                        },
                      );
                    }).toList() ?? [],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> PostCategories() async {
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    try {
      final response = await dio.post(
        "/api/v1/itemtypes/searchData",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          }

        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("aaaaaaaaaaaaaaa");
        // Successful response
        print(response.data,);
        ProductsTypesListModel productsTypesListModel = ProductsTypesListModel.fromJson(response.data);
        categoryName = productsTypesListModel.data;
        print(categoryName);// Save full job data if needed
        selectCategory = categoryName?.map((category) => category.itemTypeName?? '').toList() ?? [];
        update();
        print(selectCategory);
        update();// Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load company types')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
  }
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await productsLists();
    await PostCategories();// Fetch job data when the controller initializes
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
  Future<void> productsLists() async {
    isLoading=true.obs;
    productsNames=[];
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
        "/api/v1/items/searchData",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),

            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          },
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
              images:["assets/images/logo.png"],
              id: productData.id.toString()??"",
              rating: 3,
              isActive: true,  colors: [Colors.transparent], title: Get.find<CacheHelper>()
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
      isLoading=false.obs;
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> productsGroupsList() async {
    isLoading=true.obs;
    productsNames=[];
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
        "/api/v1/itemgroups/search",
        data: {
          {
            "keyword": "",
            "pageNumber": 0,
            "pageSize": 0
          }
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        ProductsGroupsListModel couriesListModel =
        ProductsGroupsListModel.fromJson(response.data);
        productsGroupsNames = couriesListModel.data ?? [];
        productsGroupsD = productsGroupsNames?.map((productGroupName) => Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english?productGroupName.itemGroupNameEng??"":productGroupName.itemGroupNameAra ?? '').toList() ?? [];
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
      isLoading=false.obs;
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> productsOfBranchList(int branchCode) async {
    isLoading=true.obs;
    allProductsNames=[];
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
        allProductsNames = couriesListModel.data ?? [];
        allProductsD = allProductsNames.map((productData) {
          return Product(
              id: productData.itemCode??"",
              isActive: true, images: [], colors: [], title: Get.find<CacheHelper>()
              .activeLocale == SupportedLocales.english? productData.itemNameEng??"":productData.itemNameAra??"",
              price: productData.defaultSellPrice?.toDouble()??0, description: productData.defaultUnitName??"");
        }).toList();
        print(allProductsD);
        print(allProductsNames); // Save full job data if needed
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
      isLoading=false.obs;
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> productDelete(String productId) async {
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
        "/api/v1/items/$productId",
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
          SnackBar(content: Text('Failed to delete product')),
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
  Future<void> CreateProduct(BuildContext context) async {
int productGroupCode=productsGroupsNames.firstWhere((group) => group.itemGroupNameAra==selectedProductGroup||group.itemGroupNameEng==selectedProductGroup).id??0;
    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    ));

    try {
      final response = await dio.put(
        "/api/v1/items",
        data:{

          "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
          "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
          "itemCode": "000124",
          "itemNameAra": productNameController.text.trim(),
          "itemNameEng": productNameAraController.text.trim(),
          "itemGroupCode": "${productGroupCode}",
          "itemClassCode": "1",
          "itemBrandCode": "1",
          "defaultSellPrice": priceController.text.trim(),
          "price1": priceAfterDiscountController.text.trim(),
          "price2": priceAfterDiscountController.text.trim(),
          "price3": priceAfterDiscountController.text.trim(),
          "productImageName": "string",
          "productImageExtension": "string",
          "productImageData": "baseData"
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("ttttttttttttttttttttttttttt");
        int?code=response.data;
        await productsLists();
        Get.back();

      } else {
        // Log the entire response for debugging
        print("Response Data: ${response.data}");

        // Handle error model
        SignUpErrorModel responseModel = SignUpErrorModel.fromJson(response.data);

        // Use messages if available
        String errorMessage = "An error occurred, but no detailed message was provided.";

        // Check if messages are available and not empty
        if (responseModel.messages?.isNotEmpty == true) {
          errorMessage = responseModel.messages!.join(", ");
        }
        // Check if vendorCode errors are available and not empty
        else if (responseModel.errors?.vendorCode?.isNotEmpty == true) {
          errorMessage = responseModel.errors!.vendorCode!.join(", ");
        }

        print("Messages: ${responseModel.messages}");
        print("VendorCode Errors: ${responseModel.errors?.vendorCode}");

        // Show error dialog
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
      // Catch and log unexpected errors
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
}
