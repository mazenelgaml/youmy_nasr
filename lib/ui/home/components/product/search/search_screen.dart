import 'package:flutter/material.dart';
import 'package:merchant/details/components/custom_app_bar.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';
import 'components/body.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static var routeName = "/search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const CustomText(
    text: 'Search',
    align: Alignment.center,
    fontColor: KPrimaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(
          text: 'Search',
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
