// To parse this JSON data, do
//
//     final citiesListModel = citiesListModelFromJson(jsonString);

import 'dart:convert';

CitiesListModel citiesListModelFromJson(String str) => CitiesListModel.fromJson(json.decode(str));

String citiesListModelToJson(CitiesListModel data) => json.encode(data.toJson());

class CitiesListModel {
  List<cities>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CitiesListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory CitiesListModel.fromJson(Map<String, dynamic> json) => CitiesListModel(
    data: json["data"] == null ? [] : List<cities>.from(json["data"]!.map((x) => cities.fromJson(x))),
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

class cities {
  int? id;
  int? cityCode;
  String? cityName;

  cities({
    this.id,
    this.cityCode,
    this.cityName,
  });

  factory cities.fromJson(Map<String, dynamic> json) => cities(
    id: json["id"],
    cityCode: json["cityCode"],
    cityName: json["cityName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cityCode": cityCode,
    "cityName": cityName,
  };
}
