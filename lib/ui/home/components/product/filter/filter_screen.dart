import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/product/filter/components/body.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);
  static var routeName = "/filter";

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const CustomText(
    text: 'Filter',
    align: Alignment.center,
    fontColor: KPrimaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        centerTitle: true,
        title: CustomText(
          text: 'Filter',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ) ,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: const Body(),
    );
  }


}
