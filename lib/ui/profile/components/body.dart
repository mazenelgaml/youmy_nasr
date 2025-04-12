import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/services/memory.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/auth/login/controller/login_controller.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/ui/auth/signup/signup_screen.dart';
import 'package:merchant/ui/profile/components/bank_account/bank_account_screen.dart';
import 'package:merchant/ui/profile/components/bank_account/bank_accounts_inserted_screen.dart';
import 'package:merchant/ui/profile/components/reports/reports_screen.dart';
import 'package:merchant/ui/profile/components/security/security_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/custom_text.dart';
import '../../../services/localization_services.dart';
import '../../../util/Constants.dart';

import '../../auth/start/start_screen.dart';
import '../../home/components/branches/controller/branches_controller.dart';
import '../../home/components/branches/new_branch/new_branch_screen.dart';
import '../about_us_screen.dart';
import '../notification/notifiction_screen.dart';
import 'profile_menu.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _pickedImage = File("");

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
    builder: (LoginController controller) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:  CustomText(
          text: profileScreenTitle.tr,
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 88,
              width: 88,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: getImage(_pickedImage),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                          disabledBackgroundColor: Colors.white,
                          backgroundColor: const Color(0xFFF5F6F9),
                        ),
                        onPressed: () {
                          _pickImage();
                        },
                        child: SvgPicture.asset("assets/icons/Camera.svg",
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ProfileMenu(
              text: merchantAndStoreDetails.tr,
              icon: Icons.store,
              press: () {}
                  // {Navigator.pushNamed(context, SignUpScreen.routeName)},
            ),
            ProfileMenu(
              text: securityAndLogIn.tr,
              icon: Icons.person_add_alt_1,
              press: () {Navigator.pushNamed(context, SecurityScreen.routeName);},
            ),
            ProfileMenu(
              text: inBox.tr,
              icon: Icons.notifications_active_sharp,
              press: () {Navigator.pushNamed(context, NotificationScreen.routeName);},
            ),
            ProfileMenu(
              text: settlementReports.tr,
              icon: Icons.description,
              press: () {}//Navigator.pushNamed(context, ReportScreen.routeName);},
            ),
            ProfileMenu(
              text: bankAccountInformation.tr,
              icon: Icons.wallet_travel,
              press: () {Get.to(()=>BankAccountsInsertedScreen());},
            ),
            ProfileMenu(
              text: language.tr,
              icon: Icons.language,
              press: () {
                final cacheHelper = Get.find<CacheHelper>();

                // Toggle between Arabic and English
                final newLocale = cacheHelper.activeLocale == SupportedLocales.arabic
                    ? SupportedLocales.english
                    : SupportedLocales.arabic;

                // Update in storage and GetX
                cacheHelper.activeLocale = newLocale;
                Get.updateLocale(newLocale);
              },
            ),

            ProfileMenu(
              text: aboutTheApp.tr,
              icon: Icons.info_outline,
              press: () {
                print("https://www.google.com/");
                Get.to(() => AboutUsScreen(htmlData: controller.aboutUs.first.aboutUsBody ?? 'No content available'));
              },
            ),
            ProfileMenu(
              text: contactUs.tr,
              icon: Icons.call,
              press: () {
                _makePhoneCall('+201022248887');
                // _launchInWebViewOrVC("https://www.facebook.com/");
              },
            ),
            ProfileMenu(
              text: privacyPolicy.tr,
              icon: Icons.privacy_tip_sharp,
              press: () {
                // Get.to(()=>StartScreen());
                _launchInWebViewOrVC("https://twitter.com/home");
              },
            ),
            ProfileMenu(
              text: shareTheAppWithFriends.tr,
              icon: Icons.share,
              press: () {
                String share =
                    'hey! check out this new app https://play.google.com/store/apps/details?id=com.amazon.mShop.android.shopping&hl=en&gl=US';
                _openShare(share);
              },
            ),
            ProfileMenu(
              text: logOut.tr,
              icon: Icons.logout,
              press: () {
                // Get.to(()=>LoginScreen);
                // Get.find<CacheHelper>().loggingOut();
                Get.put(LoginController);
                controller.getBranches();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );});
  }

  void _pickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Choose image source"), actions: [
        MaterialButton(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        MaterialButton(
          child: const Text("Gallery"),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
      ]),
    ).then((source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        print('SOURCE ${pickedFile!.path}');

        setState(() {
          _pickedImage = File(pickedFile.path);
          print('_pickedImage ${_pickedImage}');
        });
      }
    });
  }

  ImageProvider getImage(File file) {
    if (file.path.isEmpty) {
      return const AssetImage("assets/images/profile.png");
    } else {
      return FileImage(file);
    }
  }

  Future<void> _launchInWebViewOrVC(String _url) async {
    if (!await launchUrl(
      Uri.parse(_url),
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
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

  void _openShare(String share) {
    Share.share(share);
  }
}
