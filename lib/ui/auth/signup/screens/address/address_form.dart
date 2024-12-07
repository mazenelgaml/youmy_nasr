import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../components/address_card.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../components/form_error.dart';
import '../../../../../components/working_hour_card.dart';
import '../../../../../data/model/Product.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../../../home/home_screen.dart';

class SignUpFormAddress extends StatefulWidget {
  const SignUpFormAddress({Key? key}) : super(key: key);

  @override
  _SignUpFormAddressState createState() => _SignUpFormAddressState();
}

class _SignUpFormAddressState extends State<SignUpFormAddress> {
  final _formKey = GlobalKey<FormState>();
  String? name, type, summary, address, workingHours, paymentTypes;
  bool cash= false,visa= false,credit = false;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...List.generate(
                  demoProducts.length,
                      (index) {
                    if (demoProducts[index].isActive) {
                      return AddressCard(product: demoProducts[index]);
                    }
                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),

              ],
            ),
          ),
          FormError(errors: errors),


        ],
      ),
    );

  }

}
