import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../services/memory.dart';
import '../../../../../../../services/translation_key.dart';
import '../../../../../../../util/size_config.dart';
import '../../../controller/new_courier_controller.dart';





class PersonalInformationBody extends StatefulWidget {
  const PersonalInformationBody({Key? key}) : super(key: key);

  @override
  _PersonalInformationBodyState createState() =>
      _PersonalInformationBodyState();
}

class _PersonalInformationBodyState extends State<PersonalInformationBody> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewCourierController(context),
        builder: (NewCourierController controller) {
          return Form(
      key: controller.formKey,
      child: Column(
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
                  backgroundColor: Colors.grey,
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
                        disabledBackgroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        controller.pickImage();
                      },
                      child: SvgPicture.asset("assets/icons/Camera.svg",
                          color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildNameARField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildNameENField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildMobileField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildBirthDateField(controller.birthDateInString),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildVehicleTypeField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildEmailField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          controller.buildPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: controller.errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomButton(
            text: next.tr,
            press: () async{
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              await Get.find<CacheHelper>().saveData(key: "courierNameAra", value: controller.courierNameAraController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "courierNameEng", value: controller.courierNameEngController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "courierPhoneNo", value: controller.mobileNumberController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "courierEmail", value: controller.emailController.text.trim());
              await Get.find<CacheHelper>().saveData(key: "courierPassword", value: controller.passwordController.text.trim());
              DefaultTabController.of(context)!.animateTo(1);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
        ],
      ),
    );});
  }

}
