// To parse this JSON data, do
//
//     final companyTypesListModel = companyTypesListModelFromJson(jsonString);

import 'dart:convert';

CompanyTypesListModel companyTypesListModelFromJson(String str) => CompanyTypesListModel.fromJson(json.decode(str));

String companyTypesListModelToJson(CompanyTypesListModel data) => json.encode(data.toJson());

class CompanyTypesListModel {
  List<CompanyType>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CompanyTypesListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory CompanyTypesListModel.fromJson(Map<String, dynamic> json) => CompanyTypesListModel(
    data: json["data"] == null ? [] : List<CompanyType>.from(json["data"]!.map((x) => CompanyType.fromJson(x))),
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

class CompanyType {
  int? id;
  String? companyTypeCode;
  String? companyTypeName;

  CompanyType({
    this.id,
    this.companyTypeCode,
    this.companyTypeName,
  });

  factory CompanyType.fromJson(Map<String, dynamic> json) => CompanyType(
    id: json["id"],
    companyTypeCode: json["companyTypeCode"],
    companyTypeName: json["companyTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyTypeCode": companyTypeCode,
    "companyTypeName": companyTypeName,
  };
}
