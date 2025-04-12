// To parse this JSON data, do
//
//     final productsClassificationsListModel = productsClassificationsListModelFromJson(jsonString);

import 'dart:convert';

ProductsClassificationsListModel productsClassificationsListModelFromJson(String str) => ProductsClassificationsListModel.fromJson(json.decode(str));

String productsClassificationsListModelToJson(ProductsClassificationsListModel data) => json.encode(data.toJson());

class ProductsClassificationsListModel {
  List<ProductsClassifications>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ProductsClassificationsListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ProductsClassificationsListModel.fromJson(Map<String, dynamic> json) => ProductsClassificationsListModel(
    data: json["data"] == null ? [] : List<ProductsClassifications>.from(json["data"]!.map((x) => ProductsClassifications.fromJson(x))),
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

class ProductsClassifications {
  int? id;
  String? itemClassCode;
  String? itemClassName;

  ProductsClassifications({
    this.id,
    this.itemClassCode,
    this.itemClassName,
  });

  factory ProductsClassifications.fromJson(Map<String, dynamic> json) => ProductsClassifications(
    id: json["id"],
    itemClassCode: json["itemClassCode"],
    itemClassName: json["itemClassName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "itemClassCode": itemClassCode,
    "itemClassName": itemClassName,
  };
}
