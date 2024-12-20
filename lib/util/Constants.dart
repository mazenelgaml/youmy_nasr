import 'dart:ui';
import 'package:flutter/material.dart';
import 'size_config.dart';

const KPrimaryColor = Color(0xFF68C5DE);
const KOpacityPrimaryColor = Color(0xFFE6F6FA);
const KHintColor = Color(0xFFC4C4C4);
const accentColor = Color(0xFFF2BC41);
const kPrimaryLightColor = Color(0xFFFFECDF);
const inActiveIconColor =  Color(0xFFB6B6B6);
const KBackColor=Color(0XFFFAFAFA);
const KBackground=Color(0xFFF5F6F9);
const KActiveColor=Color(0xFF00FF00);
const KInActiveColor=Color(0xFFFF0000);
const KChipColor=Color(0xFF1976D2);
const KChipBackColor=Color(0xFFDCDCDC);
//
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const tabBarStyle =  TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Roboto Regular',
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kConfirmPassNullError = "Please Enter confirm password";
const String kConfirmShortPassError = "Confirm password is too short";
const String kConfirmMatchPassError = "Passwords don't match";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kMobileNullError = "Please Enter your mobile";
const String kJobNullError = "Please Enter your job";
const String kMerchantNameNullError = "Please Enter merchant name";
const String kMerchantTypeNullError = "Please choose type";
const String kMerchantSummaryNullError = "Please enter summary";
const String kMerchantWorkingHoursNullError = "Please enter working hours ";
const String kMerchantPaymentTypesNullError = "Please choose payment types ";
const String kEPersonalAccountNameNullError = "Please Enter Personal Account Name";
const String kEBankNameNullError = "Please Enter Bank Name";
const String kEBranchNameNullError = "Please Enter Branch Name";
const String kEAccountOwnerNullError = "Please Enter Account Owner";
const String kPProductNameNullError = "Please Enter Product Name";
const String kPOfferNameNullError = "Please Enter Offer Name";
const String kPFactoryNameNullError = "Please Enter Factory Name";
const String kPDescriptionNullError = "Please Enter Description";
const String kPUOMNameNullError = "Please Enter Unit of Measure";
const String kPPriceNullError = "Please Enter Price";
const String kPPriceAfterDiscountNullError = "Please Enter Price after Didcount";
const String baseUrl= "http://webapi.sudokuano.com/api";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
