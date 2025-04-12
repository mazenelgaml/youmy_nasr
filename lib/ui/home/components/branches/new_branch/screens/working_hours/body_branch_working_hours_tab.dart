import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/extensions.dart';
import 'package:merchant/util/size_config.dart';
import 'package:get/get.dart';
import '../../../../../../../components/custom_button.dart';
import '../../../../../../../components/custom_text_form_field.dart';
import '../../../../../../../components/form_error.dart';
import '../../../../../../../components/working_hour_card.dart';
import '../../../../../../../services/memory.dart';
import '../../../../../../../services/translation_key.dart';
import '../../../controller/new_branch_controller.dart';


class BranchWorkingHoursBody extends StatefulWidget {
  const BranchWorkingHoursBody({Key? key}) : super(key: key);

  @override
  _BranchWorkingHoursBodyState createState() => _BranchWorkingHoursBodyState();
}

class _BranchWorkingHoursBodyState extends State<BranchWorkingHoursBody> {




  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewBranchController(context),
        builder: (NewBranchController controller) {
          return Form(
      key: controller.formKey2,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(children: [
            Checkbox(
              value: controller.daily,
              activeColor: KPrimaryColor,
              onChanged: (value) {
                setState(() {
                  controller.daily = value!;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  //go to terms screen
                },
                child:  CustomText(text: dailyText.tr)),
          ]),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: fromText.tr,
                fontColor: KPrimaryColor,
              ),
              DropdownButton(
                iconSize: 40,
                value: controller.fromHour,
                items: controller.hoursList.map((int item) {
                  return DropdownMenuItem<int>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    controller.fromHour = int.parse(value.toString());
                  });
                },
              ),
               CustomText(
                text: timeText.tr,
                fontColor: KPrimaryColor,
              ),
               CustomText(
                text: toText.tr,
                fontColor: KPrimaryColor,
              ),
              DropdownButton(
                iconSize: 40,
                value:controller. toHour,
                items: controller.hoursList.map((int item) {
                  return DropdownMenuItem<int>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    controller.toHour = int.parse(value.toString());
                  });
                },
              ),
               CustomText(
                text: toTimeText.tr,
                fontColor: KPrimaryColor,
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               CustomText(
                text: exceptText.tr,
              ),
              SizedBox(
                  width: 36,
                  height: 36,
                  child: FloatingActionButton(
                    backgroundColor: KPrimaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () {},
                  ))
            ],
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  9,
                      (index) {
                    if (demoProducts[index].isActive) {
                      return WorkingHourCard(product: demoProducts[index]);
                    }
                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
          FormError(errors: controller.errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          CustomButton(
            text: continueText.tr,
            press: () async {
               if (controller.formKey2.currentState!.validate()) {
                 controller.formKey2.currentState!.save();
              await Get.find<CacheHelper>().saveData(key: "from", value: controller.fromHour);
              await Get.find<CacheHelper>().saveData(key: "to", value: controller.toHour);
              DefaultTabController.of(context)!.animateTo(2);
               }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );});
  }








}
