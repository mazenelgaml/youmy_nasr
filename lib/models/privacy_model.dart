// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';

PrivacyModel privacyModelFromJson(String str) => PrivacyModel.fromJson(json.decode(str));

String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
  List<Datum>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  PrivacyModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
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
  String? privacyCode;
  String? privacyName;
  String? privacyNameAra;
  String? privacyNameEng;
  String? privacyBody;
  dynamic privacyDate;
  dynamic privacyTitle;
  dynamic privacyUrl;
  dynamic synchronizationDate;
  dynamic generalTrxSerial;
  dynamic monthlyTrxSerial;
  dynamic pageCode;
  dynamic pageName;
  bool? isDefault;
  dynamic aboutUsImage;
  dynamic aboutUsImageName;
  dynamic aboutUsImageExtension;
  dynamic aboutUsImageData;
  int? orderId;
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
  dynamic logo;
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
  dynamic isNew;
  dynamic isUpdated;
  dynamic isMuffled;

  Datum({
    this.privacyCode,
    this.privacyName,
    this.privacyNameAra,
    this.privacyNameEng,
    this.privacyBody,
    this.privacyDate,
    this.privacyTitle,
    this.privacyUrl,
    this.synchronizationDate,
    this.generalTrxSerial,
    this.monthlyTrxSerial,
    this.pageCode,
    this.pageName,
    this.isDefault,
    this.aboutUsImage,
    this.aboutUsImageName,
    this.aboutUsImageExtension,
    this.aboutUsImageData,
    this.orderId,
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
    this.userId,
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
    this.isNew,
    this.isUpdated,
    this.isMuffled,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    privacyCode: json["privacyCode"],
    privacyName: json["privacyName"],
    privacyNameAra: json["privacyNameAra"],
    privacyNameEng: json["privacyNameEng"],
    privacyBody: json["privacyBody"],
    privacyDate: json["privacyDate"],
    privacyTitle: json["privacyTitle"],
    privacyUrl: json["privacyUrl"],
    synchronizationDate: json["synchronizationDate"],
    generalTrxSerial: json["generalTrxSerial"],
    monthlyTrxSerial: json["monthlyTrxSerial"],
    pageCode: json["pageCode"],
    pageName: json["pageName"],
    isDefault: json["isDefault"],
    aboutUsImage: json["aboutUsImage"],
    aboutUsImageName: json["aboutUsImageName"],
    aboutUsImageExtension: json["aboutUsImageExtension"],
    aboutUsImageData: json["aboutUsImageData"],
    orderId: json["orderId"],
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
    logo: json["logo"],
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
    isNew: json["isNew"],
    isUpdated: json["isUpdated"],
    isMuffled: json["isMuffled"],
  );

  Map<String, dynamic> toJson() => {
    "privacyCode": privacyCode,
    "privacyName": privacyName,
    "privacyNameAra": privacyNameAra,
    "privacyNameEng": privacyNameEng,
    "privacyBody": privacyBody,
    "privacyDate": privacyDate,
    "privacyTitle": privacyTitle,
    "privacyUrl": privacyUrl,
    "synchronizationDate": synchronizationDate,
    "generalTrxSerial": generalTrxSerial,
    "monthlyTrxSerial": monthlyTrxSerial,
    "pageCode": pageCode,
    "pageName": pageName,
    "isDefault": isDefault,
    "aboutUsImage": aboutUsImage,
    "aboutUsImageName": aboutUsImageName,
    "aboutUsImageExtension": aboutUsImageExtension,
    "aboutUsImageData": aboutUsImageData,
    "orderId": orderId,
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
    "logo": logo,
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
    "isNew": isNew,
    "isUpdated": isUpdated,
    "isMuffled": isMuffled,
  };
}
