import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/address/branch_address_tab.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/branch_details/body_branch_details_tab.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/branch_details/branch_details_tab.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/delivery_fees/branch_dlivery_screen.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/payments/body_branch_payments_tab.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/payments/branch_payments_tab.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/working_hours/body_branch_working_hours_tab.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/working_hours/branch_working_hours_tab.dart';
import '../../../../../util/Constants.dart';

class NewBranchScreen extends StatefulWidget {
  static var routeName = "/new_branch";

  const NewBranchScreen({Key? key}) : super(key: key);

  @override
  State<NewBranchScreen> createState() => _NewBranchScreenState();
}

class _NewBranchScreenState extends State<NewBranchScreen> {
  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
            bottom: const TabBar(
              labelStyle:tabBarStyle,
              labelColor: KPrimaryColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.store,size:40,),

                ),
                Tab(
                  icon: Icon(Icons.timer,size:40,),
                ),
                Tab(
                  icon: Icon(Icons.credit_card,size:40,),
                ),
                Tab(
                  icon: Icon(
                    Icons.delivery_dining,
                    size: 40,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.location_on,size:40,),
                ),
              ],
            )),
        body: const TabBarView(
          children: [
            BranchDetailsTab(),
            BranchWorkingHoursTab(),
            BranchPaymentTab(),
            BranchDeliveryFeesTab(),
            BranchAddressTab(),
          ],
        ),
      ),
    );
  }
}
