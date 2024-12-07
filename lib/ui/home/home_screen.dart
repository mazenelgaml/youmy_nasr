import 'package:flutter/material.dart';
import 'components/home_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static var routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // دالة لمنع الرجوع عند ضغط زر الرجوع في الهاتف فقط
  Future<bool> _onWillPop() async {
    // منع الرجوع من زر الهاتف (ليس من أي مكان آخر في التطبيق)
    return false; // يمنع الرجوع
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: _onWillPop, // منع الرجوع عند الضغط على زر الرجوع في الهاتف
      child: const Scaffold(

        body: HomeScreens(),
      ),
    );
  }
}
