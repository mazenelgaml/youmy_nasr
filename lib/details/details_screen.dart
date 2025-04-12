import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/action_button.dart';
import 'package:merchant/ui/home/components/product/comments/comments_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/size_config.dart';
import '../data/model/Product.dart';
import '../services/localization_services.dart';
import '../services/memory.dart';
import '../ui/home/components/product/controller/products_controller.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return GetBuilder<ProductsController>(
        init: ProductsController(context),
        builder: (ProductsController controller) {
          return Scaffold(
      backgroundColor: KBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(10)),
            child: ActionButton(
              icon: Icon(Icons.delete, color: Colors.white),
              color: KInActiveColor,
              onPressed: () {
                _displayDialog(
                    context, Get.find<CacheHelper>()
                    .activeLocale == SupportedLocales.english?'Alert':"تنبيه", Get.find<CacheHelper>()
                    .activeLocale == SupportedLocales.english?'Do you want to delete this product?!':"هل تريد مسح هذا المنتج",(){
                  controller.productDelete(agrs.product.id);
                  controller.productsLists();
                      Navigator.pop(context);
                });
              },
            ),
          ),
          SizedBox(
            width:  getProportionateScreenWidth(10),
          ),
          ActionButton(
            icon: Icon(
              Icons.comment,
              color: Colors.white,

            ),
            onPressed: () {
              Navigator.pushNamed(context,CommentsScreen.routeName);
              int? code=int.tryParse(agrs.product.id);
              controller.commentsOfProductList( agrs.product.itemCode??"" , agrs.product.branchCode??0);
            },
          ),
          SizedBox(
            width:  getProportionateScreenWidth(10),
          ),
        ],
      ),
      body: Body(product: agrs.product),
    );});
  }

  _displayDialog(BuildContext context, String title, String message,Function? Function() onTap) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    color: KPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(message),
              actions: [
                MaterialButton(
                    child: Text(Get.find<CacheHelper>()
                        .activeLocale == SupportedLocales.english?"OK":"حسنًا"),
                    onPressed: onTap ),
                MaterialButton(
                    child: Text(Get.find<CacheHelper>()
                        .activeLocale == SupportedLocales.english?"Cancel":"إلغاء""Cancel"),
                    onPressed: () => Navigator.pop(context))
              ]);
        });
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
