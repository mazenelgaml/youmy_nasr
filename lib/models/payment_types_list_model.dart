// To parse this JSON data, do
//
//     final paymentTypeListModel = paymentTypeListModelFromJson(jsonString);

import 'dart:convert';

PaymentTypeListModel paymentTypeListModelFromJson(String str) => PaymentTypeListModel.fromJson(json.decode(str));

String paymentTypeListModelToJson(PaymentTypeListModel data) => json.encode(data.toJson());

class PaymentTypeListModel {
  List<PaymentType>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  PaymentTypeListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory PaymentTypeListModel.fromJson(Map<String, dynamic> json) => PaymentTypeListModel(
    data: json["data"] == null ? [] : List<PaymentType>.from(json["data"]!.map((x) => PaymentType.fromJson(x))),
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

class PaymentType {
  int? id;
  String? paymentMethodCode;
  String? paymentMethodName;

  PaymentType({
    this.id,
    this.paymentMethodCode,
    this.paymentMethodName,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
    id: json["id"],
    paymentMethodCode: json["paymentMethodCode"],
    paymentMethodName: json["paymentMethodName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentMethodCode": paymentMethodCode,
    "paymentMethodName": paymentMethodName,
  };
}
