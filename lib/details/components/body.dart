import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../components/custom_button.dart';
import '../../data/model/Product.dart';
import '../../services/localization_services.dart';
import '../../services/memory.dart';
import '../../ui/home/components/branches/controller/branches_controller.dart';
import '../../ui/home/components/product/controller/products_controller.dart';
import '../../ui/home/components/product/update_product/update_product_screen.dart';
import '../../util/size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(context),
    builder: (ProductsController controller) {
    return SafeArea(
      child:controller.isLoading.value?CircularProgressIndicator(): ListView(
        children: [
          SizedBox(height: getProportionateScreenHeight(2),),
          ProductImages(product: controller.productDetailsD[0]),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: controller.productDetailsD[0]??product,
                  pressOnSeeMore: () {},
                ),
                SizedBox(height: getProportionateScreenHeight(80),),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      text: Get.find<CacheHelper>()
                          .activeLocale == SupportedLocales.english?"Edit":"تعديل",
                      press: () {
                        Get.to(()=> UpdateProductScreen( id: int.parse(product.id),));
                      },

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );});
  }
}
