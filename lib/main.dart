
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/splash/splash_screen.dart';
import 'package:merchant/util/routes.dart';
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Get.putAsync(() => CacheHelper.init(), permanent: true); // تأكد من تهيئة الـ CacheHelper
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      routes: routes,
      title: 'EgyXplore',
      debugShowCheckedModeBanner: false,


      home:SplashScreen(),

    );
  }
}