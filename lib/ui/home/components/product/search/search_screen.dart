import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';
import '../controller/products_controller.dart';
import 'components/body.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static var routeName = "/search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar =  CustomText(
    text: searchTitle.tr,
    align: Alignment.center,
    fontColor: KPrimaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(context),
    builder: (ProductsController controller) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(
          text: searchTitle.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ) ,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: controller.isLoading.value?CircularProgressIndicator():const Body(),
    );});
  }

}
