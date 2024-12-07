import 'package:country_code_picker/country_code_picker.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/ui/auth/confirm_verification/confirm_verification_screen.dart';
import 'package:merchant/util/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_button.dart';
import '../../../../util/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            margin:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/mobile.png'),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const CustomText(
                        text:
                            'Enter your phone number to receive\nverification code ',
                        fontSize: 16,
                        fontFamily: 'Roboto Bold',
                        fontColor: KPrimaryColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryCodePicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'EG',
                favorite: const ['+02', 'EG'],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ),
              SizedBox(
                height: 18,
                width: 2,
                child: Container(
                  color: KPrimaryColor,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 20),
                  child: CustomTextFormField(
                    hintText: 'Phone No',
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onValidate: () {},
                    onPressed: () {},
                    onChange: (value) {},
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: getProportionateScreenHeight(60)),
          Container(
            margin:
                const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
            child: CustomButton(
              text: "Send",
              press: () {
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.popAndPushNamed(
                    context, ConfirmVerificationScreen.routeName);
              },
            ),

          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }
}
