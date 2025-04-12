import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/model/Product.dart';
import '../details/details_screen.dart';
import '../services/localization_services.dart';
import '../services/memory.dart';
import '../ui/home/components/product/controller/products_controller.dart';
import '../util/Constants.dart';
import '../util/size_config.dart';
import 'custom_text.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: widget.product),
        ),
        child: Column(
          children: [
            Divider(),
            Row(
              children: [
                SizedBox(
                    child: Image.asset('assets/images/logo.png'),
                    width: getProportionateScreenWidth(100)),
                CustomText(
                  text: widget.product.title,
                  align: Alignment.centerLeft,
                ),

                // AspectRatio(
                //   aspectRatio: 1.02,
                //   child: Container(
                //     padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                //     decoration: BoxDecoration(
                //       color: kSecondaryColor.withOpacity(0.1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     child: Hero(
                //       tag: widget.product.id.toString(),
                //       child: Image.asset('assets/images/logo.png'),
                //     ),
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Quantity : ${widget.product.quantity.toString()}",
                  align: Alignment.centerLeft,
                ),
                CustomText(
                  text: "Price : ${widget.product.price.toString()}" + " LE",
                  align: Alignment.centerLeft,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CustomText(
                text: (widget.product.price * widget.product.quantity)
                        .toString() +
                    " LE",
                fontSize: 21,
                fontWeight: FontWeight.bold,
                fontColor: KPrimaryColor,
                align: Alignment.centerRight,
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class ProductCard1 extends StatelessWidget {
  const ProductCard1({
    Key? key,
    // this.width = 140,
    // this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  // final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(context),
        builder: (ProductsController controller) {
          return GestureDetector(
      onTap: () {Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: ProductDetailsArguments(product: product),
      );
        controller.detailsOfProduct(product.itemCode??"",product.branchCode??0);
        },
      child: Hero(
        tag: product.id.toString(),
        child: GridTile(
            header: Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return Get.find<CacheHelper>()
                      .activeLocale == SupportedLocales.english?{'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                      onTap: () {
                        controller.isLoading.value=true;
                       controller.productDelete(product.id);
                       controller.productsLists();
                      },
                    );
                  }).toList():{'مسح'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                      onTap: () {
                        controller.isLoading.value=true;
                        controller.productDelete(product.id);
                        controller.productsLists();
                        controller.update();
                      },
                    );
                  }).toList();
                },
              ),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
            footer: Material(
              color: product.isActive ? Colors.transparent : KInActiveColor,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(4))),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: CustomText(
                    text: product.title,
                    fontColor: Colors.white,
                    fontSize: 20,
                    maxLine: 2,
                  ),
                  subtitle: CustomText(text: product.price.toString())),
            )),
      ),
    );});
  }

  void handleClick(String value) {
    switch (value) {
      case 'Delete':
        break;
      case 'InActive':
        break;
    }
  }
}
