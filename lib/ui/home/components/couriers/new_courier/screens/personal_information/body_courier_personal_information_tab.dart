import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../components/profile_image_widget.dart';
import '../../../../../../../services/translation_key.dart';
import '../../../../../../../util/size_config.dart';

final List<String> vehicleTypes = [
  selectVehicleF.tr,
  carF.tr,
  motorBikeF.tr,
  bikeF.tr,
  otherF.tr
];


var selectedType = vehicleTypes.first;

class PersonalInformationBody extends StatefulWidget {
  const PersonalInformationBody({Key? key}) : super(key: key);

  @override
  _PersonalInformationBodyState createState() =>
      _PersonalInformationBodyState();
}

class _PersonalInformationBodyState extends State<PersonalInformationBody> {
  final _formKey = GlobalKey<FormState>();
  var _pickedImage = File("");
  String? email, name, mobile, job, password, confirmPassword;
  bool remember = false;
  String _birthDateInString = newCourierBirtDate.tr;
  DateTime? _birthDate;
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
          SizedBox(height: getProportionateScreenHeight(10)),
          buildNameARField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildNameENField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildMobileField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildBirthDateField(_birthDateInString),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildVehicleTypeField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildConfirmPasswordField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomButton(
            text: next.tr,
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              DefaultTabController.of(context)!.animateTo(1);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
        ],
      ),
    );
  }

  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
        obscureText: true,
        textInputType: TextInputType.visiblePassword,
        hintText: signUpConfirmPassword.tr,
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
      hintText: signUpPassword.tr,
      textInputType: TextInputType.visiblePassword,
      suffixIcon: const Icon(Icons.visibility_off),
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      textInputType: TextInputType.emailAddress,
      hintText: signInTextEmail.tr,
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

  CustomTextFormField buildNameARField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: newCourierNameArabic.tr,
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

  CustomTextFormField buildNameENField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: newCourierNameEnglish.tr,
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

  Widget buildBirthDateField(String hintText) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        CustomTextFormField(
          readOnly: true,
          suffixIcon: const Icon(Icons.calendar_today),
          textInputType: TextInputType.text,
          hintText: hintText,
          onPressed: () {},
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
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xfff96800)),
          onPressed: () async {
            final datePick = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            if (datePick != null && datePick != _birthDate) {
              setState(() {
                _birthDate = datePick;
                // isDateSelected=true;
                print('MAIN- $_birthDateInString');
                // put it here
                _birthDateInString =
                "${_birthDate?.month}/${_birthDate?.day}/${_birthDate
                    ?.year}"; // 08/14/2019
              });
            }

            // Your codes...
          },
        ),
      ],
    );
  }

  CustomTextFormField buildMobileField() {
    return CustomTextFormField(
      textInputType: TextInputType.phone,
      hintText: mobileNO.tr,
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

  DropdownButton<String> buildVehicleTypeField() {
    return DropdownButton(
      hint:  CustomText(
        text: newCourierSelectVehicle.tr,
      ),
      iconSize: 40,
      isExpanded: true,
      value: selectedType,
      items: vehicleTypes.map((String type) {
        return DropdownMenuItem<String>(
          child: Text(type),
          value: type,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedType = value.toString();
        });
      },
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
