// To parse this JSON data, do
//
//     final productsGroupsListModel = productsGroupsListModelFromJson(jsonString);

import 'dart:convert';

ProductsGroupsListModel productsGroupsListModelFromJson(String str) => ProductsGroupsListModel.fromJson(json.decode(str));

String productsGroupsListModelToJson(ProductsGroupsListModel data) => json.encode(data.toJson());

class ProductsGroupsListModel {
  List<ProductGroups>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ProductsGroupsListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ProductsGroupsListModel.fromJson(Map<String, dynamic> json) => ProductsGroupsListModel(
    data: json["data"] == null ? [] : List<ProductGroups>.from(json["data"]!.map((x) => ProductGroups.fromJson(x))),
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

class ProductGroups {
  int? id;
  int? companyCode;
  String? itemGroupCode;
  int? branchCode;
  String? itemGroupNameAra;
  String? itemGroupNameEng;
  dynamic descriptionAra;
  dynamic descriptionEng;
  String? parentGroup;
  int? taxPositionCode;
  int? discountPercent;
  String? accountCode;
  String? projectCode;
  String? departmentCode;
  String? budgetCode;
  String? journalCode;
  String? costCenterCode;
  bool? notActive;
  bool? flgDelete;
  String? notes;
  String? addBy;
  DateTime? addTime;
  String? editBy;
  DateTime? editTime;
  int? menuId;
  String? groupImage;
  int? levelNo;
  int? itemGroupNatureCode;
  String? itemGroupRootCode;
  String? itemGroupRootNameAra;
  String? itemGroupRootNameEng;

  ProductGroups({
    this.id,
    this.companyCode,
    this.itemGroupCode,
    this.branchCode,
    this.itemGroupNameAra,
    this.itemGroupNameEng,
    this.descriptionAra,
    this.descriptionEng,
    this.parentGroup,
    this.taxPositionCode,
    this.discountPercent,
    this.accountCode,
    this.projectCode,
    this.departmentCode,
    this.budgetCode,
    this.journalCode,
    this.costCenterCode,
    this.notActive,
    this.flgDelete,
    this.notes,
    this.addBy,
    this.addTime,
    this.editBy,
    this.editTime,
    this.menuId,
    this.groupImage,
    this.levelNo,
    this.itemGroupNatureCode,
    this.itemGroupRootCode,
    this.itemGroupRootNameAra,
    this.itemGroupRootNameEng,
  });

  factory ProductGroups.fromJson(Map<String, dynamic> json) => ProductGroups(
    id: json["id"],
    companyCode: json["companyCode"],
    itemGroupCode: json["itemGroupCode"],
    branchCode: json["branchCode"],
    itemGroupNameAra: json["itemGroupNameAra"],
    itemGroupNameEng: json["itemGroupNameEng"],
    descriptionAra: json["descriptionAra"],
    descriptionEng: json["descriptionEng"],
    parentGroup: json["parentGroup"],
    taxPositionCode: json["taxPositionCode"],
    discountPercent: json["discountPercent"],
    accountCode: json["accountCode"],
    projectCode: json["projectCode"],
    departmentCode: json["departmentCode"],
    budgetCode: json["budgetCode"],
    journalCode: json["journalCode"],
    costCenterCode: json["costCenterCode"],
    notActive: json["notActive"],
    flgDelete: json["flgDelete"],
    notes: json["notes"],
    addBy: json["addBy"],
    addTime: json["addTime"] == null ? null : DateTime.parse(json["addTime"]),
    editBy: json["editBy"],
    editTime: json["editTime"] == null ? null : DateTime.parse(json["editTime"]),
    menuId: json["menuId"],
    groupImage: json["groupImage"],
    levelNo: json["levelNo"],
    itemGroupNatureCode: json["itemGroupNatureCode"],
    itemGroupRootCode: json["itemGroupRootCode"],
    itemGroupRootNameAra: json["itemGroupRootNameAra"],
    itemGroupRootNameEng: json["itemGroupRootNameEng"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyCode": companyCode,
    "itemGroupCode": itemGroupCode,
    "branchCode": branchCode,
    "itemGroupNameAra": itemGroupNameAra,
    "itemGroupNameEng": itemGroupNameEng,
    "descriptionAra": descriptionAra,
    "descriptionEng": descriptionEng,
    "parentGroup": parentGroup,
    "taxPositionCode": taxPositionCode,
    "discountPercent": discountPercent,
    "accountCode": accountCode,
    "projectCode": projectCode,
    "departmentCode": departmentCode,
    "budgetCode": budgetCode,
    "journalCode": journalCode,
    "costCenterCode": costCenterCode,
    "notActive": notActive,
    "flgDelete": flgDelete,
    "notes": notes,
    "addBy": addBy,
    "addTime": addTime?.toIso8601String(),
    "editBy": editBy,
    "editTime": editTime?.toIso8601String(),
    "menuId": menuId,
    "groupImage": groupImage,
    "levelNo": levelNo,
    "itemGroupNatureCode": itemGroupNatureCode,
    "itemGroupRootCode": itemGroupRootCode,
    "itemGroupRootNameAra": itemGroupRootNameAra,
    "itemGroupRootNameEng": itemGroupRootNameEng,
  };
}
