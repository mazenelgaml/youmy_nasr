// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  int? id;
  int? companyCode;
  int? branchCode;
  String? itemCode;
  String? itemName;
  dynamic itemTypeCode;
  dynamic itemTypeName;
  String? itemNameAra;
  String? itemNameEng;
  dynamic itemTypeNameAra;
  dynamic itemTypeNameEng;
  int? defaultSellPrice;
  dynamic defaultUnitCode;
  String? defaultUnitName;
  dynamic unitNameAra;
  dynamic unitNameEng;
  String? productImage;
  String? productImageData;
  dynamic isIgnoreBalance;
  bool? isHasBalance;
  int? itemOn;
  int? rate;

  ProductDetailsModel({
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
    this.productImage,
    this.productImageData,
    this.isIgnoreBalance,
    this.isHasBalance,
    this.itemOn,
    this.rate,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
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
    productImage: json["productImage"],
    productImageData: json["productImageData"],
    isIgnoreBalance: json["isIgnoreBalance"],
    isHasBalance: json["isHasBalance"],
    itemOn: json["itemOn"],
    rate: json["rate"],
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
    "productImage": productImage,
    "productImageData": productImageData,
    "isIgnoreBalance": isIgnoreBalance,
    "isHasBalance": isHasBalance,
    "itemOn": itemOn,
    "rate": rate,
  };
}
