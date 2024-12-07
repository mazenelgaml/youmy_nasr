import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/branches/branches_screen.dart';
import 'package:merchant/ui/home/components/product/product_screen.dart';
import 'couriers/courier_screen.dart';
import 'orders/order_screen.dart';
import '../../profile/profile_screen.dart';
import '../../../util/Constants.dart';


List<Widget> _pages = <Widget>[
  const BranchesScreen(),
  const OrderScreen(),
  const CourierScreen(),
  const ProductScreen(),
  const ProfileScreen()
];

class HomeScreens extends StatefulWidget {


   const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          mouseCursor: SystemMouseCursors.grab,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: KPrimaryColor,
          unselectedItemColor: inActiveIconColor,
          selectedIconTheme: const IconThemeData(color: KPrimaryColor, size: 40),
          unselectedIconTheme: const IconThemeData(
            color: inActiveIconColor,
          ),
          items: const [
            BottomNavigationBarItem( //HOME
              icon: Icon(
                Icons.home,
              ),
              label: 'Branches',
            ),
            BottomNavigationBarItem( //ORDERS
              icon: Icon(
                Icons.receipt,
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem( //COURIERS
              icon: Icon(
                Icons.group,
              ),
              label: 'Couriers',
            ),
            BottomNavigationBarItem( //PRODUCTS
              icon: Icon(
                Icons.apps,
              ),
              label: 'Products',
            ),
            BottomNavigationBarItem( //PROFILE
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
