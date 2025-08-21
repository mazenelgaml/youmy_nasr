// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  List<Datum>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  OrderDetailsModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalCount: json["totalCount"],
    pageSize: json["pageSize"],
    hasPreviousPage: json["hasPreviousPage"],
    hasNextPage: json["hasNextPage"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalCount": totalCount,
    "pageSize": pageSize,
    "hasPreviousPage": hasPreviousPage,
    "hasNextPage": hasNextPage,
  };
}

class Datum {
  int? id;
  String? sellOrdersSerial;
  DateTime? sellOrdersDate;
  dynamic salesManCode;
  String? salesManName;
  String? customerCode;
  String? customerName;
  String? customerAddress;
  dynamic customerCountryCode;
  String? customerCountryName;
  String? customerMobile;
  int? sellOrderStatusCode;
  String? sellOrderStatusName;
  int? companyCode;
  String? companyName;
  int? branchCode;
  String? branchName;
  int? totalValue;
  int? deliveryFee;
  int? totalDiscount;
  int? totalTax;
  int? totalQuantity;
  int? totalNet;
  int? invoiceTypeCode;
  String? invoiceTypeName;
  int? courierCode;
  String? courierName;
  dynamic notes;
  String? address;
  List<FullSellOrderDetailMobileDto>? fullSellOrderDetailMobileDto;

  Datum({
    this.id,
    this.sellOrdersSerial,
    this.sellOrdersDate,
    this.salesManCode,
    this.salesManName,
    this.customerCode,
    this.customerName,
    this.customerAddress,
    this.customerCountryCode,
    this.customerCountryName,
    this.customerMobile,
    this.sellOrderStatusCode,
    this.sellOrderStatusName,
    this.companyCode,
    this.companyName,
    this.branchCode,
    this.branchName,
    this.totalValue,
    this.deliveryFee,
    this.totalDiscount,
    this.totalTax,
    this.totalQuantity,
    this.totalNet,
    this.invoiceTypeCode,
    this.invoiceTypeName,
    this.courierCode,
    this.courierName,
    this.notes,
    this.address,
    this.fullSellOrderDetailMobileDto,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sellOrdersSerial: json["sellOrdersSerial"],
    sellOrdersDate: json["sellOrdersDate"] == null ? null : DateTime.parse(json["sellOrdersDate"]),
    salesManCode: json["salesManCode"],
    salesManName: json["salesManName"],
    customerCode: json["customerCode"],
    customerName: json["customerName"],
    customerAddress: json["customerAddress"],
    customerCountryCode: json["customerCountryCode"],
    customerCountryName: json["customerCountryName"],
    customerMobile: json["customerMobile"],
    sellOrderStatusCode: json["sellOrderStatusCode"],
    sellOrderStatusName: json["sellOrderStatusName"],
    companyCode: json["companyCode"],
    companyName: json["companyName"],
    branchCode: json["branchCode"],
    branchName: json["branchName"],
    totalValue: json["totalValue"],
    deliveryFee: json["deliveryFee"],
    totalDiscount: json["totalDiscount"],
    totalTax: json["totalTax"],
    totalQuantity: json["totalQuantity"],
    totalNet: json["totalNet"],
    invoiceTypeCode: json["invoiceTypeCode"],
    invoiceTypeName: json["invoiceTypeName"],
    courierCode: json["courierCode"],
    courierName: json["courierName"],
    notes: json["notes"],
    address: json["address"],
    fullSellOrderDetailMobileDto: json["fullSellOrderDetailMobileDto"] == null ? [] : List<FullSellOrderDetailMobileDto>.from(json["fullSellOrderDetailMobileDto"]!.map((x) => FullSellOrderDetailMobileDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sellOrdersSerial": sellOrdersSerial,
    "sellOrdersDate": sellOrdersDate?.toIso8601String(),
    "salesManCode": salesManCode,
    "salesManName": salesManName,
    "customerCode": customerCode,
    "customerName": customerName,
    "customerAddress": customerAddress,
    "customerCountryCode": customerCountryCode,
    "customerCountryName": customerCountryName,
    "customerMobile": customerMobile,
    "sellOrderStatusCode": sellOrderStatusCode,
    "sellOrderStatusName": sellOrderStatusName,
    "companyCode": companyCode,
    "companyName": companyName,
    "branchCode": branchCode,
    "branchName": branchName,
    "totalValue": totalValue,
    "deliveryFee": deliveryFee,
    "totalDiscount": totalDiscount,
    "totalTax": totalTax,
    "totalQuantity": totalQuantity,
    "totalNet": totalNet,
    "invoiceTypeCode": invoiceTypeCode,
    "invoiceTypeName": invoiceTypeName,
    "courierCode": courierCode,
    "courierName": courierName,
    "notes": notes,
    "address": address,
    "fullSellOrderDetailMobileDto": fullSellOrderDetailMobileDto == null ? [] : List<dynamic>.from(fullSellOrderDetailMobileDto!.map((x) => x.toJson())),
  };
}

class FullSellOrderDetailMobileDto {
  int? id;
  String? itemCode;
  String? itemName;
  String? unitCode;
  String? unitName;
  int? quantity;
  int? price;
  dynamic total;

  FullSellOrderDetailMobileDto({
    this.id,
    this.itemCode,
    this.itemName,
    this.unitCode,
    this.unitName,
    this.quantity,
    this.price,
    this.total,
  });

  factory FullSellOrderDetailMobileDto.fromJson(Map<String, dynamic> json) => FullSellOrderDetailMobileDto(
    id: json["id"],
    itemCode: json["itemCode"],
    itemName: json["itemName"],
    unitCode: json["unitCode"],
    unitName: json["unitName"],
    quantity: json["quantity"],
    price: json["price"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "itemCode": itemCode,
    "itemName": itemName,
    "unitCode": unitCode,
    "unitName": unitName,
    "quantity": quantity,
    "price": price,
    "total": total,
  };
}
