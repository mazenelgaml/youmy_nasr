// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  List<Datum>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ContactUsModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
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
  String? contactUsCode;
  String? contactUsName;
  String? contactUsNameAra;
  String? contactUsNameEng;
  String? contactUsBody;
  DateTime? contactUsDate;
  dynamic contactUsTitle;
  dynamic contactUsEmail;
  dynamic contactUsUrl;
  dynamic generalTrxSerial;
  dynamic monthlyTrxSerial;
  dynamic attachment;
  dynamic glSerial;
  dynamic glType;
  dynamic confirmationTime;
  bool? isDefault;
  dynamic contactUsImage;
  dynamic contactUsImageName;
  dynamic contactUsImageExtension;
  dynamic contactUsImageData;
  String? phone1;
  String? phone2;
  String? phone3;
  String? pageCode;
  String? pageName;
  int? id;
  int? caseCode;
  dynamic baseSyncId;
  int? companyCode;
  dynamic lineNum;
  int? branchCode;
  int? year;
  dynamic descriptionAra;
  dynamic descriptionEng;
  dynamic requestTypeCode;
  dynamic shipmentStatusColor;
  dynamic empCode;
  dynamic notes;
  bool? notActive;
  bool? flgDelete;
  dynamic addBy;
  DateTime? addTime;
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
  dynamic userId;
  dynamic creatorUserId;
  dynamic creatorUserName;
  DateTime? creationTime;
  dynamic lastModifierUserId;
  dynamic lastModifierUserName;
  dynamic lastModificationTime;
  dynamic deleterUserId;
  dynamic deleterUserName;
  dynamic deletionTime;
  int? langId;
  dynamic synchronizationStatusCode;
  dynamic insuranceRegisterationReceiveDestinationCode;
  bool? isSynchronized;
  bool? postedToGl;
  bool? confirmed;
  dynamic isPaidFinancialTransaction;
  bool? isLinkWithTaxAuthority;
  dynamic isEditPrice;
  dynamic synchronizationDate;
  dynamic isNew;
  dynamic isUpdated;
  dynamic isMuffled;
  dynamic tableName;

  Datum({
    this.contactUsCode,
    this.contactUsName,
    this.contactUsNameAra,
    this.contactUsNameEng,
    this.contactUsBody,
    this.contactUsDate,
    this.contactUsTitle,
    this.contactUsEmail,
    this.contactUsUrl,
    this.generalTrxSerial,
    this.monthlyTrxSerial,
    this.attachment,
    this.glSerial,
    this.glType,
    this.confirmationTime,
    this.isDefault,
    this.contactUsImage,
    this.contactUsImageName,
    this.contactUsImageExtension,
    this.contactUsImageData,
    this.phone1,
    this.phone2,
    this.phone3,
    this.pageCode,
    this.pageName,
    this.id,
    this.caseCode,
    this.baseSyncId,
    this.companyCode,
    this.lineNum,
    this.branchCode,
    this.year,
    this.descriptionAra,
    this.descriptionEng,
    this.requestTypeCode,
    this.shipmentStatusColor,
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
    this.userId,
    this.creatorUserId,
    this.creatorUserName,
    this.creationTime,
    this.lastModifierUserId,
    this.lastModifierUserName,
    this.lastModificationTime,
    this.deleterUserId,
    this.deleterUserName,
    this.deletionTime,
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
    this.tableName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    contactUsCode: json["contactUsCode"],
    contactUsName: json["contactUsName"],
    contactUsNameAra: json["contactUsNameAra"],
    contactUsNameEng: json["contactUsNameEng"],
    contactUsBody: json["contactUsBody"],
    contactUsDate: json["contactUsDate"] == null ? null : DateTime.parse(json["contactUsDate"]),
    contactUsTitle: json["contactUsTitle"],
    contactUsEmail: json["contactUsEmail"],
    contactUsUrl: json["contactUsUrl"],
    generalTrxSerial: json["generalTrxSerial"],
    monthlyTrxSerial: json["monthlyTrxSerial"],
    attachment: json["attachment"],
    glSerial: json["glSerial"],
    glType: json["glType"],
    confirmationTime: json["confirmationTime"],
    isDefault: json["isDefault"],
    contactUsImage: json["contactUsImage"],
    contactUsImageName: json["contactUsImageName"],
    contactUsImageExtension: json["contactUsImageExtension"],
    contactUsImageData: json["contactUsImageData"],
    phone1: json["phone1"],
    phone2: json["phone2"],
    phone3: json["phone3"],
    pageCode: json["pageCode"],
    pageName: json["pageName"],
    id: json["id"],
    caseCode: json["caseCode"],
    baseSyncId: json["baseSyncId"],
    companyCode: json["companyCode"],
    lineNum: json["lineNum"],
    branchCode: json["branchCode"],
    year: json["year"],
    descriptionAra: json["descriptionAra"],
    descriptionEng: json["descriptionEng"],
    requestTypeCode: json["requestTypeCode"],
    shipmentStatusColor: json["shipmentStatusColor"],
    empCode: json["empCode"],
    notes: json["notes"],
    notActive: json["notActive"],
    flgDelete: json["flgDelete"],
    addBy: json["addBy"],
    addTime: json["addTime"] == null ? null : DateTime.parse(json["addTime"]),
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
    userId: json["userId"],
    creatorUserId: json["creatorUserId"],
    creatorUserName: json["creatorUserName"],
    creationTime: json["creationTime"] == null ? null : DateTime.parse(json["creationTime"]),
    lastModifierUserId: json["lastModifierUserId"],
    lastModifierUserName: json["lastModifierUserName"],
    lastModificationTime: json["lastModificationTime"],
    deleterUserId: json["deleterUserId"],
    deleterUserName: json["deleterUserName"],
    deletionTime: json["deletionTime"],
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
    tableName: json["tableName"],
  );

  Map<String, dynamic> toJson() => {
    "contactUsCode": contactUsCode,
    "contactUsName": contactUsName,
    "contactUsNameAra": contactUsNameAra,
    "contactUsNameEng": contactUsNameEng,
    "contactUsBody": contactUsBody,
    "contactUsDate": contactUsDate?.toIso8601String(),
    "contactUsTitle": contactUsTitle,
    "contactUsEmail": contactUsEmail,
    "contactUsUrl": contactUsUrl,
    "generalTrxSerial": generalTrxSerial,
    "monthlyTrxSerial": monthlyTrxSerial,
    "attachment": attachment,
    "glSerial": glSerial,
    "glType": glType,
    "confirmationTime": confirmationTime,
    "isDefault": isDefault,
    "contactUsImage": contactUsImage,
    "contactUsImageName": contactUsImageName,
    "contactUsImageExtension": contactUsImageExtension,
    "contactUsImageData": contactUsImageData,
    "phone1": phone1,
    "phone2": phone2,
    "phone3": phone3,
    "pageCode": pageCode,
    "pageName": pageName,
    "id": id,
    "caseCode": caseCode,
    "baseSyncId": baseSyncId,
    "companyCode": companyCode,
    "lineNum": lineNum,
    "branchCode": branchCode,
    "year": year,
    "descriptionAra": descriptionAra,
    "descriptionEng": descriptionEng,
    "requestTypeCode": requestTypeCode,
    "shipmentStatusColor": shipmentStatusColor,
    "empCode": empCode,
    "notes": notes,
    "notActive": notActive,
    "flgDelete": flgDelete,
    "addBy": addBy,
    "addTime": addTime?.toIso8601String(),
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
    "userId": userId,
    "creatorUserId": creatorUserId,
    "creatorUserName": creatorUserName,
    "creationTime": creationTime?.toIso8601String(),
    "lastModifierUserId": lastModifierUserId,
    "lastModifierUserName": lastModifierUserName,
    "lastModificationTime": lastModificationTime,
    "deleterUserId": deleterUserId,
    "deleterUserName": deleterUserName,
    "deletionTime": deletionTime,
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
    "tableName": tableName,
  };
}
