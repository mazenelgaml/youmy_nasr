// To parse this JSON data, do
//
//     final branchCommentsModel = branchCommentsModelFromJson(jsonString);

import 'dart:convert';

BranchCommentsModel branchCommentsModelFromJson(String str) => BranchCommentsModel.fromJson(json.decode(str));

String branchCommentsModelToJson(BranchCommentsModel data) => json.encode(data.toJson());

class BranchCommentsModel {
  List<CommentsListB>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  BranchCommentsModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory BranchCommentsModel.fromJson(Map<String, dynamic> json) => BranchCommentsModel(
    data: json["data"] == null ? [] : List<CommentsListB>.from(json["data"]!.map((x) => CommentsListB.fromJson(x))),
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

class CommentsListB {
  int? branchCode;
  String? userCode;
  dynamic userName;
  String? comment;
  DateTime? commentDate;
  dynamic synchronizationDate;
  dynamic generalTrxSerial;
  dynamic monthlyTrxSerial;
  dynamic attachmentName;
  bool? isBlackList;
  int? id;
  dynamic baseSyncId;
  int? companyCode;
  dynamic lineNum;
  int? year;
  dynamic descriptionAra;
  dynamic attachment;
  dynamic descriptionEng;
  dynamic requestTypeCode;
  dynamic empCode;
  dynamic logo;
  dynamic notes;
  bool? notActive;
  bool? flgDelete;
  dynamic addBy;
  dynamic addTime;
  dynamic editBy;
  dynamic editTime;
  int? menuId;
  dynamic icon;
  bool? isDeleted;
  dynamic confirmerUserId;
  bool? isActive;
  bool? isBlocked;
  bool? isSystem;
  bool? isImported;
  dynamic creatorUserId;
  dynamic creatorUserName;
  DateTime? creationTime;
  dynamic lastModifierUserId;
  dynamic lastModifierUserName;
  DateTime? lastModificationTime;
  dynamic deleterUserId;
  dynamic deleterUserName;
  dynamic glSerial;
  dynamic glType;
  dynamic deletionTime;
  dynamic confirmationTime;
  int? langId;
  dynamic synchronizationStatusCode;
  dynamic insuranceRegisterationReceiveDestinationCode;
  bool? isSynchronized;
  bool? postedToGl;
  bool? confirmed;
  dynamic isPaidFinancialTransaction;
  bool? isLinkWithTaxAuthority;
  dynamic isEditPrice;

  CommentsListB({
    this.branchCode,
    this.userCode,
    this.userName,
    this.comment,
    this.commentDate,
    this.synchronizationDate,
    this.generalTrxSerial,
    this.monthlyTrxSerial,
    this.attachmentName,
    this.isBlackList,
    this.id,
    this.baseSyncId,
    this.companyCode,
    this.lineNum,
    this.year,
    this.descriptionAra,
    this.attachment,
    this.descriptionEng,
    this.requestTypeCode,
    this.empCode,
    this.logo,
    this.notes,
    this.notActive,
    this.flgDelete,
    this.addBy,
    this.addTime,
    this.editBy,
    this.editTime,
    this.menuId,
    this.icon,
    this.isDeleted,
    this.confirmerUserId,
    this.isActive,
    this.isBlocked,
    this.isSystem,
    this.isImported,
    this.creatorUserId,
    this.creatorUserName,
    this.creationTime,
    this.lastModifierUserId,
    this.lastModifierUserName,
    this.lastModificationTime,
    this.deleterUserId,
    this.deleterUserName,
    this.glSerial,
    this.glType,
    this.deletionTime,
    this.confirmationTime,
    this.langId,
    this.synchronizationStatusCode,
    this.insuranceRegisterationReceiveDestinationCode,
    this.isSynchronized,
    this.postedToGl,
    this.confirmed,
    this.isPaidFinancialTransaction,
    this.isLinkWithTaxAuthority,
    this.isEditPrice,
  });

  factory CommentsListB.fromJson(Map<String, dynamic> json) => CommentsListB(
    branchCode: json["branchCode"],
    userCode: json["userCode"],
    userName: json["userName"],
    comment: json["comment"],
    commentDate: json["commentDate"] == null ? null : DateTime.parse(json["commentDate"]),
    synchronizationDate: json["synchronizationDate"],
    generalTrxSerial: json["generalTrxSerial"],
    monthlyTrxSerial: json["monthlyTrxSerial"],
    attachmentName: json["attachmentName"],
    isBlackList: json["isBlackList"],
    id: json["id"],
    baseSyncId: json["baseSyncId"],
    companyCode: json["companyCode"],
    lineNum: json["lineNum"],
    year: json["year"],
    descriptionAra: json["descriptionAra"],
    attachment: json["attachment"],
    descriptionEng: json["descriptionEng"],
    requestTypeCode: json["requestTypeCode"],
    empCode: json["empCode"],
    logo: json["logo"],
    notes: json["notes"],
    notActive: json["notActive"],
    flgDelete: json["flgDelete"],
    addBy: json["addBy"],
    addTime: json["addTime"],
    editBy: json["editBy"],
    editTime: json["editTime"],
    menuId: json["menuId"],
    icon: json["icon"],
    isDeleted: json["isDeleted"],
    confirmerUserId: json["confirmerUserId"],
    isActive: json["isActive"],
    isBlocked: json["isBlocked"],
    isSystem: json["isSystem"],
    isImported: json["isImported"],
    creatorUserId: json["creatorUserId"],
    creatorUserName: json["creatorUserName"],
    creationTime: json["creationTime"] == null ? null : DateTime.parse(json["creationTime"]),
    lastModifierUserId: json["lastModifierUserId"],
    lastModifierUserName: json["lastModifierUserName"],
    lastModificationTime: json["lastModificationTime"] == null ? null : DateTime.parse(json["lastModificationTime"]),
    deleterUserId: json["deleterUserId"],
    deleterUserName: json["deleterUserName"],
    glSerial: json["glSerial"],
    glType: json["glType"],
    deletionTime: json["deletionTime"],
    confirmationTime: json["confirmationTime"],
    langId: json["langId"],
    synchronizationStatusCode: json["synchronizationStatusCode"],
    insuranceRegisterationReceiveDestinationCode: json["insuranceRegisterationReceiveDestinationCode"],
    isSynchronized: json["isSynchronized"],
    postedToGl: json["postedToGL"],
    confirmed: json["confirmed"],
    isPaidFinancialTransaction: json["isPaidFinancialTransaction"],
    isLinkWithTaxAuthority: json["isLinkWithTaxAuthority"],
    isEditPrice: json["isEditPrice"],
  );

  Map<String, dynamic> toJson() => {
    "branchCode": branchCode,
    "userCode": userCode,
    "userName": userName,
    "comment": comment,
    "commentDate": commentDate?.toIso8601String(),
    "synchronizationDate": synchronizationDate,
    "generalTrxSerial": generalTrxSerial,
    "monthlyTrxSerial": monthlyTrxSerial,
    "attachmentName": attachmentName,
    "isBlackList": isBlackList,
    "id": id,
    "baseSyncId": baseSyncId,
    "companyCode": companyCode,
    "lineNum": lineNum,
    "year": year,
    "descriptionAra": descriptionAra,
    "attachment": attachment,
    "descriptionEng": descriptionEng,
    "requestTypeCode": requestTypeCode,
    "empCode": empCode,
    "logo": logo,
    "notes": notes,
    "notActive": notActive,
    "flgDelete": flgDelete,
    "addBy": addBy,
    "addTime": addTime,
    "editBy": editBy,
    "editTime": editTime,
    "menuId": menuId,
    "icon": icon,
    "isDeleted": isDeleted,
    "confirmerUserId": confirmerUserId,
    "isActive": isActive,
    "isBlocked": isBlocked,
    "isSystem": isSystem,
    "isImported": isImported,
    "creatorUserId": creatorUserId,
    "creatorUserName": creatorUserName,
    "creationTime": creationTime?.toIso8601String(),
    "lastModifierUserId": lastModifierUserId,
    "lastModifierUserName": lastModifierUserName,
    "lastModificationTime": lastModificationTime?.toIso8601String(),
    "deleterUserId": deleterUserId,
    "deleterUserName": deleterUserName,
    "glSerial": glSerial,
    "glType": glType,
    "deletionTime": deletionTime,
    "confirmationTime": confirmationTime,
    "langId": langId,
    "synchronizationStatusCode": synchronizationStatusCode,
    "insuranceRegisterationReceiveDestinationCode": insuranceRegisterationReceiveDestinationCode,
    "isSynchronized": isSynchronized,
    "postedToGL": postedToGl,
    "confirmed": confirmed,
    "isPaidFinancialTransaction": isPaidFinancialTransaction,
    "isLinkWithTaxAuthority": isLinkWithTaxAuthority,
    "isEditPrice": isEditPrice,
  };
}
