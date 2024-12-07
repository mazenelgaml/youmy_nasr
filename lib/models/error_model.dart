// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  List<String>? messages;
  String? source;
  String? exception;
  String? errorId;
  String? supportMessage;
  int? statusCode;

  ResponseModel({
    this.messages,
    this.source,
    this.exception,
    this.errorId,
    this.supportMessage,
    this.statusCode,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    messages: json["messages"] == null ? [] : List<String>.from(json["messages"]!.map((x) => x)),
    source: json["source"],
    exception: json["exception"],
    errorId: json["errorId"],
    supportMessage: json["supportMessage"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x)),
    "source": source,
    "exception": exception,
    "errorId": errorId,
    "supportMessage": supportMessage,
    "statusCode": statusCode,
  };
}
