import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../components/custom_button.dart';
import '../../data/model/Product.dart';
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
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: getProportionateScreenHeight(2),),
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                SizedBox(height: getProportionateScreenHeight(80),),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      text: "Edit",
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
    );
  }
}
