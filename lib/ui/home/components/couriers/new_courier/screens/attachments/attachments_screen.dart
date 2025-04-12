import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/attachments/body_attachment.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../data/model/Attachment.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';
import '../../../controller/new_courier_controller.dart';

List<Attachment> demoCourierAttachments = [];
class CourierAttachmentTab extends StatefulWidget {
  const CourierAttachmentTab({super.key});

  @override
  State<CourierAttachmentTab> createState() => _CourierAttachmentTabState();
}

class _CourierAttachmentTabState extends State<CourierAttachmentTab> {
  //region variables


  //endregion

  //region events
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewCourierController>(
        init: NewCourierController(context),
        builder: (NewCourierController controller) {
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
                  const CourierAttachmentBody(),
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
        return const BottomSheetBody();
      },
    );
  }





//endregion

}

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({super.key});

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  var _pickedImage = File("");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewCourierController>(
      init: NewCourierController(context),
      builder: (NewCourierController controller) {
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
                                controller.pickFile();
                              },
                              child: SvgPicture.asset("assets/icons/Camera.svg",
                                  color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(20),
                  ),
                  CustomTextFormField(
                    hintText: 'Title',
                    controller: controller.titleController,
                    onPressed: () {},
                    onChange: () {},
                    onValidate: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomTextFormField(
                      hintText: 'Description',
                      controller: controller.descController,
                      textInputAction: TextInputAction.done,
                      onPressed: () {},
                      onChange: () {},
                      onValidate: () {}),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  CustomButton(
                    text: 'Create',
                    press: () async {
                      // Upload the selected file first
                      await controller.uploadSelectedFile(controller.descController.text);

                      // Create the new attachment
                      Attachment newAttachment = Attachment(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: controller.titleController.text,
                        description: controller.descController.text, image: 'assets/images/ps4_console_white_4.png',
                        // Add other properties like image if needed
                      );

                      // Add the new attachment to the demoAttachments list
                      demoCourierAttachments.add(newAttachment);

                      // Trigger the UI update
                      setState(() {});
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
