// To parse this JSON data, do
//
//     final bankAccountsListModel = bankAccountsListModelFromJson(jsonString);

import 'dart:convert';

BankAccountsListModel bankAccountsListModelFromJson(String str) => BankAccountsListModel.fromJson(json.decode(str));

String bankAccountsListModelToJson(BankAccountsListModel data) => json.encode(data.toJson());

class BankAccountsListModel {
  List<BankAccount>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  BankAccountsListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory BankAccountsListModel.fromJson(Map<String, dynamic> json) => BankAccountsListModel(
    data: json["data"] == null ? [] : List<BankAccount>.from(json["data"]!.map((x) => BankAccount.fromJson(x))),
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

class BankAccount {
  int? id;
  String? vendorCode;
  dynamic vendorName;
  String? bankAccountName;
  String? bankAccountNumber;
  dynamic bankName;
  String? bankCode;
  String? bankBranchCode;

  BankAccount({
    this.id,
    this.vendorCode,
    this.vendorName,
    this.bankAccountName,
    this.bankAccountNumber,
    this.bankName,
    this.bankCode,
    this.bankBranchCode,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    id: json["id"],
    vendorCode: json["vendorCode"],
    vendorName: json["vendorName"],
    bankAccountName: json["bankAccountName"],
    bankAccountNumber: json["bankAccountNumber"],
    bankName: json["bankName"],
    bankCode: json["bankCode"],
    bankBranchCode: json["bankBranchCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendorCode": vendorCode,
    "vendorName": vendorName,
    "bankAccountName": bankAccountName,
    "bankAccountNumber": bankAccountNumber,
    "bankName": bankName,
    "bankCode": bankCode,
    "bankBranchCode": bankBranchCode,
  };
}
