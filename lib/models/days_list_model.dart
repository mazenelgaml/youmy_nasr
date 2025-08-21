import 'dart:convert';

DaysListModel daysListModelFromJson(String str) =>
    DaysListModel.fromJson(json.decode(str));

class DaysListModel {
  final List<DaysList> data;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;

  DaysListModel({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory DaysListModel.fromJson(Map<String, dynamic> json) {
    return DaysListModel(
      data: (json["data"] as List<dynamic>?)
          ?.map((x) => DaysList.fromJson(x))
          .toList() ??
          [],
      currentPage: json["currentPage"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
      totalCount: json["totalCount"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      hasPreviousPage: json["hasPreviousPage"] ?? false,
      hasNextPage: json["hasNextPage"] ?? false,
    );
  }
}

class DaysList {
  final int id;
  final int dayCode;
  final String name;

  DaysList({
    required this.id,
    required this.dayCode,
    required this.name,
  });

  factory DaysList.fromJson(Map<String, dynamic> json) {
    return DaysList(
      id: json["id"] ?? 0,
      dayCode: json["dayCode"] ?? 0,
      name: json["name"] ?? '',
    );
  }
}
