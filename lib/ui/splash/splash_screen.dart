import 'package:flutter/material.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

class SplashScreen extends StatefulWidget {
  static var routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // isUserLogged();
  }

  // void isUserLogged() {
  //   Timer(
  //       const Duration(seconds: 4),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => const LoginScreen())));
  // }

  @override
  Widget build(BuildContext context) {
    // isUserLogged();
   return SplashView(

        backgroundColor: const Color(0xffffffff),
        duration: const Duration(seconds: 4),
        done: Done(
    LoginScreen()),
            // Get.find<CacheHelper>().checkUserIsSignedIn?const HomeScreen():const WelcomeScreen()),

        logo: const Stack(
            alignment: Alignment.topCenter,
            children:[
              Image(image: AssetImage('assets/images/logo.png')),

            ]
        ) );
  }
}
