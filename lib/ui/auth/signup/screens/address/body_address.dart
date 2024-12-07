import 'package:flutter/material.dart';
import 'package:merchant/components/custom_button.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/ui/auth/signup/screens/address/address_form.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../../../home/home_screen.dart';

final List<String> cities = [
  "Select City",
  "Cairo",
  "Alexandria",
  "Luxor",
  "Sharkia",
  "Marsa Matrouh",
  "Suiez",
  "Phayioum"
];

final List<String> regions = [
  "Select Region",
  "Maddi",
  "Tahrir",
  "Down Town",
  "5th Setellment",
  "Aobour",
  "Nasr City",
  "Hadayek Helwan"
];
var selectedCity = cities.first;
var selectedRegion = regions.first;

class BodyAddress extends StatefulWidget {
  const BodyAddress({Key? key}) : super(key: key);

  @override
  State<BodyAddress> createState() => _BodyAddressState();
}

class _BodyAddressState extends State<BodyAddress> {
  //region variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  const CustomText(
                    text: 'Addresses',
                    align: Alignment.center,
                    fontColor: KPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                  const SignUpFormAddress(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateNewAddressView(context);
        },
        child: const Icon(Icons.add_location),
      ),
    );
  }

  //endregion
  void showCreateNewAddressView(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        topLeft:  Radius.circular(20.0), topRight: Radius.circular(20.0),
      )),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20),vertical: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: getProportionateScreenWidth(20),
                  ),
                  const CustomText(
                    text: 'New Address',
                    align: Alignment.center,
                    fontColor: KPrimaryColor,
                    fontSize: 23,
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(20),
                  ),
                  CustomTextFormField(
                    hintText: 'Location on map',
                    suffixIcon: const Icon(Icons.location_on),
                    readOnly: true,
                    onPressed: () {},
                    onChange: () {},
                    onValidate: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DropdownButton(
                    hint: const CustomText(text: 'Select City',),
                    iconSize: 40,
                    isExpanded: true,
                    value: selectedCity,
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        child: Text(city),
                        value: city,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DropdownButton(
                    hint: const CustomText(text: 'Select Region',),
                    iconSize: 40,
                    isExpanded: true,
                    value: selectedRegion,
                    items: regions.map((String region) {
                      return DropdownMenuItem<String>(
                        child: Text(region),
                        value: region,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRegion = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                 CustomTextFormField(hintText: 'Street', onPressed: (){}, onChange: (){}, onValidate: (){}),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomTextFormField(hintText: 'Building', onPressed: (){}, onChange: (){}, onValidate: (){}),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomTextFormField(hintText: 'FLat', onPressed: (){}, onChange: (){}, onValidate: (){}),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomTextFormField(hintText: 'Floor',textInputAction: TextInputAction.done, onPressed: (){}, onChange: (){}, onValidate: (){}),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  CustomButton(
                    text: 'Create',
                    press: () => {
                    Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen()),
                    (Route<dynamic> route) => false)
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
