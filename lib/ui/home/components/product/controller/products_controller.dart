import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/data/model/Product.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../data/model/Comment.dart';
import '../../../../../models/branches_list_model.dart';
import '../../../../../models/item_comments_model.dart';
import '../../../../../models/item_details_model.dart';
import '../../../../../models/product_details_model.dart';
import '../../../../../models/product_filter_categories_model.dart';
import '../../../../../models/products_brands_list_model.dart';
import '../../../../../models/products_list_model.dart';
import '../../../../../models/products_types_list_model.dart';
import '../../../../../models/sign_up_error_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
class ProductsController extends GetxController {
  final String TAG = "Add New Product ";
  List<ProductDetailsModel> productDetails=[];
  List<FilterCategory>productFilterNames=[];
  List<FilterCategory> productSubFilterNames=[];
  List<FilterCategory> productChildFilterNames=[];
  List<Product>productDetailsD=[];
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
  TextEditingController factoryNameController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController umlController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController priceAfterDiscountController=TextEditingController();
  TextEditingController productCodeController=TextEditingController();
  TextEditingController productNameAraController=TextEditingController();
  final List<String> categoriesList=["All"];
  var selectedUnit = "Select Unit";
  int selectedImage = 0;
  var _pickedImage = File("");
  List<Branches> branchesNames = [];
  List<String> branches = [];
  List<Datum>commentsNames=[];
  List<Comment>commentsD=[];
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
  ProductsController(this.context);
  List<ProductDetails> productsNames = [];
  List<Product> productsD = [];
  List<ProductDetails> allProductsNames = [];
  List<Product> allProductsD = [];
  var isLoading = false.obs;
  var selectedCategory = productCategory.tr;
  List<String>? selectCategory=[];
  List<ProductsTypes>? categoryName=[];
  String? categoryCode;
  ListTile buildCategoryField() {

    return ListTile(
      title: Text(selectedCategory),
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
  List<Product>products=[];
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await PostCategories();
    await BranchesLists();
    await productsLists();
   products=productsD;
   await filterCategoriesLists("");
   await productsBrandsList();
  }
  List<ProductsBrands> productsBrandsNames = [];
  List<String> productsBrandsD = [];
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
        branches = branchesNames.map((branch) => branch.branchName ?? '').toList();

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
  Future<void> filterCategoriesLists(String? parentCode ) async {
    productFilterNames=[];
    isLoading.value=true;
    update();
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
        "/api/v1/itemClassifications/searchData",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "parentClass": parentCode??""
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
        ProductsFilterCategoriesModel productFilterCategoryModel = ProductsFilterCategoriesModel.fromJson(response.data);
       productFilterNames=productFilterCategoryModel.data??[];
        print(productFilterNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load Filter\'s categories' )),
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
  Future<void> filterSubCategoriesLists(String? parentCode ) async {
    productSubFilterNames=[];
    isLoading.value=true;
    update();
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
        "/api/v1/itemClassifications/searchData",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "parentClass": parentCode??""
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
        ProductsFilterCategoriesModel productFilterCategoryModel = ProductsFilterCategoriesModel.fromJson(response.data);
        productSubFilterNames=productFilterCategoryModel.data??[];
        print(productSubFilterNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load Filter\'s sub categories' )),
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
  Future<void> filterChildCategoriesLists(String? parentCode ) async {
    productChildFilterNames=[];
    isLoading.value=true;
    update();
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
        "/api/v1/itemClassifications/searchData",
        data: {
          "search": {
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "parentClass": parentCode??""
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
        ProductsFilterCategoriesModel productFilterCategoryModel = ProductsFilterCategoriesModel.fromJson(response.data);
        productChildFilterNames=productFilterCategoryModel.data??[];
        print(productChildFilterNames); // Save full job data if needed
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load Filter\'s categories' )),
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
  Future<void> productsLists() async {
    allProductsNames=[];
    allProductsD=[];
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
          "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),

          "LangId": Get.find<CacheHelper>()
              .activeLocale == SupportedLocales.english?2:1,
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
            itemCode: productData.itemCode,
            branchCode: productData.branchCode,
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
    allProductsNames=[];
    allProductsD=[];
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
            branchCode: productData.branchCode,
              id: productData.itemCode??"",
              isActive: true, images: [], colors: [], title: Get.find<CacheHelper>()
              .activeLocale == SupportedLocales.english? productData.itemNameEng??"":productData.itemNameAra??"",
              price: productData.defaultSellPrice?.toDouble()??0, description: productData.defaultUnitName??"");
        }).toList();
        productsNames=allProductsNames;
        productsD=allProductsD;
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
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> commentsOfProductList(String itemCode,int branchCode) async {
    print(itemCode);
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
        "/api/v1/itemcomments/search",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branchCode,
            "itemCode": itemCode
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
        ItemCommentsModel commentsListModel =
        ItemCommentsModel.fromJson(response.data);
        commentsNames = commentsListModel.data ?? [];
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
  Future<void> detailsOfProduct(String itemCode,int branchCode) async {
    print(itemCode);
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
        "/api/v1/items/searchItemDetail",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
            "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
            "branchCode": branchCode,
            "itemCode": itemCode
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
        ProductDetailsModel productDetailModel =
        ProductDetailsModel.fromJson(response.data);
        print(response.data);
       productDetails=[productDetailModel];
        productDetailsD=productDetails.map((productData) {
          return Product(

            rating: productData.rate?.toDouble()??0.0,
              branchCode: productData.branchCode,
              id: productData.itemCode??"",
              isActive: productData.itemOn==1, images: [productData.productImage??"assets/images/logo.png"], colors: [], title: Get.find<CacheHelper>()
              .activeLocale == SupportedLocales.english? productData.itemNameEng??"":productData.itemNameAra??"",
              price: productData.defaultSellPrice?.toDouble()??0, description: productData.defaultUnitName??"");
        }).toList();
        print(productDetailsD);
        print(productDetailsD[0].id);

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
        print(id);
        productsLists();// Save full job data if needed
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
      isLoading.value = false;
      update();// Stop loading
    }

    update(); // Update UI
  }
  Future<void> updateProduct(BuildContext context,int productId) async {

    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    ));

    try {
      final response = await dio.put(
        "/api/v1/items/$productId",
        data: {

            "id": productId,
            "itemCode": "$productId",
            "descriptionAra": descriptionController.text.trim(),
            "descriptionEng": descriptionController.text.trim(),
            "defaultSellPrice": priceController.text.trim(),
            "itemNameAra": productNameController.text.trim(),
            "itemNameEng":  productNameController.text.trim(),
            "defaultUnitName": umlController.text.trim(),
            "itemTypeName": selectCategory
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

        print("Response Data: ${response.data}");
        SignUpErrorModel responseModel = SignUpErrorModel.fromJson(response.data);
        String errorMessage = "An error occurred, but no detailed message was provided.";
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
  Future<void> productsBrandsList() async {
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
}
