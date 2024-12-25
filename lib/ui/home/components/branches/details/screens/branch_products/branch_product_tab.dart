import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:get/get.dart';
import '../../../../../../../components/action_button.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../components/expandable_fab.dart';
import '../../../../../../../components/product_card.dart';
import '../../../../../../../data/model/Product.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import '../../../../product/filter/filter_screen.dart';
import '../../../../product/new_product/new_product_screen.dart';
import '../../../../product/search/search_screen.dart';
import '../../../../product/show_all_branches/product_branches_filter_screen.dart';
import '../../../controller/branches_controller.dart';

class BranchProductsScreen extends StatefulWidget {
  const BranchProductsScreen({Key? key}) : super(key: key);

  @override
  State<BranchProductsScreen> createState() => _BranchProductsScreenState();
}

class _BranchProductsScreenState extends State<BranchProductsScreen> {

  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
        builder: (BranchesController controller) {
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
              return {'A to Z', 'Hi to low', 'Grid View'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  onTap: () {
                    isGridView = !isGridView;
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
              returnProductViewBody(true),
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
    );});
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
        Get.to(()=> NewProductScreen( id: 0,));
        break;
      case 2: // search
        Navigator.pushNamed(context, SearchScreen.routeName);
        break;
      case 3: // filter
        Navigator.pushNamed(context, FilterScreen.routeName);

        break;
    }
  }

  Widget returnProductViewBody(bool isGridView)

  {
    this.isGridView=isGridView;
     return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
  return isGridView
        ? GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1.2,
        children:controller.productsD
            .map((product) => ProductCard1(product: product))
            .toList())
        :
    ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: controller.productsD.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Dismissible(
          key: Key(controller.productsD[index].id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              controller.productsD.removeAt(index);
            });
          },
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: ProductCard1(product: controller.productsD[index]),
        ),
      ),
    );});
  }


}
