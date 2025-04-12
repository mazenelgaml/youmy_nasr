import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/data/model/Product.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../models/product_classifications_list_model.dart';
import '../../../../../models/products_brands_list_model.dart';
import '../../../../../models/products_groups_list_model.dart';
import '../../../../../models/products_list_model.dart';
import '../../../../../models/products_types_list_model.dart';
import '../../../../../models/sign_up_error_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';
import 'dart:convert';

class NewProductController extends GetxController {
  final String TAG = "Add New Product ";
  String? productName, factoryName, description, uml, price, priceAfterDiscount;
  final formKey = GlobalKey<FormState>();
  String selectedProductClassification=selectProductClass.tr;
  String selectedProductBrand=selectProductBrand.tr;
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
  TextEditingController productCodeController=TextEditingController();
  TextEditingController priceAfterDiscountController=TextEditingController();
  final List<String> categoriesList=["All"];
  var selectedUnit = "Select Unit";
  int selectedImage = 0;
  var pickedImage = File("");
int?productGroup;
  ListTile buildProductGroupField() {
    return ListTile(
      title: Text(selectedGroup),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(selectedGroup),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: productsGroupsD.map((country) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(country),
                        onTap: () async{
                          selectedGroup = country;
                          Navigator.pop(context); // Close the dialog
                          update();
                          // Update the UI
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  final List<String> productImages = [];
  ListTile buildProductclassificationField() {
    return ListTile(
      title: Text(selectedProductClassification),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(selectedProductClassification),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: productsClassificationsD.map((selectedClass) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(selectedClass),
                        onTap: () async{
                          selectedProductClassification = selectedClass;
                          Navigator.pop(context); // Close the dialog
                          update();
                          // Update the UI
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  ListTile buildProductBrandField() {
    return ListTile(
      title: Text(selectedProductBrand),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(selectedProductBrand),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: productsBrandsD.map((selectedBrand) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(selectedBrand),
                        onTap: () async{
                          selectedProductBrand = selectedBrand;
                          Navigator.pop(context); // Close the dialog
                          update();
                          // Update the UI
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      productImages.add(pickedImage.path);
      update(); // Update the UI
    }
  }
  void removeImage() {
    if (productImages.isNotEmpty) {
      productImages.removeLast();
      update(); // Update the UI
    }
  }
  Widget buildSmallProductPreview(int index) {
    if (index < productImages.length) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 30, // Adjust the size of the circle
          backgroundImage: FileImage(File(productImages[index])),
          backgroundColor: Colors.grey.shade200, // Optional: Fallback color
        ),
      );
    }
    return Container();
  }
  ImageProvider getImage(File file) {
    if (file.path.isEmpty) {
      return const AssetImage("assets/images/logo.png");
    } else {
      return FileImage(file);
    }
  }
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
      hintText: createProductNameEng.tr,
      onPressed: (value) {
        productName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPProductNameNullError);
          return "Product Name cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPProductNameNullError);
          return "Product Name cannot be empty";
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
  CustomTextFormField buildProductNameAraField() {
    return CustomTextFormField(
      controller: productNameAraController,
      textInputType: TextInputType.text,
      hintText: createProductNameAra.tr,
      onPressed: (value) {
        factoryName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPFactoryNameNullError);
          return "Factory Name cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPFactoryNameNullError);
          return "Factory Name cannot be empty";
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
      hintText: descriptionF.tr,
      onPressed: (value) {
        description = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPDescriptionNullError);
          return "Description cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPDescriptionNullError);
          return "Description cannot be empty";
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
          return "UOM cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPDescriptionNullError);
          return "UOM cannot be empty";
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
          return "Price cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPPriceNullError);
          return "Price cannot be empty";
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
  CustomTextFormField buildProductCodeField() {
    return CustomTextFormField(
      controller: productCodeController,
      textInputType: TextInputType.number,
      hintText: productCode.tr,
      onPressed: (value) {
        price = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPPriceNullError);
          return "Product Code cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPPriceNullError);
          return "Product Code cannot be empty";
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
          return "Price After Discount cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kPPriceAfterDiscountNullError);
          return "Price After Discount cannot be empty";
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
  BuildContext context;
  NewProductController(this.context);
  List<ProductDetails> productsNames = [];
  List<Product> productsD = [];
  List<ProductGroups> productsGroupsNames = [];
  List<String> productsGroupsD = [];
  List<ProductsClassifications> productsClassificationsNames = [];
  List<String> productsClassificationsD = [];
  List<ProductsBrands> productsBrandsNames = [];
  List<String> productsBrandsD = [];
  List<ProductDetails> allProductsNames = [];
  List<Product> allProductsD = [];
  var isLoading = false.obs;
  var selectedCategory = productCategory.tr;
  var selectedBrand = selectProductBrand.tr;
  var selectedGroup= selectProductGroup.tr;
  List<String>? selectCategory=[];
  List<ProductsTypes>? categoryName=[];
  String? categoryCode;
  ListTile buildCategoryField() {

    return ListTile(
      title: Text(selectedCategory),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(merchantType.tr),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: productsGroupsD.map((category) {
                      return ListTile(
                        leading: const Icon(Icons.propane_tank, size: 24.0), // Adjust icon size
                        title: Text(category),
                        onTap: () {
                          selectedCategory = category;
                          Navigator.pop(context); // Close the dialog
                          update(); // Update the UI
                        },
                      );
                    }).toList() ,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  // Future<void> postCategories() async {
  //   isLoading=true.obs;
  //   print("hello");
  //   final Dio dio = Dio(
  //     BaseOptions(
  //       baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
  //       validateStatus: (status) {
  //         return status != null && status < 500;
  //       },
  //     ),
  //   );
  //   try {
  //     final response = await dio.post(
  //       "/api/v1/itemtypes/searchData",
  //       data: {
  //         "search": {
  //           "LangId": Get.find<CacheHelper>()
  //               .activeLocale == SupportedLocales.english?2:1,
  //         }
  //
  //       },
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       print("aaaaaaaaaaaaaaa");
  //       // Successful response
  //       print(response.data,);
  //       ProductsTypesListModel productsTypesListModel = ProductsTypesListModel.fromJson(response.data);
  //       categoryName = productsTypesListModel.data;
  //       print(categoryName);// Save full job data if needed
  //       selectCategory = categoryName?.map((category) => category.itemTypeName?? '').toList() ?? [];
  //       print(selectCategory);
  //       // Extract only job names
  //     } else {
  //       // Error handling for failed response
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         const SnackBar(content: Text('Failed to load company types')),
  //       );
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during the API call
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       const SnackBar(content: Text('Error occurred while connecting to the API')),
  //     );
  //   }
  //   isLoading=false.obs;
  //   update();
  // }
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    // await productsLists();
    // await postCategories();
    await productsGroupsList();
    await productsClassificationsList();
    await productsBrandsList();
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
    productsNames=[];
    productsD=[];
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
          "Authorization": "Bearer $token"
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
              id: productData.id.toString(),
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
          const SnackBar(content: Text('Failed to load products')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> productsGroupsList() async {
    isLoading=true.obs;
    productsNames=[];
    productsD=[];
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
        data:{
          "search":{

            "langId":Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1
          }
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        ProductsGroupsListModel couriesListModel =
        ProductsGroupsListModel.fromJson(response.data);
        productsGroupsNames = couriesListModel.data ?? [];
        productsGroupsD = productsGroupsNames.map((productGroupName) => Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english?productGroupName.itemGroupNameEng??"":productGroupName.itemGroupNameAra ?? '').toList();
        print(productsGroupsNames);
        print(productsGroupsD); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load products')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      print(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading=false.obs;
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> productsClassificationsList() async {
    isLoading=true.obs;
    productsNames=[];
    productsD=[];
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
        "/api/v1/itemclassifications/searchData",
        data:{
          "search":{

            "langId":Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1
          }
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        ProductsClassificationsListModel productsCalssificationsListModel =
        ProductsClassificationsListModel.fromJson(response.data);
        productsClassificationsNames = productsCalssificationsListModel.data ?? [];
        productsClassificationsD = productsClassificationsNames.map((productGroupName) => productGroupName.itemClassName??"").toList();
        print(productsGroupsNames);
        print(productsGroupsD); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load products')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      print(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading=false.obs;
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> productsBrandsList() async {
    isLoading=true.obs;
    productsNames=[];
    productsD=[];
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
        "/api/v1/itembrands/search",
        data:{
          "search":{

            "langId":Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1
          }
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        ProductsBrandsListModel productsBrandsListModel =
        ProductsBrandsListModel.fromJson(response.data);
        productsBrandsNames = productsBrandsListModel.data?? [];
        productsBrandsD = productsBrandsNames.map((productBrandName) => Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english?productBrandName.itemBrandNameEng??"":productBrandName.itemBrandNameAra??"").toList();
        print(productsBrandsNames);
        print(productsBrandsD); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load products')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      print(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
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
          "Authorization": "Bearer $token"
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
          const SnackBar(content: Text('Failed to load products')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
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
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        int id=response.data;
        print(id);// Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to delete product')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    } finally {
      isLoading.value = false; // Stop loading
    }

    update();
  }
  Future<void> createProduct(BuildContext context) async {
    int productGroupCode = productsGroupsNames
        .firstWhere((group) =>
    group.itemGroupNameAra == selectedGroup ||
        group.itemGroupNameEng == selectedGroup)
        .id ??
        0;
    int productClassCode = productsClassificationsNames
        .firstWhere((group) =>
    group.itemClassName == selectedProductClassification)
        .id ??
        0;
    int productBrandCode = productsBrandsNames
        .firstWhere((brand) =>
    Get.find<CacheHelper>().activeLocale == SupportedLocales.english
        ? brand.itemBrandNameEng == selectedProductBrand
        : brand.itemBrandNameAra == selectedProductBrand)
        .id ??
        0;

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status <= 500;
        },
      ),
    );

    try {
      // Encode images to Base64
      List<String> base64Images = productImages.map((imagePath) {
        final bytes = File(imagePath).readAsBytesSync();
        return base64Encode(bytes);
      }).toList();

      // Prepare request body
      final requestBody = {
        "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
        "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
        "itemCode": productCodeController.text.trim(),
        "itemNameAra": productNameAraController.text.trim(),
        "itemNameEng": productNameController.text.trim(),
        "itemGroupCode": "$productGroupCode",
        "itemClassCode": "$productClassCode",
        "itemBrandCode": "$productBrandCode",
        "defaultSellPrice": priceController.text.trim(),
        "price1": priceAfterDiscountController.text.trim(),
        "price2": priceAfterDiscountController.text.trim(),
        "price3": priceAfterDiscountController.text.trim(),
        "productImageName": "string", // Update this with proper image names if needed
        "productImageExtension": "jpg", // Update this based on actual extensions
        "productImageData": base64Images.isNotEmpty ? base64Images.first : "",
        "request": {}, // Add required fields as per API documentation
      };

      // Print the request body for debugging
      print("Request Body: ${jsonEncode(requestBody)}");

      final response = await dio.post(
        "/api/v1/items", // Updated API endpoint
        data: requestBody,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":
            "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );

      // Log the raw response data and status code for debugging
      print("Response Status Code: ${response.statusCode}");
      print("Raw Response Data: ${response.data}");
      print("Response Headers: ${response.headers}");

      // Handle the response
      if (response.statusCode == 200) {
        if (response.data != null) {
          if (response.data is int) {
            print("Product created successfully with code: ${response.data}");
            int code = response.data;
            print("Code: $code");
          } else {
            print("Unexpected data format: ${response.data}");
          }
        } else {
          print("Empty response from API.");
        }

        // Refresh product lists
        await productsLists();
        Get.back();
      } else {
        // Handle errors
        SignUpErrorModel responseModel =
        SignUpErrorModel.fromJson(response.data);

        String errorMessage = responseModel.messages?.isNotEmpty == true
            ? responseModel.messages!.join(", ")
            : "An error occurred, but no detailed message was provided.";

        print("Error messages: $errorMessage");

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: const Text("OK"),
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
      print("Error: $e");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("An unexpected error occurred: $e"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
