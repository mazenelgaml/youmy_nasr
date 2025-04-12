// To parse this JSON data, do
//
//     final productsFilterCategoriesModel = productsFilterCategoriesModelFromJson(jsonString);

import 'dart:convert';

ProductsFilterCategoriesModel productsFilterCategoriesModelFromJson(String str) => ProductsFilterCategoriesModel.fromJson(json.decode(str));

String productsFilterCategoriesModelToJson(ProductsFilterCategoriesModel data) => json.encode(data.toJson());

class ProductsFilterCategoriesModel {
  List<FilterCategory>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ProductsFilterCategoriesModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ProductsFilterCategoriesModel.fromJson(Map<String, dynamic> json) => ProductsFilterCategoriesModel(
    data: json["data"] == null ? [] : List<FilterCategory>.from(json["data"]!.map((x) => FilterCategory.fromJson(x))),
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

class FilterCategory {
  int? id;
  String? itemClassCode;
  String? itemClassName;
  String? parentClass;

  FilterCategory({
    this.id,
    this.itemClassCode,
    this.itemClassName,
    this.parentClass,
  });

  factory FilterCategory.fromJson(Map<String, dynamic> json) => FilterCategory(
    id: json["id"],
    itemClassCode: json["itemClassCode"],
    itemClassName: json["itemClassName"],
    parentClass: json["parentClass"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "itemClassCode": itemClassCode,
    "itemClassName": itemClassName,
    "parentClass": parentClass,
  };
}
