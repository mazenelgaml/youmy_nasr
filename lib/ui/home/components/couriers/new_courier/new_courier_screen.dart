import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/address/courier_address_tab.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/attachments/attachments_screen.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/attachments/body_attachment.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/personal_information/courier_personal_information_tab.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/screens/vehicle/courier_vehicle_information_tab.dart';

import '../../../../../util/Constants.dart';

class NewCourierScreen extends StatefulWidget {
  static String routeName = "/new_Courier";

  const NewCourierScreen({Key? key}) : super(key: key);

  @override
  State<NewCourierScreen> createState() => _NewCourierScreenState();
}

class _NewCourierScreenState extends State<NewCourierScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const CustomText(text: 'New Courier',fontColor: KPrimaryColor,),
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
            bottom: const TabBar(
              labelStyle:tabBarStyle,
              labelColor: KPrimaryColor,
              tabs: [
                Tab( //personal information
                  icon: Icon(Icons.manage_accounts,size:40,),
                ),
                Tab(//vehicle details
                  icon: Icon(Icons.car_rental,size:40,),
                ),
                Tab(//attachments
                  icon: Icon(Icons.list_alt,size:40,),
                ),
                Tab(//addresses
                  icon: Icon(Icons.location_on,size:40,),
                ),
              ],
            )),
        body: const TabBarView(
          children: [

           PersonalInformationTab(),
            VehicleInformationTab(),
            CourierAttachmentTab(),
           CourierAddressTab()

          ],
        ),
      ),
    );
  }
}


