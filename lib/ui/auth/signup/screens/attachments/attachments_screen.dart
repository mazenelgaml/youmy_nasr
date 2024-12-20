import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/auth/signup/screens/attachments/body_attachment.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../controller/signup_controller.dart';

class BodyAttachments extends StatefulWidget {
  const BodyAttachments({Key? key}) : super(key: key);

  @override
  State<BodyAttachments> createState() => _BodyAttachmentsState();
}

class _BodyAttachmentsState extends State<BodyAttachments> {
  //region variables


  //endregion

  //region events
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(context),
        builder: (SignupController controller) {
          return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  CustomText(
                    text: merchantAttachments.tr,
                    align: Alignment.center,
                    fontColor: KPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                  const SignUpAttachment(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          showCreateNewAttachmentView(context);
        },
        child: const Icon(
          Icons.add_photo_alternate_outlined,
          size: 29,
        ),
      ),
    );});
  }

//endregion

//region helper functions
  void showCreateNewAttachmentView(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetBody();
      },
    );
  }





//endregion

}

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({Key? key}) : super(key: key);

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  var _pickedImage = File("");
  @override
  Widget build(BuildContext context) {
  return GetBuilder<SignupController>(
  init: SignupController(context),
  builder: (SignupController controller) {
  return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              const CustomText(
                text: 'New Attachment',
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontSize: 23,
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SizedBox(
                height: 88,
                width: 88,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: controller.getImage(_pickedImage),
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
                            controller.pickImage(context);
                          },
                          child: SvgPicture.asset("assets/icons/Camera.svg",
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              )
              // ProfileImageWidget(iconName: _pickedImage.path,onPressed: _pickImage),
              ,
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              CustomTextFormField(
                hintText: 'Title',
                onPressed: () {},
                onChange: () {},
                onValidate: () {},
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              CustomTextFormField(
                  hintText: 'Description',
                  textInputAction: TextInputAction.done,
                  onPressed: () {},
                  onChange: () {},
                  onValidate: () {}),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomButton(
                text: 'Create',
                press: () => {Navigator.pop(context)},
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
            ],
          ),
        ),
      ),
    );});
  }


}

