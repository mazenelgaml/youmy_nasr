// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? token;
  String? refreshToken;
  DateTime? refreshTokenExpiryTime;
  String? userCode;
  String? empCode;
  bool? isHasPermission;
  String? permissionMessage;

  LoginModel({
    this.token,
    this.refreshToken,
    this.refreshTokenExpiryTime,
    this.userCode,
    this.empCode,
    this.isHasPermission,
    this.permissionMessage,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    refreshToken: json["refreshToken"],
    refreshTokenExpiryTime: json["refreshTokenExpiryTime"] == null ? null : DateTime.parse(json["refreshTokenExpiryTime"]),
    userCode: json["userCode"],
    empCode: json["empCode"],
    isHasPermission: json["isHasPermission"],
    permissionMessage: json["permissionMessage"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "refreshToken": refreshToken,
    "refreshTokenExpiryTime": refreshTokenExpiryTime?.toIso8601String(),
    "userCode": userCode,
    "empCode": empCode,
    "isHasPermission": isHasPermission,
    "permissionMessage": permissionMessage,
  };
}
