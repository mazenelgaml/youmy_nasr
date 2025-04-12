// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromJson(jsonString);

import 'dart:convert';

CompanyListModel companyListModelFromJson(String str) => CompanyListModel.fromJson(json.decode(str));

String companyListModelToJson(CompanyListModel data) => json.encode(data.toJson());

class CompanyListModel {
  List<Company>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CompanyListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
    data: json["data"] == null ? [] : List<Company>.from(json["data"]!.map((x) => Company.fromJson(x))),
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

class Company {
  String? companyNameAra;
  String? companyNameEng;
  bool? isDefult;
  int? businessTypeId;
  dynamic mobile;
  dynamic logo;
  String? logoImage;
  dynamic fax;
  dynamic postalCode;
  dynamic postalName;
  dynamic webSite;
  String? eMail;
  String? address;
  int? startYear;
  DateTime? startDate;
  String? taxId;
  dynamic commercialId;
  dynamic vendorCode;
  bool? isShowLogInLogin;
  dynamic elEActivityTypeCode;
  dynamic elEActivityTypeName;
  dynamic elETaxRegistrationNumber;
  dynamic elECompanyTypeCode;
  dynamic elECompanyTypeName;
  bool? isSeparateCompany;
  String? sourceCompanyCode;
  dynamic sourceCompanyName;
  String? databaseServerName;
  String? databaseUserName;
  String? databasePassword;
  String? databaseName;
  String? reportPath;
  String? attachmentPath;
  String? backupPath;
  String? applicationCountryCode;
  dynamic applicationCountryName;
  dynamic databasePath;
  String? companyTypeCode;
  dynamic companyTypeName;
  dynamic faceBook;
  dynamic twitter;
  dynamic youtube;
  dynamic androidApp;
  dynamic iosApp;
  String? street;
  String? building;
  String? apartment;
  String? floor;
  dynamic address1;
  String? latitude;
  String? longitude;
  String? addressOnMap;
  String? mobile1;
  String? mobile2;
  String? tel1;
  String? tel2;
  dynamic fax1;
  String? postalCode1;
  String? eMail1;
  String? webSite1;
  dynamic buildingNo;
  int? countryId;
  int? cityCode;
  dynamic cityName;
  int? zoneCode;
  dynamic zoneName;
  dynamic address2;
  dynamic storePaymentMethodList;
  dynamic storeWorkDayList;
  int? id;
  dynamic baseSyncId;
  int? companyCode;
  dynamic lineNum;
  int? branchCode;
  int? year;
  String? descriptionAra;
  dynamic attachment;
  String? descriptionEng;
  dynamic requestTypeCode;
  dynamic empCode;
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
  dynamic isSynchronized;
  dynamic postedToGl;
  dynamic confirmed;
  dynamic isPaidFinancialTransaction;
  dynamic isLinkWithTaxAuthority;
  dynamic isEditPrice;
  dynamic synchronizationDate;

  Company({
    this.companyNameAra,
    this.companyNameEng,
    this.isDefult,
    this.businessTypeId,
    this.mobile,
    this.logo,
    this.logoImage,
    this.fax,
    this.postalCode,
    this.postalName,
    this.webSite,
    this.eMail,
    this.address,
    this.startYear,
    this.startDate,
    this.taxId,
    this.commercialId,
    this.vendorCode,
    this.isShowLogInLogin,
    this.elEActivityTypeCode,
    this.elEActivityTypeName,
    this.elETaxRegistrationNumber,
    this.elECompanyTypeCode,
    this.elECompanyTypeName,
    this.isSeparateCompany,
    this.sourceCompanyCode,
    this.sourceCompanyName,
    this.databaseServerName,
    this.databaseUserName,
    this.databasePassword,
    this.databaseName,
    this.reportPath,
    this.attachmentPath,
    this.backupPath,
    this.applicationCountryCode,
    this.applicationCountryName,
    this.databasePath,
    this.companyTypeCode,
    this.companyTypeName,
    this.faceBook,
    this.twitter,
    this.youtube,
    this.androidApp,
    this.iosApp,
    this.street,
    this.building,
    this.apartment,
    this.floor,
    this.address1,
    this.latitude,
    this.longitude,
    this.addressOnMap,
    this.mobile1,
    this.mobile2,
    this.tel1,
    this.tel2,
    this.fax1,
    this.postalCode1,
    this.eMail1,
    this.webSite1,
    this.buildingNo,
    this.countryId,
    this.cityCode,
    this.cityName,
    this.zoneCode,
    this.zoneName,
    this.address2,
    this.storePaymentMethodList,
    this.storeWorkDayList,
    this.id,
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
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    companyNameAra: json["companyNameAra"],
    companyNameEng: json["companyNameEng"],
    isDefult: json["isDefult"],
    businessTypeId: json["businessTypeID"],
    mobile: json["mobile"],
    logo: json["logo"],
    logoImage: json["logoImage"],
    fax: json["fax"],
    postalCode: json["postalCode"],
    postalName: json["postalName"],
    webSite: json["webSite"],
    eMail: json["eMail"],
    address: json["address"],
    startYear: json["startYear"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    taxId: json["taxID"],
    commercialId: json["commercialID"],
    vendorCode: json["vendorCode"],
    isShowLogInLogin: json["isShowLogInLogin"],
    elEActivityTypeCode: json["elEActivityTypeCode"],
    elEActivityTypeName: json["elEActivityTypeName"],
    elETaxRegistrationNumber: json["elETaxRegistrationNumber"],
    elECompanyTypeCode: json["elECompanyTypeCode"],
    elECompanyTypeName: json["elECompanyTypeName"],
    isSeparateCompany: json["isSeparateCompany"],
    sourceCompanyCode: json["sourceCompanyCode"],
    sourceCompanyName: json["sourceCompanyName"],
    databaseServerName: json["databaseServerName"],
    databaseUserName: json["databaseUserName"],
    databasePassword: json["databasePassword"],
    databaseName: json["databaseName"],
    reportPath: json["reportPath"],
    attachmentPath: json["attachmentPath"],
    backupPath: json["backupPath"],
    applicationCountryCode: json["applicationCountryCode"],
    applicationCountryName: json["applicationCountryName"],
    databasePath: json["databasePath"],
    companyTypeCode: json["companyTypeCode"],
    companyTypeName: json["companyTypeName"],
    faceBook: json["faceBook"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    androidApp: json["androidApp"],
    iosApp: json["iosApp"],
    street: json["street"],
    building: json["building"],
    apartment: json["apartment"],
    floor: json["floor"],
    address1: json["address1"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    addressOnMap: json["addressOnMap"],
    mobile1: json["mobile1"],
    mobile2: json["mobile2"],
    tel1: json["tel1"],
    tel2: json["tel2"],
    fax1: json["fax1"],
    postalCode1: json["postalCode1"],
    eMail1: json["eMail1"],
    webSite1: json["webSite1"],
    buildingNo: json["buildingNo"],
    countryId: json["countryID"],
    cityCode: json["cityCode"],
    cityName: json["cityName"],
    zoneCode: json["zoneCode"],
    zoneName: json["zoneName"],
    address2: json["address2"],
    storePaymentMethodList: json["storePaymentMethodList"],
    storeWorkDayList: json["storeWorkDayList"],
    id: json["id"],
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
    synchronizationDate: json["synchronizationDate"],
  );

  Map<String, dynamic> toJson() => {
    "companyNameAra": companyNameAra,
    "companyNameEng": companyNameEng,
    "isDefult": isDefult,
    "businessTypeID": businessTypeId,
    "mobile": mobile,
    "logo": logo,
    "logoImage": logoImage,
    "fax": fax,
    "postalCode": postalCode,
    "postalName": postalName,
    "webSite": webSite,
    "eMail": eMail,
    "address": address,
    "startYear": startYear,
    "startDate": startDate?.toIso8601String(),
    "taxID": taxId,
    "commercialID": commercialId,
    "vendorCode": vendorCode,
    "isShowLogInLogin": isShowLogInLogin,
    "elEActivityTypeCode": elEActivityTypeCode,
    "elEActivityTypeName": elEActivityTypeName,
    "elETaxRegistrationNumber": elETaxRegistrationNumber,
    "elECompanyTypeCode": elECompanyTypeCode,
    "elECompanyTypeName": elECompanyTypeName,
    "isSeparateCompany": isSeparateCompany,
    "sourceCompanyCode": sourceCompanyCode,
    "sourceCompanyName": sourceCompanyName,
    "databaseServerName": databaseServerName,
    "databaseUserName": databaseUserName,
    "databasePassword": databasePassword,
    "databaseName": databaseName,
    "reportPath": reportPath,
    "attachmentPath": attachmentPath,
    "backupPath": backupPath,
    "applicationCountryCode": applicationCountryCode,
    "applicationCountryName": applicationCountryName,
    "databasePath": databasePath,
    "companyTypeCode": companyTypeCode,
    "companyTypeName": companyTypeName,
    "faceBook": faceBook,
    "twitter": twitter,
    "youtube": youtube,
    "androidApp": androidApp,
    "iosApp": iosApp,
    "street": street,
    "building": building,
    "apartment": apartment,
    "floor": floor,
    "address1": address1,
    "latitude": latitude,
    "longitude": longitude,
    "addressOnMap": addressOnMap,
    "mobile1": mobile1,
    "mobile2": mobile2,
    "tel1": tel1,
    "tel2": tel2,
    "fax1": fax1,
    "postalCode1": postalCode1,
    "eMail1": eMail1,
    "webSite1": webSite1,
    "buildingNo": buildingNo,
    "countryID": countryId,
    "cityCode": cityCode,
    "cityName": cityName,
    "zoneCode": zoneCode,
    "zoneName": zoneName,
    "address2": address2,
    "storePaymentMethodList": storePaymentMethodList,
    "storeWorkDayList": storeWorkDayList,
    "id": id,
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
    "synchronizationDate": synchronizationDate,
  };
}
