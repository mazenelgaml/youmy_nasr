// To parse this JSON data, do
//
//     final regionListModel = regionListModelFromJson(jsonString);

import 'dart:convert';

RegionListModel regionListModelFromJson(String str) => RegionListModel.fromJson(json.decode(str));

String regionListModelToJson(RegionListModel data) => json.encode(data.toJson());

class RegionListModel {
  List<Region>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  RegionListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory RegionListModel.fromJson(Map<String, dynamic> json) => RegionListModel(
    data: json["data"] == null ? [] : List<Region>.from(json["data"]!.map((x) => Region.fromJson(x))),
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

class Region {
  int? id;
  int? zoneCode;
  String? zoneName;

  Region({
    this.id,
    this.zoneCode,
    this.zoneName,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    zoneCode: json["zoneCode"],
    zoneName: json["zoneName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "zoneCode": zoneCode,
    "zoneName": zoneName,
  };
}
