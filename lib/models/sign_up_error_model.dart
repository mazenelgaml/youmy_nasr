// To parse this JSON data, do
//
//     final signUpErrorModel = signUpErrorModelFromJson(jsonString);

import 'dart:convert';

SignUpErrorModel signUpErrorModelFromJson(String str) => SignUpErrorModel.fromJson(json.decode(str));

String signUpErrorModelToJson(SignUpErrorModel data) => json.encode(data.toJson());

class SignUpErrorModel {
  List<String>? messages;
  String? source;
  String? exception;
  String? errorId;
  String? supportMessage;
  int? statusCode;
  Errors? errors;

  SignUpErrorModel({
    this.messages,
    this.source,
    this.exception,
    this.errorId,
    this.supportMessage,
    this.statusCode,
    this.errors,
  });

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) => SignUpErrorModel(
    messages: json["messages"] == null ? [] : List<String>.from(json["messages"]!.map((x) => x)),
    source: json["source"],
    exception: json["exception"],
    errorId: json["errorId"],
    supportMessage: json["supportMessage"],
    statusCode: json["statusCode"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x)),
    "source": source,
    "exception": exception,
    "errorId": errorId,
    "supportMessage": supportMessage,
    "statusCode": statusCode,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? vendorCode;

  Errors({
    this.vendorCode,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    vendorCode: json["VendorCode"] == null ? [] : List<String>.from(json["VendorCode"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "VendorCode": vendorCode == null ? [] : List<dynamic>.from(vendorCode!.map((x) => x)),
  };
}
