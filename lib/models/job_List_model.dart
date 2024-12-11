// To parse this JSON data, do
//
//     final jobListModel = jobListModelFromJson(jsonString);

import 'dart:convert';

JobListModel jobListModelFromJson(String str) => JobListModel.fromJson(json.decode(str));

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  List<Jobs>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  JobListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
    data: json["data"] == null ? [] : List<Jobs>.from(json["data"]!.map((x) => Jobs.fromJson(x))),
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

class Jobs {
  int? id;
  String? jobCode;
  String? jobName;

  Jobs({
    this.id,
    this.jobCode,
    this.jobName,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
    id: json["id"],
    jobCode: json["jobCode"],
    jobName: json["jobName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jobCode": jobCode,
    "jobName": jobName,
  };
}
