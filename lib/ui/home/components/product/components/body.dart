import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant/components/empty_view.dart';
import 'package:merchant/ui/home/components/product/components/products_data.dart';
import 'package:merchant/ui/home/components/product/new_product/new_product_screen.dart';

import '../../../../../components/action_button.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/expandable_fab.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../../home_screen.dart';
import '../filter/filter_screen.dart';
import '../search/search_screen.dart';
import '../show_all_branches/product_branches_filter_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const CustomText(
          text: 'Products',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'A to Z', 'Hi to low', 'Grid View'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  onTap: () {
                   _showToast(choice);
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
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  "Maadi",
                  "Helwan",
                  "Tahrir",
                  "H-Kopa",
                  "New Cairo",
                  "All"
                ]
                    .map((String name) => GestureDetector(
                          child: Chip(
                            avatar: CircleAvatar(
                              child: Text(name.substring(0, 1)),
                            ),
                            label: Text(
                              name,
                            ),
                          ),
                          onTap: () {

                            if(name=="All")
                              {
                                Navigator.pushNamed(context, ProductBranchesFilterScreen.routeName);
                              }
                            else
                              _showToast("$name is Pressed");
                          },
                        ))
                    .toList(),
              ),
               ProductsData(isGridView: true,),
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
              _showAction(context, 1); // add
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
    );
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
      Navigator.pushNamed(context, NewProductScreen.routeName);
      break;
    case 2: // search
      Navigator.pushNamed(context, SearchScreen.routeName);
      break;
    case 3: // filter
      Navigator.pushNamed(context, FilterScreen.routeName);

      break;
  }
}