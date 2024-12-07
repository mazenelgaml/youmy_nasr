import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/ui/auth/confirm_verification/confirm_verification_screen.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/form_error.dart';
import '../../../../util/keyboard.dart';
import '../../../../util/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables
  final String TAG = "LOG IN: ";

  final _formKey = GlobalKey<FormState>();

  String? password;

  String? confirmPassword;

  List<String?> errors = [];

//endregion

  //region helper functions
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      color: KOpacityPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
                Image.asset(
                  'assets/images/trans.png',
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 40),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const CustomText(
                    text: 'Password Reset',
                    fontSize: 25,
                    fontColor: KPrimaryColor,
                    fontFamily: 'Roboto Bold',
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  buildPasswordField(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  buildConfirmPasswordField(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomButton(
                    text: "Confirm",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.popAndPushNamed(
                            context, ConfirmVerificationScreen.routeName);
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
        obscureText: true,
        textInputType: TextInputType.visiblePassword,
        hintText: 'Confirm Password',
        textInputAction: TextInputAction.done,
        suffixIcon: const Icon(Icons.visibility_off),
        onPressed: (newValue) => confirmPassword = newValue,
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kConfirmPassNullError);
          } else if (value.isNotEmpty && password == confirmPassword) {
            removeError(error: kMatchPassError);
          }
          confirmPassword = value;
        },
        onValidate: (value) {
          if (value!.isEmpty) {
            addError(error: kConfirmPassNullError);
            return "";
          } else if ((password != value)) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        });
  }

  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      obscureText: true,
      hintText: 'Password',
      textInputType: TextInputType.visiblePassword,
      suffixIcon: const Icon(Icons.visibility_off),
      onPressed: (newValue) => password = newValue,
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }

        return null;
      },
    );
  }
}
