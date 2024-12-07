import 'package:flutter/material.dart';
import 'package:merchant/ui/profile/components/bank_account/components/body.dart';

import '../../../../util/size_config.dart';


class BankAccountScreen extends StatelessWidget {
  static var routeName = "/bank_account";

  const BankAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: Body(),
    );
  }
}
