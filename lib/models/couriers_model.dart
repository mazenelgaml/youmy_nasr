// To parse this JSON data, do
//
//     final couriesListModel = couriesListModelFromJson(jsonString);

import 'dart:convert';

CouriesListModel couriesListModelFromJson(String str) => CouriesListModel.fromJson(json.decode(str));

String couriesListModelToJson(CouriesListModel data) => json.encode(data.toJson());

class CouriesListModel {
  List<CouriersDetails>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CouriesListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory CouriesListModel.fromJson(Map<String, dynamic> json) => CouriesListModel(
    data: json["data"] == null ? [] : List<CouriersDetails>.from(json["data"]!.map((x) => CouriersDetails.fromJson(x))),
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

class CouriersDetails {
  int? id;
  String? salesManCode;
  String? salesManName;
  String? salesManNameAra;
  String? salesManNameEng;
  String? merchantName;
  dynamic mobile1;
  dynamic mobile2;

  CouriersDetails({
    this.id,
    this.salesManCode,
    this.salesManName,
    this.salesManNameAra,
    this.salesManNameEng,
    this.merchantName,
    this.mobile1,
    this.mobile2,
  });

  factory CouriersDetails.fromJson(Map<String, dynamic> json) => CouriersDetails(
    id: json["id"],
    salesManCode: json["salesManCode"],
    salesManName: json["salesManName"],
    salesManNameAra: json["salesManNameAra"],
    salesManNameEng: json["salesManNameEng"],
    merchantName: json["merchantName"],
    mobile1: json["mobile1"],
    mobile2: json["mobile2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salesManCode": salesManCode,
    "salesManName": salesManName,
    "salesManNameAra": salesManNameAra,
    "salesManNameEng": salesManNameEng,
    "merchantName": merchantName,
    "mobile1": mobile1,
    "mobile2": mobile2,
  };
}
