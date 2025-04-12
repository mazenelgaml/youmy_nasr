
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' ;
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:merchant/components/colored_custom_text.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/form_error.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/keyboard.dart';
import '../../../../../util/size_config.dart';
import '../../controller/signup_controller.dart';



class SignUpFormGeneralInformation extends StatefulWidget {
  const SignUpFormGeneralInformation({Key? key}) : super(key: key);

  @override
  _SignUpFormGeneralInformationState createState() =>
      _SignUpFormGeneralInformationState();
}

class _SignUpFormGeneralInformationState
    extends State<SignUpFormGeneralInformation> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(context),
    builder: (SignupController controller) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey1,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.01),
            SizedBox(
              height: 88,
              width: 88,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:controller.getImage(controller.pickedImage),
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
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.buildNameField(),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.buildEmailField(),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.buildMobileField(),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.buildJobField(context),
            Divider(
              color: Colors.black,  // Color of the divider line
              thickness: 1,         // Thickness of the divider
              indent: 3,           // Space from the left edge
              endIndent: 3,        // Space from the right edge
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.isLoading?Center(child: CircularProgressIndicator()):DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'الفروع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              items: controller.branchesLogin
                  ?.map((branch) => DropdownMenuItem<String>(
                value: branch,
                child: Text(branch),
              ))
                  .toList(),
              onChanged: (value) {
                controller.selectedBranch = value!;
              },
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.buildPasswordField(),
            SizedBox(height: getProportionateScreenHeight(5)),
            controller.buildConfirmPasswordField(),
            SizedBox(height: getProportionateScreenHeight(5)),
            Row(children: [
              Checkbox(
                value: controller.remember,
                activeColor: KPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    controller.remember = value!;
                  });
                },
              ),
              GestureDetector(
                  onTap: () {
      
                  },
                  child:  CustomRichText(
                      text1: iAgreeTo.tr, text2: termsAndPrivacyPolicy.tr)),
            ]),
            FormError(errors: controller.errors),
            SizedBox(height: getProportionateScreenHeight(5)),
            CustomButton(
              text: next.tr,
              press: () {
                if (controller.formKey1.currentState!.validate()) {
                  controller.formKey1.currentState!.save();
                controller.signUp(context);
      
                 }
              },
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
              child:  CustomRichText(
                align: Alignment.center,
                text1: haveAnAccount.tr,
                text2: signInTextBTN.tr,
              ),
            )
            , SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );});
  }

}
