import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/components/profile_image_widget.dart';
import 'package:merchant/services/translation_key.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import 'package:merchant/ui/auth/signup/screens/merchant_details/merchant_details_form.dart';

class BodyMerchantDetails extends StatefulWidget {

  const BodyMerchantDetails({Key? key}) : super(key: key);

  @override
  State<BodyMerchantDetails> createState() => _BodyMerchantDetailsState();
}

class _BodyMerchantDetailsState extends State<BodyMerchantDetails> {
  var _pickedImage = File("");
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                 CustomText(text: merchantDetials.tr,align: Alignment.center,fontColor: KPrimaryColor,fontWeight: FontWeight.bold,),
                SizedBox(height: SizeConfig.screenHeight * 0.02),// 4%
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
                      )
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                SignUpFormMerchantDetails(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content:  Text(chooseImageSource.tr), actions: [
            MaterialButton(
              child:  Text(camera.tr),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            MaterialButton(
              child:  Text(gallery.tr),
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
}
