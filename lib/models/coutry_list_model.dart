// To parse this JSON data, do
//
//     final countryListModel = countryListModelFromJson(jsonString);

import 'dart:convert';

CountryListModel countryListModelFromJson(String str) => CountryListModel.fromJson(json.decode(str));

String countryListModelToJson(CountryListModel data) => json.encode(data.toJson());

class CountryListModel {
  List<CountryData>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CountryListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    data: json["data"] == null ? [] : List<CountryData>.from(json["data"]!.map((x) => CountryData.fromJson(x))),
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

class CountryData {
  int? id;
  int? countryId;
  String? countryName;

  CountryData({
    this.id,
    this.countryId,
    this.countryName,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    countryId: json["countryID"],
    countryName: json["countryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countryID": countryId,
    "countryName": countryName,
  };
}
