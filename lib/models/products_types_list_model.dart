// To parse this JSON data, do
//
//     final productsTypesListModel = productsTypesListModelFromJson(jsonString);

import 'dart:convert';

ProductsTypesListModel productsTypesListModelFromJson(String str) => ProductsTypesListModel.fromJson(json.decode(str));

String productsTypesListModelToJson(ProductsTypesListModel data) => json.encode(data.toJson());

class ProductsTypesListModel {
  List<ProductsTypes>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ProductsTypesListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ProductsTypesListModel.fromJson(Map<String, dynamic> json) => ProductsTypesListModel(
    data: json["data"] == null ? [] : List<ProductsTypes>.from(json["data"]!.map((x) => ProductsTypes.fromJson(x))),
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

class ProductsTypes {
  int? id;
  int? itemTypeCode;
  String? itemTypeName;

  ProductsTypes({
    this.id,
    this.itemTypeCode,
    this.itemTypeName,
  });

  factory ProductsTypes.fromJson(Map<String, dynamic> json) => ProductsTypes(
    id: json["id"],
    itemTypeCode: json["itemTypeCode"],
    itemTypeName: json["itemTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "itemTypeCode": itemTypeCode,
    "itemTypeName": itemTypeName,
  };
}
