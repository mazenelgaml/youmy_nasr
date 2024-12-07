import 'package:flutter/material.dart';
import 'package:merchant/data/model/Courier.dart';

import 'Product.dart';

class Order {
  final int id,branchId;
  final String date,orderNo,statusDescription,clientNo,clientName,branchName;
  final OrderState status;
  final List<Product> productList;
   Courier? courier=null;



  Order({
    required this.id,
    this.branchId=1,
    this.branchName="Maadi - Branch",
     this.courier,
    required this.orderNo,
    required this.date,
     this.clientNo="01122384455",
    this.clientName="Mokhtar Mostafa Sayed",
    required this.statusDescription,
    required this.productList,

    required this.status
  });
}

// Our demo Orders


List<Order> demoOrders = [
  Order(
    id: 1,
    orderNo: '21023',
    date: "12/3/2022 03:11 am",
    clientNo: "01002354857",
    clientName: "Ahmed Saad",
    statusDescription: 'Delivered',
    branchId: 1,
    branchName: "Maadi - Branch",
    status: OrderState.DELIEVERED,
    productList: subList,
    courier:Courier(id:1,isActive: true,name: 'Ahmed Sayed',mobile: '0123456789+'),

  ),
  Order(
    id: 1,
    orderNo: '21667',
    date: "12/3/2022 06:18 am",
    clientNo: "01568744857",
    clientName: "Mokhtar Mostafa",
    statusDescription: 'OnWay',
    status: OrderState.ONWAY,
    branchId: 1,
    branchName: "Maadi - Branch",
      productList: subList
  ),
  Order(
    id: 1,
    orderNo: '298523',
    date: "18/3/2022 12:11 am",
    clientNo: "01698521745",
    clientName: "Amal Mani",
    statusDescription: 'Delivered',
    status: OrderState.DELIEVERED,
    branchId: 1,
    branchName: "Maadi - Branch",
      productList: subList
  ),
  Order(
    id: 1,
    orderNo: '21873',
    date: "16/5/2022 07:11 am",
    clientNo: "0112547852",
    clientName: "Nadia mostafa",
    statusDescription: 'Cancelled',
    status: OrderState.CANCELLED,
    branchId: 1,
    branchName: "Maadi - Branch",
      productList: subList
  ),
];



const String status =
    "Giza -Faisal";


Color getStatus(OrderState status) {
  switch (status) {
    case OrderState.DELIEVERED:
      return Colors.green;

    case OrderState.ONWAY:
      return Colors.yellow;
      break;
    case OrderState.CANCELLED:
      return Colors.red;
      break;
  }
}
List<String> orderStatusList=["Review","Prepare","On Way","Delivered"];
enum OrderState { DELIEVERED, ONWAY, CANCELLED}
