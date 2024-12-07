import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/extensions.dart';
import 'package:merchant/util/size_config.dart';

import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../components/working_hour_card.dart';


class BranchWorkingHoursBody extends StatefulWidget {
  const BranchWorkingHoursBody({Key? key}) : super(key: key);

  @override
  _BranchWorkingHoursBodyState createState() => _BranchWorkingHoursBodyState();
}

class _BranchWorkingHoursBodyState extends State<BranchWorkingHoursBody> {
  final _formKey = GlobalKey<FormState>();
  String? name, type, summary, address, workingHours, paymentTypes;
  bool daily = false;
  final List<String?> errors = [];
  final List<int> hoursList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  int fromHour = 1, toHour = 1;

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
              value: daily,
              activeColor: KPrimaryColor,
              onChanged: (value) {
                setState(() {
                  daily = value!;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  //go to terms screen
                },
                child: const CustomText(text: 'Daily ')),
          ]),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'From',
                fontColor: KPrimaryColor,
              ),
              DropdownButton(
                iconSize: 40,
                value: fromHour,
                items: hoursList.map((int item) {
                  return DropdownMenuItem<int>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fromHour = int.parse(value.toString());
                  });
                },
              ),
              const CustomText(
                text: 'AM',
                fontColor: KPrimaryColor,
              ),
              const CustomText(
                text: 'To',
                fontColor: KPrimaryColor,
              ),
              DropdownButton(
                iconSize: 40,
                value: toHour,
                items: hoursList.map((int item) {
                  return DropdownMenuItem<int>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    toHour = int.parse(value.toString());
                  });
                },
              ),
              const CustomText(
                text: 'PM',
                fontColor: KPrimaryColor,
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Except',
              ),
              SizedBox(
                  width: 36,
                  height: 36,
                  child: FloatingActionButton(
                    backgroundColor: KPrimaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () {},
                  ))
            ],
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  demoProducts.length,
                      (index) {
                    if (demoProducts[index].isActive) {
                      return WorkingHourCard(product: demoProducts[index]);
                    }
                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          CustomButton(
            text: "Continue",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
                DefaultTabController.of(context)!.animateTo(3);
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
