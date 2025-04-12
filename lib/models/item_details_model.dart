// To parse this JSON data, do
//
//     final itemDetailsModel = itemDetailsModelFromJson(jsonString);

import 'dart:convert';

ItemDetailsModel itemDetailsModelFromJson(String str) => ItemDetailsModel.fromJson(json.decode(str));

String itemDetailsModelToJson(ItemDetailsModel data) => json.encode(data.toJson());

class ItemDetailsModel {
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
  dynamic productImage;
  dynamic productImageData;
  dynamic isIgnoreBalance;
  bool? isHasBalance;
  int? itemOn;
  int? itemRate;

  ItemDetailsModel({
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
    this.itemRate,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) => ItemDetailsModel(
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
    itemRate: json["itemRate"],
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
    "itemRate": itemRate,
  };
}
