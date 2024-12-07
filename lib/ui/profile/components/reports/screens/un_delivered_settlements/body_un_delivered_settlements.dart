import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/ui/profile/components/reports/components/card_widget.dart';
import 'package:merchant/ui/profile/components/reports/components/card_widget_content.dart';
import 'package:merchant/util/Constants.dart';

import '../../../../../../components/custom_button.dart';
import '../../../../../../components/custom_text_form_field.dart';
import '../../../../../../util/size_config.dart';
import '../../components/branch_filter_widget.dart';

class BodyUnDeliveredSettlements extends StatefulWidget {
  const BodyUnDeliveredSettlements({Key? key}) : super(key: key);

  @override
  State<BodyUnDeliveredSettlements> createState() =>
      _BodyUnDeliveredSettlementsState();
}

class _BodyUnDeliveredSettlementsState
    extends State<BodyUnDeliveredSettlements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CustomText(
                  text: "Last Settlements Date",
                  fontSize: 18,
                  fontColor: KPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: "10 April 2022",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            CardWidget(
              cardChild: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(20)),
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "Branch Name",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "Maadi Branch",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "Order #",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "5741201",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "My Settlements",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "1500 LE",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "App Settlements",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "1300 LE",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "Total",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "2800 LE",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "Branch Name",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "Order No",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomText(
                          text: "Branch Name",
                          fontSize: 18,
                          fontColor: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "Order No",
                          fontSize: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                  ],
                ),
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          showFilterScreen(context);
        },
        child: const Icon(
          Icons.filter_alt,
          size: 29,
        ),
      ),
    );
  }

  void showFilterScreen(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetBody();
      },
    );
  }
}

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({Key? key}) : super(key: key);

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  bool cash = false,
      visa = false,
      credit = false;
  String? name, type, summary, address, workingHours, paymentTypes;
  final List<String?> errors = [];
  String
  _birthDateInString = 'Birth Date';
  DateTime? _birthDate;


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
    return Padding(
      padding: EdgeInsets.all(
        getProportionateScreenWidth(20),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: getProportionateScreenWidth(5),
              ),
              const CustomText(
                text: 'Branches',
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontSize: 23,
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              // SizedBox(
              //   height: getProportionateScreenHeight(100),
              //   child: GridView.count(
              //     crossAxisCount: 4,
              //     children: [
              //       ...List.generate(
              //         demoBranches.length,
              //         (index) {
              //           return BranchFilterWidget(
              //             branch: demoBranches[index],
              //             onPress: () {},
              //           ); // here by default width and height is 0
              //         },
              //       ),
              //       SizedBox(width: getProportionateScreenWidth(20)),
              //     ],
              //   ),
              // ),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  "All",
                  "Maadi",
                  "Helwan",
                  "Tahrir",
                  "H-Kopa",
                  "New Cairo",

                ]
                    .map((String name) =>
                    Chip(
                      avatar: CircleAvatar(
                        child: Text(name.substring(0, 1)),
                      ),
                      label: Text(
                        name,
                      ),
                    ))
                    .toList(),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              const CustomText(
                text: 'Payment Types',
                align: Alignment.topLeft,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
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
              const CustomText(
                text: 'Settlement Date',
                align: Alignment.topLeft,
                fontColor: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              buildBirthDateField('From'),
              SizedBox(height: getProportionateScreenHeight(20)),
              buildBirthDateField('To'),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomButton(
                text: "Confirm",
                press: () {
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();

                  Navigator.pop(context);
                  // }
                },
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
            ],
          ),
        ),
      ),
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
}
