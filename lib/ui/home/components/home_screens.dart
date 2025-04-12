
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/branches/branches_screen.dart';
import 'package:merchant/ui/home/components/product/product_screen.dart';
import 'branches/controller/branches_controller.dart';
import 'couriers/courier_screen.dart';
import 'orders/order_screen.dart';
import '../../profile/profile_screen.dart';
import '../../../util/Constants.dart';

List<Widget> _pages = <Widget>[
  const BranchesScreen(),
  const OrderScreen(),
  const CourierScreen(),
  const ProductScreen(),
  const ProfileScreen(),
];

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BranchesController(),
      builder: (BranchesController controller) {
        return Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
          mouseCursor: SystemMouseCursors.grab,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: KPrimaryColor,
          unselectedItemColor: inActiveIconColor,
          selectedIconTheme: IconThemeData(color: KPrimaryColor, size: 40),
          unselectedIconTheme: IconThemeData(color: inActiveIconColor),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: branchesNavBar.tr, // Using GetX's `.tr`
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: ordersNavBarr.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: couriersNavBar.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: productsNavBar.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: profileNavBar.tr,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),

        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
    if(index==0){
      Get.put(BranchesController());
    }
  }
}
