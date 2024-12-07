import 'package:flutter/material.dart';
import 'package:merchant/components/form_error.dart';
import 'package:merchant/util/keyboard.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables
  final String TAG = "Add Bank Account ";
  String? accountOwnerName, bankName, branchName, accountOwner;
  final _formKey = GlobalKey<FormState>();

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

  CustomTextFormField buildAccountOwnerNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Account Owner Name',
      onPressed: (value) {
        accountOwnerName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEPersonalAccountNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEPersonalAccountNameNullError);
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

  CustomTextFormField buildBankNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Bank Name',
      onPressed: (value) {
        bankName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEBankNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEBankNameNullError);
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

  CustomTextFormField buildBranchNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Branch Name',
      onPressed: (value) {
        branchName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEBranchNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEBranchNameNullError);
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

  CustomTextFormField buildAccountOwnerField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Account Owner',
      onPressed: (value) {
        accountOwner = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kEAccountOwnerNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kEAccountOwnerNullError);
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

//endregion

  //region events
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const CustomText(
                      text: 'Add Bank Account',
                      fontSize: 25,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildAccountOwnerNameField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildBankNameField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildBranchNameField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildAccountOwnerField(),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    FormError(errors: errors),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    CustomButton(
                      text: "Save",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//endregion

}
