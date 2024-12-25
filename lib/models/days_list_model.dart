// To parse this JSON data, do
//
//     final daysListModel = daysListModelFromJson(jsonString);

import 'dart:convert';

DaysListModel daysListModelFromJson(String str) => DaysListModel.fromJson(json.decode(str));

String daysListModelToJson(DaysListModel data) => json.encode(data.toJson());

class DaysListModel {
  List<DaysList>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  DaysListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory DaysListModel.fromJson(Map<String, dynamic> json) => DaysListModel(
    data: json["data"] == null ? [] : List<DaysList>.from(json["data"]!.map((x) => DaysList.fromJson(x))),
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

class DaysList {
  int? id;
  int? dayCode;
  String? name;

  DaysList({
    this.id,
    this.dayCode,
    this.name,
  });

  factory DaysList.fromJson(Map<String, dynamic> json) => DaysList(
    id: json["id"],
    dayCode: json["dayCode"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayCode": dayCode,
    "name": name,
  };
}
