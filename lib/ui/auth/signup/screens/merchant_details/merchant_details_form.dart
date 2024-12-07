import 'package:flutter/material.dart';
import 'package:merchant/util/extensions.dart';

import '../../../../../components/colored_custom_text.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../components/form_error.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/keyboard.dart';
import '../../../../../util/size_config.dart';
import '../../../login/login_screen.dart';


class SignUpFormMerchantDetails extends StatefulWidget {
  const SignUpFormMerchantDetails({Key? key}) : super(key: key);

  @override
  _SignUpFormMerchantDetailsState createState() =>
      _SignUpFormMerchantDetailsState();
}

class _SignUpFormMerchantDetailsState extends State<SignUpFormMerchantDetails> {
  final _formKey = GlobalKey<FormState>();
  String? name, type, summary, address, workingHours, paymentTypes;
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          buildNameField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildTypeField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildSummaryField(),
          SizedBox(height: getProportionateScreenHeight(120)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              text:
                  'It is necessary to have your own delivery resources',
              align: Alignment.center,
              fontSize: 13,
              fontColor: Colors.grey,
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          CustomButton(
            text: "Next",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
                DefaultTabController.of(context)!.animateTo(2);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
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

          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  CustomTextFormField buildPaymentTypesField() {
    return CustomTextFormField(
        obscureText: true,
        hintText: 'Payment Types',
        textInputAction: TextInputAction.done,
        onPressed: (newValue) => paymentTypes = newValue,
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kMerchantPaymentTypesNullError);
          }
        },
        onValidate: (value) {
          if (value!.isEmpty) {
            addError(error: kMerchantPaymentTypesNullError);
            return "";
          }
          return null;
        });
  }

  CustomTextFormField buildWorkingHoursField() {
    return CustomTextFormField(
      onPressed: (value) {
        workingHours = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantWorkingHoursNullError);
        }
        return null;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantWorkingHoursNullError);
          return "";
        }
        return null;
      },
      hintText: 'Working Hours',
      textInputAction: TextInputAction.next,
    );
  }

  CustomTextFormField buildAddressField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Address',
      onPressed: (value) {
        address = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Merchant Name',
      onPressed: (value) {
        name = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMerchantNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildTypeField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Type',
      suffixIcon: const Icon(Icons.arrow_drop_down),
      onPressed: (value) {
        type = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantTypeNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMerchantTypeNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantTypeNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildSummaryField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Summary',
      onPressed: (value) {
        summary = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantSummaryNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMerchantSummaryNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantSummaryNullError);
        }
        return null;
      },
    );
  }
}
