import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/ui/auth/signup/signup_screen.dart';
import 'package:merchant/ui/profile/components/bank_account/bank_account_screen.dart';
import 'package:merchant/ui/profile/components/reports/reports_screen.dart';
import 'package:merchant/ui/profile/components/security/security_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/custom_text.dart';
import '../../../util/Constants.dart';

import '../../home/components/branches/new_branch/new_branch_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const CustomText(
          text: 'My Account',
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
              text: 'Merchant & Store Details',
              icon: Icons.store,
              press: () =>
                  {Navigator.pushNamed(context, SignUpScreen.routeName)},
            ),
            ProfileMenu(
              text: "Security & login",
              icon: Icons.person_add_alt_1,
              press: () {Navigator.pushNamed(context, SecurityScreen.routeName);},
            ),
            ProfileMenu(
              text: "Inbox",
              icon: Icons.notifications_active_sharp,
              press: () {Navigator.pushNamed(context, NotificationScreen.routeName);},
            ),
            ProfileMenu(
              text: "Settlement Reports",
              icon: Icons.description,
              press: () {Navigator.pushNamed(context, ReportScreen.routeName);},
            ),
            ProfileMenu(
              text: "Bank account information",
              icon: Icons.wallet_travel,
              press: () {Navigator.pushNamed(context, BankAccountScreen.routeName);},
            ),
            ProfileMenu(
              text: "Language",
              icon: Icons.language,
              press: () {},
            ),
            ProfileMenu(
              text: "About the app",
              icon: Icons.info_outline,
              press: () {
                print("https://www.google.com/");
                _launchInWebViewOrVC("https://www.google.com/");
              },
            ),
            ProfileMenu(
              text: "Contact us",
              icon: Icons.call,
              press: () {
                _makePhoneCall('+201022248887');
                // _launchInWebViewOrVC("https://www.facebook.com/");
              },
            ),
            ProfileMenu(
              text: "Privacy Policy",
              icon: Icons.privacy_tip_sharp,
              press: () {
                _launchInWebViewOrVC("https://twitter.com/home");
              },
            ),
            ProfileMenu(
              text: "Share the app with friends",
              icon: Icons.share,
              press: () {
                String share =
                    'hey! check out this new app https://play.google.com/store/apps/details?id=com.amazon.mShop.android.shopping&hl=en&gl=US';
                _openShare(share);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout,
              press: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
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
