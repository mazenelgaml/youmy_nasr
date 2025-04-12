import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/ui/home/components/branches/controller/new_branch_controller.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../services/translation_key.dart';
import '../../../../../../../util/Constants.dart';
import '../../../../../../../util/size_config.dart';

class BranchPaymentBody extends StatefulWidget {
  const BranchPaymentBody({Key? key}) : super(key: key);

  @override
  _BranchPaymentBodyState createState() => _BranchPaymentBodyState();
}

class _BranchPaymentBodyState extends State<BranchPaymentBody> {
  final _formKey = GlobalKey<FormState>();

  // Function to track selected payments dynamically
  void trackSelectedPayments(NewBranchController controller) {
    List<String> selectedPayments = controller.selectedPaymentMethods
        .entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    // You can use this list as needed
    print("Currently Selected Payment Methods: $selectedPayments");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewBranchController>(
      init: NewBranchController(context),
      builder: (controller) {
        return Form(
          key: controller.formKey3,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),

              // Dynamically create payment method checkboxes from controller
              Obx(() {
                return Column(
                  children: controller.selectPayment.map((paymentMethod) {
                    return Row(
                      children: [
                        Checkbox(
                          value: controller.selectedPaymentMethods[paymentMethod] ?? false,
                          activeColor: KPrimaryColor,
                          onChanged: (value) {
                            controller.togglePaymentMethod(paymentMethod);

                            // Track selected payments immediately after toggling
                            trackSelectedPayments(controller);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle tap action if needed
                          },
                          child: CustomText(text: paymentMethod),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),

              SizedBox(height: getProportionateScreenHeight(20)),
              CustomText(
                text: electronicPayment.tr,
                fontSize: 14,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              CustomButton(
                text: continueText.tr,
                press: () {
                  // Gather selected payment methods when the button is pressed
                   controller.selectedPayments = controller.selectedPaymentMethods
                      .entries
                      .where((entry) => entry.value == true)
                      .map((entry) => entry.key)
                      .toList();

                  // Use the selected payment methods here
                  print("Selected Payment Methods on button press: ${controller.selectedPayments}");

                  // Optionally show a message or use the selected payments elsewhere
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selected Payment Methods: ${controller.selectedPayments}")),

                  );DefaultTabController.of(context).animateTo(4);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
            ],
          ),
        );
      },
    );
  }
}