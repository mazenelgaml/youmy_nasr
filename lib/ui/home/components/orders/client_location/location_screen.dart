import 'package:flutter/material.dart';

import '../../../../../components/custom_text.dart';
import '../../../../../util/Constants.dart';

class LocationScreen extends StatefulWidget {
  static String routeName = "/location_screen";

  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const CustomText(
          text: 'Client Location',
          align: Alignment.center,
          fontColor: KPrimaryColor,
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: CustomText(text: 'Map will appear here',align: Alignment.center,),
    );
  }
}
