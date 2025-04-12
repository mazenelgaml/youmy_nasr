import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/product/components/products_data.dart';
import 'package:get/get.dart';
import '../../../../../components/action_button.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/expandable_fab.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../controller/products_controller.dart';
import '../filter/filter_screen.dart';
import '../new_product/new_product_screen.dart';
import '../search/search_screen.dart';
import '../show_all_branches/product_branches_filter_screen.dart';
import '../update_product/update_product_screen.dart';

bool haveData = true;

class ProductsBody extends StatefulWidget {
  const ProductsBody({Key? key}) : super(key: key);

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(context),
    builder: (ProductsController controller) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:  CustomText(
          text: productScreenTitle.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return Get.find<CacheHelper>()
                  .activeLocale == SupportedLocales.english? {'A to Z', 'Hi to low'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  onTap: () {
                    if(choice=='A to Z'){
                   controller.sortProducts();
                    }else if(choice=='Hi to low'){
                      controller.sortProductsByPrice();
                    }
                  },
                );
              }).toList():
              {'من الألف إلى الياء', 'من الأعلى إلى الأدنى'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  onTap: () {
                    if(choice=='من الألف إلى الياء'){
                      controller.sortProducts();
                    }else if(choice=='من الأعلى إلى الأدنى'){
                      controller.sortProductsByPrice();
                    }
                  },
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0,right: 3),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: controller.
                  branches.map((String name) => GestureDetector(
                            child: Chip(
                              avatar: CircleAvatar(
                                child: Text(name.substring(0, 1)),
                              ),
                              label: Text(
                                name,
                              ),
                            ),
                            onTap: () async{

                              if(name=="All")
                                {
                                  Navigator.pushNamed(context, ProductBranchesFilterScreen.routeName);
                                }
                              else{
                                int branchCode=  controller.branchesNames?.firstWhere((branch) => branch.branchName == name).branchCode??0;
                                await controller.productsOfBranchList( branchCode);
                              }
                            },
                          ))
                      .toList(),
                ),
              ),
              controller.isLoading.value // إذا كانت البيانات لم تُجلب بعد، أظهر شاشة التحميل
                  ? Center(child: CircularProgressIndicator()) :ProductsData(isGridView: true,),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: KPrimaryColor,
      //   onPressed: () {
      //     Navigator.pushNamed(context, NewProductScreen.routeName);
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     size: 29,
      //   ),
      // ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () {
             Get.to(()=>NewProductScreen()); // add
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2), // search
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 3), // filter
            icon: const Icon(
              Icons.filter_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );});
  }
}

void _showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: KPrimaryColor,
      fontSize: 16.0);
}

void handleClick(String value) {
  switch (value) {
    case 'A to Z':
      break;
    case 'Hi to low':
      break;
    case 'Grid View':
      break;
  }
}

void _showAction(BuildContext context, int index) {
  switch (index) {
    case 1: // add
      Get.to(()=> UpdateProductScreen( id: 0,));
      break;
    case 2: // search
      Navigator.pushNamed(context, SearchScreen.routeName);
      break;
    case 3: // filter
      Navigator.pushNamed(context, FilterScreen.routeName);

      break;
  }
}