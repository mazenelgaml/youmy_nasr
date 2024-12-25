// To parse this JSON data, do
//
//     final productsListModel = productsListModelFromJson(jsonString);

import 'dart:convert';

ProductsListModel productsListModelFromJson(String str) => ProductsListModel.fromJson(json.decode(str));

String productsListModelToJson(ProductsListModel data) => json.encode(data.toJson());

class ProductsListModel {
  List<ProductDetails>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ProductsListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ProductsListModel.fromJson(Map<String, dynamic> json) => ProductsListModel(
    data: json["data"] == null ? [] : List<ProductDetails>.from(json["data"]!.map((x) => ProductDetails.fromJson(x))),
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

class ProductDetails {
  int? id;
  int? companyCode;
  int? branchCode;
  String? itemCode;
  String? itemName;
  int? itemTypeCode;
  String? itemTypeName;
  String? itemNameAra;
  String? itemNameEng;
  String? itemTypeNameAra;
  String? itemTypeNameEng;
  int? defaultSellPrice;
  String? defaultUnitCode;
  String? defaultUnitName;
  String? unitNameAra;
  String? unitNameEng;
  dynamic isIgnoreBalance;
  bool? isHasBalance;

  ProductDetails({
    this.id,
    this.companyCode,
    this.branchCode,
    this.itemCode,
    this.itemName,
    this.itemTypeCode,
    this.itemTypeName,
    this.itemNameAra,
    this.itemNameEng,
    this.itemTypeNameAra,
    this.itemTypeNameEng,
    this.defaultSellPrice,
    this.defaultUnitCode,
    this.defaultUnitName,
    this.unitNameAra,
    this.unitNameEng,
    this.isIgnoreBalance,
    this.isHasBalance,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["id"],
    companyCode: json["companyCode"],
    branchCode: json["branchCode"],
    itemCode: json["itemCode"],
    itemName: json["itemName"],
    itemTypeCode: json["itemTypeCode"],
    itemTypeName: json["itemTypeName"],
    itemNameAra: json["itemNameAra"],
    itemNameEng: json["itemNameEng"],
    itemTypeNameAra: json["itemTypeNameAra"],
    itemTypeNameEng: json["itemTypeNameEng"],
    defaultSellPrice: json["defaultSellPrice"],
    defaultUnitCode: json["defaultUnitCode"],
    defaultUnitName: json["defaultUnitName"],
    unitNameAra: json["unitNameAra"],
    unitNameEng: json["unitNameEng"],
    isIgnoreBalance: json["isIgnoreBalance"],
    isHasBalance: json["isHasBalance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyCode": companyCode,
    "branchCode": branchCode,
    "itemCode": itemCode,
    "itemName": itemName,
    "itemTypeCode": itemTypeCode,
    "itemTypeName": itemTypeName,
    "itemNameAra": itemNameAra,
    "itemNameEng": itemNameEng,
    "itemTypeNameAra": itemTypeNameAra,
    "itemTypeNameEng": itemTypeNameEng,
    "defaultSellPrice": defaultSellPrice,
    "defaultUnitCode": defaultUnitCode,
    "defaultUnitName": defaultUnitName,
    "unitNameAra": unitNameAra,
    "unitNameEng": unitNameEng,
    "isIgnoreBalance": isIgnoreBalance,
    "isHasBalance": isHasBalance,
  };
}
