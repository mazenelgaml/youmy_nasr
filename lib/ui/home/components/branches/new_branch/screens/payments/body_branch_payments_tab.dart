import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/util/extensions.dart';

import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';

class BranchPaymentBody extends StatefulWidget {
  const BranchPaymentBody({Key? key}) : super(key: key);

  @override
  _BranchPaymentBodyState createState() => _BranchPaymentBodyState();
}

class _BranchPaymentBodyState extends State<BranchPaymentBody> {
  final _formKey = GlobalKey<FormState>();
  String? name, type, summary, address, workingHours, paymentTypes;
  bool cash= false,visa= false,credit = false;

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

          Row(children: [
            Checkbox(
              value: cash,
              activeColor: KPrimaryColor,
              onChanged: (value) {
                setState(() {
                  cash = value!;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  //go to terms screen
                },
                child: const CustomText(text: 'Cash ')),
          ]),
          Row(children: [
            Checkbox(
              value: visa,
              activeColor: KPrimaryColor,
              onChanged: (value) {
                setState(() {
                  visa = value!;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  //go to terms screen
                },
                child: const CustomText(text: 'Visa from home ')),
          ]),
          Row(children: [
            Checkbox(
              value: credit,
              activeColor: KPrimaryColor,
              onChanged: (value) {
                setState(() {
                  credit = value!;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  //go to terms screen
                },
                child: const CustomText(text: 'Credit Card ')),
          ]),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomText(
            text: 'Collection is by electronic payment',fontSize: 14,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomButton(
            text: "Continue",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();

                DefaultTabController.of(context)!.animateTo(4);
              // }
            },
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
