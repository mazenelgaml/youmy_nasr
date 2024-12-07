import 'package:flutter/material.dart';
import 'package:merchant/components/custom_text_form_field.dart';
import 'package:merchant/components/order_card.dart';
import 'package:merchant/data/model/Order.dart';
import '../../../../../../components/custom_text.dart';
import '../../../../../../util/keyboard.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Order> _orders = [];
  final List<String> searchOptions = [
    "Select Search Type",
    "Order No",
    "Client No",
    "Client Name",
  ];
  var selectedOption= "Select Search Type";
   SearchOption searchoption=SearchOption.ORDER_NO;


  @override
  initState() {
    _orders = demoOrders;
    super.initState();
  }

  void _runFilter(String enteredKeyword,SearchOption searchOption) {
    List<Order> results = [];
    if (enteredKeyword.isEmpty) {
      results = demoOrders;
    }
    else {
      switch(searchOption)
      {
        case SearchOption.ORDER_NO :
          results = demoOrders
              .where((order) => order.orderNo
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
              .toList();
          break;
        case SearchOption.CLIENT_NO:
          results = demoOrders
              .where((order) => order.clientNo
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
              .toList();
          break;
          case SearchOption.CLIENT_NAME:
          results = demoOrders
              .where((order) => order.clientName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
              .toList();
          break;


      }

    }

    // Refresh the UI
    setState(() {
      _orders = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: buildSearchField()
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                onChanged: (value) => _runFilter(value,searchoption),
                decoration: InputDecoration(
                  hintText: "Enter data ...",
                  suffixIcon: IconButton(
                    onPressed: () => {KeyboardUtil.hideKeyboard(context)},
                    icon: Icon(Icons.search),
                  ),
                ),
              )),
          ...List.generate(
            _orders.length,
                (index) {
              return OrderCard(order: _orders[index]);// here by default width and height is 0
            },
          ),

        ],
      ),
    );
  }

  DropdownButton<String> buildSearchField() {
    return DropdownButton(
      hint: const CustomText(
        text: 'Select Search Type',
      ),
      iconSize: 40,
      isExpanded: true,
      value: selectedOption,
      items: searchOptions.map((String option) {
        return DropdownMenuItem<String>(
          child: Text(option),
          value: option,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedOption = value.toString();
          switch(selectedOption)
          {
            case  "Order No":
              searchoption=SearchOption.ORDER_NO;
              break;
            case  "Client No":
              searchoption=SearchOption.CLIENT_NO;
              break;
            case "Client Name":
              searchoption=SearchOption.CLIENT_NAME;
              break;

          }
        });
      },
    );
  }


}
enum SearchOption { ORDER_NO, CLIENT_NO, CLIENT_NAME}


