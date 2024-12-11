import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  // Add a flag to ensure init is called
  static bool isInitialized = false;

  void init(BuildContext context) {
    if (isInitialized) return; // Prevent reinitialization
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    isInitialized = true;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  if (!SizeConfig.isInitialized) {
    throw Exception('SizeConfig is not initialized. Call SizeConfig().init(context) first.');
  }
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  if (!SizeConfig.isInitialized) {
    throw Exception('SizeConfig is not initialized. Call SizeConfig().init(context) first.');
  }
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
