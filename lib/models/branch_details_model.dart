// To parse this JSON data, do
//
//     final branchDetailsModel = branchDetailsModelFromJson(jsonString);

import 'dart:convert';

BranchDetailsModel branchDetailsModelFromJson(String str) => BranchDetailsModel.fromJson(json.decode(str));

String branchDetailsModelToJson(BranchDetailsModel data) => json.encode(data.toJson());

class BranchDetailsModel {
  int? id;
  int? companyCode;
  String? companyName;
  int? branchCode;
  String? branchName;
  dynamic image;
  bool? isOpen;
  double? rate;
  String? workingHours;
  String? paymentMethods;

  BranchDetailsModel({
    this.id,
    this.companyCode,
    this.companyName,
    this.branchCode,
    this.branchName,
    this.image,
    this.isOpen,
    this.rate,
    this.workingHours,
    this.paymentMethods,
  });

  factory BranchDetailsModel.fromJson(Map<String, dynamic> json) => BranchDetailsModel(
    id: json["id"],
    companyCode: json["companyCode"],
    companyName: json["companyName"],
    branchCode: json["branchCode"],
    branchName: json["branchName"],
    image: json["image"],
    isOpen: json["isOpen"],
    rate: json["rate"]?.toDouble(),
    workingHours: json["workingHours"],
    paymentMethods: json["paymentMethods"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyCode": companyCode,
    "companyName": companyName,
    "branchCode": branchCode,
    "branchName": branchName,
    "image": image,
    "isOpen": isOpen,
    "rate": rate,
    "workingHours": workingHours,
    "paymentMethods": paymentMethods,
  };
}
