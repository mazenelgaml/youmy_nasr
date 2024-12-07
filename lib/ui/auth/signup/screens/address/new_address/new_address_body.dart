import 'package:flutter/material.dart';

import '../../../../../../components/custom_button.dart';
import '../../../../../../components/custom_text.dart';
import '../../../../../../components/custom_text_form_field.dart';
import '../../../../../../components/form_error.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';
import '../../../../../home/home_screen.dart';

class SignUpFormNewAddress extends StatefulWidget {
  const SignUpFormNewAddress({Key? key}) : super(key: key);

  @override
  State<SignUpFormNewAddress> createState() => _SignUpFormNewAddressState();
}

class _SignUpFormNewAddressState extends State<SignUpFormNewAddress> {
  //region variables
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

  final _formKey = GlobalKey<FormState>();
  String? name, type, summary, address, workingHours, paymentTypes;
  bool cash = false, visa = false, credit = false;
  final List<String?> errors = [];
  var selectedCity = "Select City";
  var selectedRegion = "Select Region";

  //endregion

  //region helper functions

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
  CustomTextFormField buildLocationOnMapField() {
    return CustomTextFormField(
      hintText: 'Location on map',
      suffixIcon: const Icon(Icons.location_on),
      readOnly: true,
      onPressed: () {},
      onChange: () {},
      onValidate: () {},
    );
  }

  DropdownButton<String> buildCityField() {
    return DropdownButton(
      hint: const CustomText(
        text: 'Select City',
      ),
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
    );
  }

  DropdownButton<String> buildRegionField() {
    return DropdownButton(
      hint: const CustomText(
        text: 'Select Region',
      ),
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
    );
  }

  CustomTextFormField buildStreetField() {
    return CustomTextFormField(
        hintText: 'Street',
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }

  CustomTextFormField buildBuildingField() {
    return CustomTextFormField(
        hintText: 'Building',
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }

  CustomTextFormField buildFlatField() {
    return CustomTextFormField(
        hintText: 'FLat',
        textInputAction: TextInputAction.done,
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }

  CustomTextFormField buildFloorField() {
    return CustomTextFormField(
        hintText: 'Floor',
        textInputAction: TextInputAction.next,
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }

//endregion

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          buildLocationOnMapField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCityField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildRegionField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildStreetField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildBuildingField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildFloorField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildFlatField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomButton(
            text: "Finish",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const HomeScreen()),
                    (Route<dynamic> route) => false);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
        ],
      ),
    );
  }


}
