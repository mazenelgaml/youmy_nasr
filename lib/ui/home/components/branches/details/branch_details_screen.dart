import 'package:flutter/material.dart';
import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_comments/branch_comments_tab.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_courier/branch_details_courier_tab.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_offers/branch_offers_body.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_products/branch_product_tab.dart';
import 'package:merchant/ui/home/components/branches/details/screens/general_details/general_details_tab.dart';
import 'package:merchant/util/Constants.dart';

import '../../product/offers/offers_body.dart';


class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({Key? key}) : super(key: key);
  static String routeName = "branch_details";

  @override
  Widget build(BuildContext context) {
    final BranchDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as BranchDetailsArguments;
    // return Scaffold(
    //   backgroundColor: KBackground,
    //   body: Body(branch: agrs.branch),
    // );
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: null,
            backgroundColor: Colors.white,
            bottom: const TabBar(
              labelStyle:tabBarStyle,
              labelColor: KPrimaryColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.store,size:40,),

                ),
                Tab(
                  icon:  Icon(
                    Icons.group,
                    size:40,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.apps,size:40,),
                ),
                Tab(
                  icon: Icon(
                    Icons.local_offer_outlined,
                    size: 40,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.comment,
                    size: 40,
                  ),
                ),

              ],
            )),
        body:  TabBarView(
          children: [
            BranchGeneralDetailsTab(branch: args.branch),
            BranchDetailsCourierTab(),
            BranchProductsScreen(),
            BranchOffersBody(),
            BranchCommentsTab(),
          ],
        ),
      ),
    );
  }
}

class BranchDetailsArguments {
  final Branch branch;

  BranchDetailsArguments({required this.branch});
}
