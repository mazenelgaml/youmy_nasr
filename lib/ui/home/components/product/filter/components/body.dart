import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_action_chip.dart';
import 'package:merchant/components/custom_button.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/data/model/Brand.dart';
import 'package:merchant/data/model/Category.dart';
import 'package:merchant/data/model/SubCategory.dart';
import 'package:merchant/data/model/SubSubCategory.dart';
import '../../../../../../components/custom_chip.dart';
import '../../../../../../components/product_card.dart';
import '../../../../../../data/model/Product.dart';
import '../../../../../../services/localization_services.dart';
import '../../../../../../services/memory.dart';
import '../../../../../../util/Constants.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';
import '../../controller/products_controller.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> _products = [];

  @override
  void initState() {
    _products = demoProducts;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = demoProducts;
    } else {
      results = demoProducts
          .where((product) => product.title
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _products = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      init: ProductsController(context),
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.isLoading.value
                ? const CircularProgressIndicator()
                : Column(
              children: [
                CustomText(
                  text: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? 'Categories'
                      : "الفئات",
                  fontSize: 20,
                  align: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? Alignment.topLeft
                      : Alignment.topRight,
                ),
                const Divider(),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: controller.productFilterNames
                      .map(
                        (category) => CustomChip(
                      type: 2,
                      label: category.itemClassName ?? "",
                      onSelected: (bool isSelected) async{
                        print('Selected: $isSelected');
                        controller.isLoading.value=true;
                        controller.update();
                        await controller.filterSubCategoriesLists(
                            category.parentClass);
                      },
                      onPressed: () async {

                          controller.isLoading.value=true;
                          controller.update();
                          await controller.filterSubCategoriesLists(
                              category.parentClass);
                       // Ensure UI is updated
                      },
                    ),
                  )
                      .toList(),
                ),
                const Divider(),
                CustomText(
                  text: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? 'Sub Categories'
                      : "الفئات الفرعية",
                  fontSize: 20,
                  align: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? Alignment.topLeft
                      : Alignment.topRight,
                ),
                const Divider(),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: controller.productSubFilterNames
                      .map(
                        (subCategory) => CustomChip(
                      type: 2,
                      label: subCategory.itemClassName ?? "",
                      onSelected: (bool isSelected) async{
                        print('Selected: $isSelected');
                        controller.isLoading.value=true;
                        controller.update();
                        await controller.filterChildCategoriesLists(
                            subCategory.parentClass);
                      },
                      onPressed: () async {
                        controller.isLoading.value=true;
                        controller.update();
                        await controller.filterChildCategoriesLists(
                            subCategory.parentClass);
                        setState(() {}); // Ensure UI is updated
                      },
                    ),
                  )
                      .toList(),
                ),
                const Divider(),
                CustomText(
                  text: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? 'Child Sub Categories'
                      : "الفئات الفرعية التابعة",
                  fontSize: 20,
                  align: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? Alignment.topLeft
                      : Alignment.topRight,
                ),
                const Divider(),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: controller.productChildFilterNames
                      .map(
                        (childCategory) => CustomChip(
                      type: 2,
                      label: childCategory.itemClassName ?? "",
                      onSelected: (bool isSelected) {
                        print('Selected: $isSelected');
                      },
                      onPressed: () {
                        // Handle child category selection
                      },
                    ),
                  )
                      .toList(),
                ),
                const Divider(),
                CustomText(
                  text: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? 'Brands'
                      : "العلامات التجارية",
                  fontSize: 20,
                  align: Get.find<CacheHelper>()
                      .activeLocale ==
                      SupportedLocales.english
                      ? Alignment.topLeft
                      : Alignment.topRight,
                ),
                const Divider(),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: controller.productsBrandsNames
                      .map(
                        (brand) => CustomChip(
                      type: 2,
                      label: Get.find<CacheHelper>()
                          .activeLocale == SupportedLocales.english?brand.itemBrandNameEng??"":brand.itemBrandNameAra??"",
                      onSelected: (bool isSelected) {
                        print('Selected: $isSelected');
                      },
                      onPressed: () {
                        // You can filter products based on selected brand
                        // await controller.filterByBrand(brand);
                      },
                    ),
                  )
                      .toList(),
                ),
                const Divider(),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Apply',
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

