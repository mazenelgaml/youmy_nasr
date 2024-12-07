import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/components/colored_custom_text.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../components/form_error.dart';
import '../../../../../components/profile_image_widget.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/keyboard.dart';
import '../../../../../util/size_config.dart';

class SignUpFormGeneralInformation extends StatefulWidget {
  const SignUpFormGeneralInformation({Key? key}) : super(key: key);

  @override
  _SignUpFormGeneralInformationState createState() =>
      _SignUpFormGeneralInformationState();
}

class _SignUpFormGeneralInformationState
    extends State<SignUpFormGeneralInformation> {
  final _formKey = GlobalKey<FormState>();
  var _pickedImage = File("");
  String? email, name, mobile, job, password, confirmPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.02),
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
          SizedBox(height: getProportionateScreenHeight(5)),
          buildNameField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildEmailField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildMobileField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildJobField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildConfirmPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(children: [
            Checkbox(
              value: remember,
              activeColor: KPrimaryColor,
              onChanged: (value) {
                setState(() {
                  remember = value!;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  //go to terms screen
                },
                child: const CustomRichText(
                    text1: 'I agree to ', text2: "Terms & Privacy Policy")),
          ]),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(16)),
          CustomButton(
            text: "Next",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              DefaultTabController.of(context)!.animateTo(1);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              Navigator.popAndPushNamed(context, LoginScreen.routeName);
            },
            child: const CustomRichText(
              align: Alignment.center,
              text1: 'Have an account?',
              text2: ' Login',
            ),
          )
          , SizedBox(height: getProportionateScreenHeight(30)),
        ],
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
      onPressed: (value) {
        password = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
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
      hintText: 'Password',
      textInputType: TextInputType.visiblePassword,
      suffixIcon: const Icon(Icons.visibility_off),
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      textInputType: TextInputType.emailAddress,
      hintText: 'Email',
      onPressed: (value) {
        email = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!value.toString().isValidEmail()) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Name',
      onPressed: (value) {
        name = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildMobileField() {
    return CustomTextFormField(
      textInputType: TextInputType.phone,
      hintText: 'Mobile No',
      onPressed: (value) {
        mobile = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kMobileNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileNullError);
        }
        return null;
      },
    );
  }


  CustomTextFormField buildJobField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Job',
      suffixIcon: const Icon(Icons.arrow_drop_down),
      onPressed: (value) {
        job = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kJobNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kJobNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kJobNullError);
        }
        return null;
      },
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
}
