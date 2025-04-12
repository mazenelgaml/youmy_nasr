// To parse this JSON data, do
//
//     final createCourierErrorModel = createCourierErrorModelFromJson(jsonString);

import 'dart:convert';

CreateCourierErrorModel createCourierErrorModelFromJson(String str) => CreateCourierErrorModel.fromJson(json.decode(str));

String createCourierErrorModelToJson(CreateCourierErrorModel data) => json.encode(data.toJson());

class CreateCourierErrorModel {
  List<String>? messages;
  String? source;
  String? exception;
  String? errorId;
  String? supportMessage;
  int? statusCode;

  CreateCourierErrorModel({
    this.messages,
    this.source,
    this.exception,
    this.errorId,
    this.supportMessage,
    this.statusCode,
  });

  factory CreateCourierErrorModel.fromJson(Map<String, dynamic> json) => CreateCourierErrorModel(
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
