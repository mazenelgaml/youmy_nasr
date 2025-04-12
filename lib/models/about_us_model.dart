// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  List<Datum>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  AboutUsModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
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
  String? aboutUsCode;
  String? aboutUsName;
  dynamic aboutUsNameAra;
  dynamic aboutUsNameEng;
  String? aboutUsBody;
  DateTime? aboutUsDate;
  String? aboutUsTitle;
  dynamic aboutUsUrl;
  dynamic generalTrxSerial;
  dynamic monthlyTrxSerial;
  dynamic attachment;
  dynamic glSerial;
  dynamic glType;
  dynamic confirmationTime;
  String? pageCode;
  String? pageName;
  bool? isDefault;
  dynamic aboutUsImage;
  dynamic aboutUsImageName;
  dynamic aboutUsImageExtension;
  dynamic aboutUsImageData;
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
  dynamic empCode;
  dynamic logo;
  dynamic notes;
  bool? notActive;
  bool? flgDelete;
  dynamic addBy;
  DateTime? addTime;
  String? editBy;
  DateTime? editTime;
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
  DateTime? lastModificationTime;
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

  Datum({
    this.aboutUsCode,
    this.aboutUsName,
    this.aboutUsNameAra,
    this.aboutUsNameEng,
    this.aboutUsBody,
    this.aboutUsDate,
    this.aboutUsTitle,
    this.aboutUsUrl,
    this.generalTrxSerial,
    this.monthlyTrxSerial,
    this.attachment,
    this.glSerial,
    this.glType,
    this.confirmationTime,
    this.pageCode,
    this.pageName,
    this.isDefault,
    this.aboutUsImage,
    this.aboutUsImageName,
    this.aboutUsImageExtension,
    this.aboutUsImageData,
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    aboutUsCode: json["aboutUsCode"],
    aboutUsName: json["aboutUsName"],
    aboutUsNameAra: json["aboutUsNameAra"],
    aboutUsNameEng: json["aboutUsNameEng"],
    aboutUsBody: json["aboutUsBody"],
    aboutUsDate: json["aboutUsDate"] == null ? null : DateTime.parse(json["aboutUsDate"]),
    aboutUsTitle: json["aboutUsTitle"],
    aboutUsUrl: json["aboutUsUrl"],
    generalTrxSerial: json["generalTrxSerial"],
    monthlyTrxSerial: json["monthlyTrxSerial"],
    attachment: json["attachment"],
    glSerial: json["glSerial"],
    glType: json["glType"],
    confirmationTime: json["confirmationTime"],
    pageCode: json["pageCode"],
    pageName: json["pageName"],
    isDefault: json["isDefault"],
    aboutUsImage: json["aboutUsImage"],
    aboutUsImageName: json["aboutUsImageName"],
    aboutUsImageExtension: json["aboutUsImageExtension"],
    aboutUsImageData: json["aboutUsImageData"],
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
    empCode: json["empCode"],
    logo: json["logo"],
    notes: json["notes"],
    notActive: json["notActive"],
    flgDelete: json["flgDelete"],
    addBy: json["addBy"],
    addTime: json["addTime"] == null ? null : DateTime.parse(json["addTime"]),
    editBy: json["editBy"],
    editTime: json["editTime"] == null ? null : DateTime.parse(json["editTime"]),
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
    lastModificationTime: json["lastModificationTime"] == null ? null : DateTime.parse(json["lastModificationTime"]),
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
  );

  Map<String, dynamic> toJson() => {
    "aboutUsCode": aboutUsCode,
    "aboutUsName": aboutUsName,
    "aboutUsNameAra": aboutUsNameAra,
    "aboutUsNameEng": aboutUsNameEng,
    "aboutUsBody": aboutUsBody,
    "aboutUsDate": aboutUsDate?.toIso8601String(),
    "aboutUsTitle": aboutUsTitle,
    "aboutUsUrl": aboutUsUrl,
    "generalTrxSerial": generalTrxSerial,
    "monthlyTrxSerial": monthlyTrxSerial,
    "attachment": attachment,
    "glSerial": glSerial,
    "glType": glType,
    "confirmationTime": confirmationTime,
    "pageCode": pageCode,
    "pageName": pageName,
    "isDefault": isDefault,
    "aboutUsImage": aboutUsImage,
    "aboutUsImageName": aboutUsImageName,
    "aboutUsImageExtension": aboutUsImageExtension,
    "aboutUsImageData": aboutUsImageData,
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
    "empCode": empCode,
    "logo": logo,
    "notes": notes,
    "notActive": notActive,
    "flgDelete": flgDelete,
    "addBy": addBy,
    "addTime": addTime?.toIso8601String(),
    "editBy": editBy,
    "editTime": editTime?.toIso8601String(),
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
    "lastModificationTime": lastModificationTime?.toIso8601String(),
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
  };
}
