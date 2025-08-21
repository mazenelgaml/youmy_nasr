// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  List<Datum>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  NotificationListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  String? userId;
  int? trxCase;
  String? trxType;
  String? trxSerial;
  String? trxTypeName;
  String? description;
  String? transactionId;
  String? transactionMenuId;
  bool? isRead;
  bool? isSeen;
  int? id;
  int? caseCode;
  dynamic baseSyncId;
  int? companyCode;
  dynamic lineNum;
  int? branchCode;
  int? year;
  dynamic descriptionAra;
  dynamic attachment;
  dynamic descriptionEng;
  dynamic requestTypeCode;
  dynamic empCode;
  dynamic notes;
  dynamic notActive;
  dynamic flgDelete;
  dynamic addBy;
  dynamic addTime;
  dynamic editBy;
  dynamic editTime;
  int? menuId;
  dynamic icon;
  dynamic isDeleted;
  dynamic confirmerUserId;
  dynamic isActive;
  dynamic isBlocked;
  dynamic isSystem;
  dynamic isImported;
  dynamic creatorUserId;
  dynamic creatorUserName;
  dynamic creationTime;
  dynamic lastModifierUserId;
  dynamic lastModifierUserName;
  dynamic lastModificationTime;
  dynamic deleterUserId;
  dynamic deleterUserName;
  dynamic glSerial;
  dynamic glType;
  dynamic deletionTime;
  dynamic confirmationTime;
  int? langId;
  dynamic synchronizationStatusCode;
  dynamic insuranceRegisterationReceiveDestinationCode;
  dynamic isSynchronized;
  dynamic postedToGl;
  dynamic confirmed;
  dynamic isPaidFinancialTransaction;
  dynamic isLinkWithTaxAuthority;
  dynamic isEditPrice;
  dynamic synchronizationDate;
  dynamic isNew;
  dynamic isUpdated;
  dynamic isMuffled;

  Datum({
    this.userId,
    this.trxCase,
    this.trxType,
    this.trxSerial,
    this.trxTypeName,
    this.description,
    this.transactionId,
    this.transactionMenuId,
    this.isRead,
    this.isSeen,
    this.id,
    this.caseCode,
    this.baseSyncId,
    this.companyCode,
    this.lineNum,
    this.branchCode,
    this.year,
    this.descriptionAra,
    this.attachment,
    this.descriptionEng,
    this.requestTypeCode,
    this.empCode,
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
    this.synchronizationDate,
    this.isNew,
    this.isUpdated,
    this.isMuffled,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["userId"],
    trxCase: json["trxCase"],
    trxType: json["trxType"],
    trxSerial: json["trxSerial"],
    trxTypeName: json["trxTypeName"],
    description: json["description"],
    transactionId: json["transactionId"],
    transactionMenuId: json["transactionMenuId"],
    isRead: json["isRead"],
    isSeen: json["isSeen"],
    id: json["id"],
    caseCode: json["caseCode"],
    baseSyncId: json["baseSyncId"],
    companyCode: json["companyCode"],
    lineNum: json["lineNum"],
    branchCode: json["branchCode"],
    year: json["year"],
    descriptionAra: json["descriptionAra"],
    attachment: json["attachment"],
    descriptionEng: json["descriptionEng"],
    requestTypeCode: json["requestTypeCode"],
    empCode: json["empCode"],
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
    creationTime: json["creationTime"],
    lastModifierUserId: json["lastModifierUserId"],
    lastModifierUserName: json["lastModifierUserName"],
    lastModificationTime: json["lastModificationTime"],
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
    synchronizationDate: json["synchronizationDate"],
    isNew: json["isNew"],
    isUpdated: json["isUpdated"],
    isMuffled: json["isMuffled"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "trxCase": trxCase,
    "trxType": trxType,
    "trxSerial": trxSerial,
    "trxTypeName": trxTypeName,
    "description": description,
    "transactionId": transactionId,
    "transactionMenuId": transactionMenuId,
    "isRead": isRead,
    "isSeen": isSeen,
    "id": id,
    "caseCode": caseCode,
    "baseSyncId": baseSyncId,
    "companyCode": companyCode,
    "lineNum": lineNum,
    "branchCode": branchCode,
    "year": year,
    "descriptionAra": descriptionAra,
    "attachment": attachment,
    "descriptionEng": descriptionEng,
    "requestTypeCode": requestTypeCode,
    "empCode": empCode,
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
    "creationTime": creationTime,
    "lastModifierUserId": lastModifierUserId,
    "lastModifierUserName": lastModifierUserName,
    "lastModificationTime": lastModificationTime,
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
    "synchronizationDate": synchronizationDate,
    "isNew": isNew,
    "isUpdated": isUpdated,
    "isMuffled": isMuffled,
  };
}
