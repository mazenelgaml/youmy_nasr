// To parse this JSON data, do
//
//     final addBankAccountErrorModel = addBankAccountErrorModelFromJson(jsonString);

import 'dart:convert';

AddBankAccountErrorModel addBankAccountErrorModelFromJson(String str) => AddBankAccountErrorModel.fromJson(json.decode(str));

String addBankAccountErrorModelToJson(AddBankAccountErrorModel data) => json.encode(data.toJson());

class AddBankAccountErrorModel {
  String? type;
  String? title;
  int? status;
  String? traceId;
  Errors? errors;

  AddBankAccountErrorModel({
    this.type,
    this.title,
    this.status,
    this.traceId,
    this.errors,
  });

  factory AddBankAccountErrorModel.fromJson(Map<String, dynamic> json) => AddBankAccountErrorModel(
    type: json["type"],
    title: json["title"],
    status: json["status"],
    traceId: json["traceId"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "status": status,
    "traceId": traceId,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? bankAccountNumber;

  Errors({
    this.bankAccountNumber,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    bankAccountNumber: json["BankAccountNumber"] == null ? [] : List<String>.from(json["BankAccountNumber"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "BankAccountNumber": bankAccountNumber == null ? [] : List<dynamic>.from(bankAccountNumber!.map((x) => x)),
  };
}
