import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/ui/home/components/branches/new_branch/screens/delivery_fees/components/Body.dart';

import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';

class BranchDeliveryFeesTab extends StatefulWidget {
  const BranchDeliveryFeesTab({Key? key}) : super(key: key);

  @override
  State<BranchDeliveryFeesTab> createState() => _BranchDeliveryFeesTabState();
}

class _BranchDeliveryFeesTabState extends State<BranchDeliveryFeesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  const CustomText(
                    text: 'Delivery Fees',
                    align: Alignment.center,
                    fontColor: KPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                  const Body(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          showCreateNewAttachmentView(context);
        },
        child: const Icon(
          Icons.add,
          size: 29,
        ),
      ),
    );
  }

  //region helper functions
  void showCreateNewAttachmentView(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetBody();
      },
    );
  }


//endregion
}

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({Key? key}) : super(key: key);

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              const CustomText(
                text: 'New Delivery Fees',
                align: Alignment.center,
                fontColor: KPrimaryColor,
                fontSize: 23,
              ),
              SizedBox(height: getProportionateScreenWidth(20))
              ,
              CustomTextFormField(
                hintText: 'From',
                textInputType: TextInputType.number,
                onPressed: () {},
                onChange: () {},
                onValidate: () {},
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              CustomTextFormField(
                  hintText: 'To',
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onPressed: () {},
                  onChange: () {},
                  onValidate: () {}),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomTextFormField(
                  hintText: 'Cost',
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onPressed: () {},
                  onChange: () {},
                  onValidate: () {}),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomButton(
                text: 'Create',
                press: () => {Navigator.pop(context)},
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
            ],
          ),
        ),
      ),
    );
  }

}

