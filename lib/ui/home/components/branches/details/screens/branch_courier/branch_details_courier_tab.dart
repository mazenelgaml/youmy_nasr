import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_courier/components/branch_detail_courier_body.dart';
import '../../../controller/branches_controller.dart';
import 'components/branch_courier_data.dart';

class BranchDetailsCourierTab extends StatefulWidget {
  const BranchDetailsCourierTab({Key? key}) : super(key: key);


  @override
  State<BranchDetailsCourierTab> createState() => _BranchDetailsCourierTabState();
}

class _BranchDetailsCourierTabState extends State<BranchDetailsCourierTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return Body();});
  }
}



