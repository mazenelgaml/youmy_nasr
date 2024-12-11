// To parse this JSON data, do
//
//     final branchesListModel = branchesListModelFromJson(jsonString);

import 'dart:convert';

BranchesListModel branchesListModelFromJson(String str) => BranchesListModel.fromJson(json.decode(str));

String branchesListModelToJson(BranchesListModel data) => json.encode(data.toJson());

class BranchesListModel {
  List<Branches>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  BranchesListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory BranchesListModel.fromJson(Map<String, dynamic> json) => BranchesListModel(
    data: json["data"] == null ? [] : List<Branches>.from(json["data"]!.map((x) => Branches.fromJson(x))),
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

class Branches {
  int? id;
  int? branchCode;
  String? branchName;
  double? branchRate;

  Branches({
    this.id,
    this.branchCode,
    this.branchName,
    this.branchRate,
  });

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
    id: json["id"],
    branchCode: json["branchCode"],
    branchName: json["branchName"],
    branchRate: json["branchRate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchCode": branchCode,
    "branchName": branchName,
    "branchRate": branchRate,
  };
}
