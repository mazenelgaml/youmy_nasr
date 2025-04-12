import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_comments/components/body.dart';

import '../../../controller/branches_controller.dart';

class BranchCommentsTab extends StatelessWidget {
  const BranchCommentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchesController(),
    builder: (BranchesController controller) {
    return Body();});
  }
}
