import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../components/courier_card.dart';
import '../../../../../data/model/courier.dart';
import '../../../../../util/Constants.dart';
import '../../../../../util/size_config.dart';
import '../../product/show_all_branches/product_branches_filter_screen.dart';



class CouriersData extends StatefulWidget {
  const CouriersData({Key? key}) : super(key: key);

  @override
  State<CouriersData> createState() => _CouriersDataState();
}

class _CouriersDataState extends State<CouriersData> {
  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            "Maadi",
            "Helwan",
            "Tahrir",
            "H-Kopa",
            "New Cairo",
            "All"
          ]
              .map((String name) => GestureDetector(
            child: Chip(
              avatar: CircleAvatar(
                child: Text(name.substring(0, 1)),
              ),
              label: Text(
                name,
              ),
            ),
            onTap: () {

              if(name=="All")
              {
                Navigator.pushNamed(context, ProductBranchesFilterScreen.routeName);
              }
              else
                _showToast("$name is Pressed");
            },
          ))
              .toList(),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoCouriers.length,
                    (index) {
                      return CourierCard(courier: demoCouriers[index]);// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: KPrimaryColor,
        fontSize: 16.0);
  }
}
