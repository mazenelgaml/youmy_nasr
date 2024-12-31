import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:merchant/util/Constants.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../util/size_config.dart';
import '../../../../services/translation_key.dart';
import 'controller/update_courier_controller.dart';





class UpdateCourier extends StatefulWidget {
  final int courierId;
  const UpdateCourier({Key? key, required this.courierId}) : super(key: key);

  @override
  _UpdateCourierState createState() =>
      _UpdateCourierState();
}

class _UpdateCourierState extends State<UpdateCourier> {




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: UpdateCourierController(context),
    builder: (UpdateCourierController controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(updateCourier.tr),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),
              SizedBox(
                height: 88,
                width: 88,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: controller.getImage(controller.pickedImage),
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
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: controller.pickImage,
                          child: SvgPicture.asset("assets/icons/Camera.svg",
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
    controller.buildNameARField(),
              SizedBox(height: getProportionateScreenHeight(15)),
    controller.buildNameENField(),
              SizedBox(height: getProportionateScreenHeight(15)),
    controller.buildMobileField(),
              SizedBox(height: getProportionateScreenHeight(15)),
              controller.buildAddressField(),
              SizedBox(height: getProportionateScreenHeight(15)),
              controller.buildEmailField(),
              SizedBox(height: getProportionateScreenHeight(15)),
    controller.buildPasswordField(),
              SizedBox(height: getProportionateScreenHeight(15)),
              FormError(errors: controller.errors),
              SizedBox(height: getProportionateScreenHeight(25)),
              CustomButton(
                text: submit.tr,
                press: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.updateCourier(context, widget.courierId);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
        });
  }
}
