import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/components/custom_button.dart';
import 'package:merchant/ui/home/components/branches/controller/new_branch_controller.dart';
import 'package:merchant/util/Constants.dart';
import 'package:merchant/util/size_config.dart';
import 'custom_text.dart';

import '../data/model/Product.dart';
import '../details/details_screen.dart';
import '../ui/home/components/branches/controller/new_branch_controller.dart';
class WorkingHourCard extends StatefulWidget {
  const WorkingHourCard({
    Key? key,
    this.width = 250,
    this.height = 60,
    this.aspectRatio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, height, aspectRatio;
  final Product product;

  @override
  State<WorkingHourCard> createState() => _WorkingHourCardState();
}

class _WorkingHourCardState extends State<WorkingHourCard> {
  bool isClosed = false;
  final List<int> hoursList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int fromHour = 1, toHour = 1;
  String selectedDay = "Monday"; // Default day

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewBranchController>(
      init: NewBranchController(context),
      builder: (NewBranchController controller) {
        // Ensure selectDay list is unique
        controller.selectDay = controller.selectDay.toSet().toList();

        // Ensure that selectedDay exists in selectDay list, or set it to the first day
        if (!controller.selectDay.contains(selectedDay)) {
          selectedDay = controller.selectDay.isNotEmpty ? controller.selectDay[0] : "Monday";
        }

        return Padding(
          padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
          child: SizedBox(
            width: getProportionateScreenWidth(widget.width),
            child: GestureDetector(
              // onTap: () => Navigator.pushNamed(
              //   context,
              //   DetailsScreen.routeName,
              //   arguments: ProductDetailsArguments(product: widget.product),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: widget.aspectRatio,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Hero(
                        tag: widget.product.id.toString(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isClosed,
                                      activeColor: KPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          isClosed = value!;
                                        });
                                      },
                                    ),
                                    const CustomText(text: 'Closed '),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Want to remove this item?"),
                                      action: SnackBarAction(
                                          label: 'Sure',
                                          onPressed: () {
                                            // Perform removal logic
                                          }),
                                    ));
                                  },
                                  child: SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade400,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            DropdownButton(
                              iconSize: 40,
                              isExpanded: true,
                              value: selectedDay,
                              items: controller.selectDay.map((String day) {
                                return DropdownMenuItem<String>(
                                  value: day,
                                  child: Text(day),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDay = value.toString();
                                });
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            SizedBox(
                              width: getProportionateScreenWidth(widget.width),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: 'From',
                                    fontColor: KPrimaryColor,
                                  ),
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) {
                                      return hoursList.map((hour) {
                                        return PopupMenuItem(
                                          value: hour,
                                          child: Text(hour.toString()),
                                        );
                                      }).toList();
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        CustomText(
                                          text: fromHour.toString(),
                                        ),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                    onSelected: (value) {
                                      setState(() {
                                        fromHour = value;
                                      });
                                    },
                                  ),
                                  const CustomText(
                                    text: 'am',
                                    fontColor: KPrimaryColor,
                                  ),
                                  const CustomText(
                                    text: 'To',
                                    fontColor: KPrimaryColor,
                                  ),
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) {
                                      return hoursList.map((hour) {
                                        return PopupMenuItem(
                                          value: hour,
                                          child: Text(hour.toString()),
                                        );
                                      }).toList();
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        CustomText(
                                          text: toHour.toString(),
                                        ),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                    onSelected: (value) {
                                      setState(() {
                                        toHour = value;
                                      });
                                    },
                                  ),
                                  const CustomText(
                                    text: 'pm',
                                    fontColor: KPrimaryColor,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Method to collect working hours data from the widget
  WorkingHour getWorkingHourData() {
    return WorkingHour(
      title: selectedDay,
      fromHour: fromHour,
      toHour: toHour,
    );
  }
}



