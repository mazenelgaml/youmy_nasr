// To parse this JSON data, do
//
//     final branchesLoginModel = branchesLoginModelFromJson(jsonString);

import 'dart:convert';

BranchesLoginModel branchesLoginModelFromJson(String str) => BranchesLoginModel.fromJson(json.decode(str));

String branchesLoginModelToJson(BranchesLoginModel data) => json.encode(data.toJson());

class BranchesLoginModel {
  List<BranchesLogin>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  BranchesLoginModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory BranchesLoginModel.fromJson(Map<String, dynamic> json) => BranchesLoginModel(
    data: json["data"] == null ? [] : List<BranchesLogin>.from(json["data"]!.map((x) => BranchesLogin.fromJson(x))),
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

class BranchesLogin {
  int? id;
  int? companyCode;
  int? branchCode;
  String? branchNameAra;
  String? branchNameEng;
  String? branchName;
  bool? isDefult;
  dynamic mobile;
  dynamic logo;
  dynamic fax;
  dynamic postalCode;
  dynamic postalName;
  dynamic webSite;
  dynamic eMail;
  dynamic address;
  String? commercialName;
  String? taxNumber;
  dynamic countryCode;
  dynamic countryName;
  dynamic cityCode;
  dynamic cityName;
  dynamic regionCode;
  dynamic regionName;
  dynamic buildingNumber;
  dynamic floorNumber;
  dynamic roomNumber;
  dynamic landmark;
  dynamic eleBranchId;
  dynamic cashSalesAccountCode;
  dynamic cashSalesAccountName;
  dynamic postponeSalesAccountCode;
  dynamic postponeSalesAccountName;
  dynamic creditSalesAccountCode;
  dynamic creditSalesAccountName;
  dynamic salesDiscountAccountCode;
  dynamic salesDiscountAccountName;
  dynamic downPaymentAccountCode;
  dynamic downPaymentAccountName;
  int? defaultEmailSettingCode;
  dynamic defaultEmailSettingName;
  int? defaultWhatsAppSettingCode;
  dynamic defaultWhatsAppSettingName;
  dynamic postingSettingCode;
  dynamic postingSettingName;
  dynamic defaultTaxGroupCode;
  dynamic defaultTaxGroupName;
  dynamic branchTypeCode;
  dynamic branchTypeName;
  dynamic faceBook;
  dynamic twitter;
  dynamic youtube;
  dynamic androidApp;
  dynamic iosApp;
  dynamic street;
  dynamic building;
  dynamic apartment;
  dynamic floor;
  dynamic address1;
  dynamic latitude;
  dynamic longitude;
  dynamic locationCoordinates;
  dynamic instagram;
  dynamic addressOnMap;
  dynamic mobile1;
  dynamic mobile2;
  dynamic tel1;
  dynamic tel2;
  String? fax1;
  String? eMail1;
  String? webSite1;
  dynamic buildingNo;
  int? countryId;
  int? cityCode1;
  int? zoneCode;
  dynamic zoneName;
  dynamic address2;
  dynamic year;
  dynamic descriptionAra;
  dynamic descriptionEng;
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
  dynamic deletionTime;
  dynamic langId;
  dynamic branchImage;
  String? branchImageName;
  String? branchImageExtension;
  String? branchImageData;
  dynamic tiktok;

  BranchesLogin({
    this.id,
    this.companyCode,
    this.branchCode,
    this.branchNameAra,
    this.branchNameEng,
    this.branchName,
    this.isDefult,
    this.mobile,
    this.logo,
    this.fax,
    this.postalCode,
    this.postalName,
    this.webSite,
    this.eMail,
    this.address,
    this.commercialName,
    this.taxNumber,
    this.countryCode,
    this.countryName,
    this.cityCode,
    this.cityName,
    this.regionCode,
    this.regionName,
    this.buildingNumber,
    this.floorNumber,
    this.roomNumber,
    this.landmark,
    this.eleBranchId,
    this.cashSalesAccountCode,
    this.cashSalesAccountName,
    this.postponeSalesAccountCode,
    this.postponeSalesAccountName,
    this.creditSalesAccountCode,
    this.creditSalesAccountName,
    this.salesDiscountAccountCode,
    this.salesDiscountAccountName,
    this.downPaymentAccountCode,
    this.downPaymentAccountName,
    this.defaultEmailSettingCode,
    this.defaultEmailSettingName,
    this.defaultWhatsAppSettingCode,
    this.defaultWhatsAppSettingName,
    this.postingSettingCode,
    this.postingSettingName,
    this.defaultTaxGroupCode,
    this.defaultTaxGroupName,
    this.branchTypeCode,
    this.branchTypeName,
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
    this.locationCoordinates,
    this.instagram,
    this.addressOnMap,
    this.mobile1,
    this.mobile2,
    this.tel1,
    this.tel2,
    this.fax1,
    this.eMail1,
    this.webSite1,
    this.buildingNo,
    this.countryId,
    this.cityCode1,
    this.zoneCode,
    this.zoneName,
    this.address2,
    this.year,
    this.descriptionAra,
    this.descriptionEng,
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
    this.deletionTime,
    this.langId,
    this.branchImage,
    this.branchImageName,
    this.branchImageExtension,
    this.branchImageData,
    this.tiktok,
  });

  factory BranchesLogin.fromJson(Map<String, dynamic> json) => BranchesLogin(
    id: json["id"],
    companyCode: json["companyCode"],
    branchCode: json["branchCode"],
    branchNameAra: json["branchNameAra"],
    branchNameEng: json["branchNameEng"],
    branchName: json["branchName"],
    isDefult: json["isDefult"],
    mobile: json["mobile"],
    logo: json["logo"],
    fax: json["fax"],
    postalCode: json["postalCode"],
    postalName: json["postalName"],
    webSite: json["webSite"],
    eMail: json["eMail"],
    address: json["address"],
    commercialName: json["commercialName"],
    taxNumber: json["taxNumber"],
    countryCode: json["countryCode"],
    countryName: json["countryName"],
    cityCode: json["cityCode"],
    cityName: json["cityName"],
    regionCode: json["regionCode"],
    regionName: json["regionName"],
    buildingNumber: json["buildingNumber"],
    floorNumber: json["floorNumber"],
    roomNumber: json["roomNumber"],
    landmark: json["landmark"],
    eleBranchId: json["eleBranchId"],
    cashSalesAccountCode: json["cashSalesAccountCode"],
    cashSalesAccountName: json["cashSalesAccountName"],
    postponeSalesAccountCode: json["postponeSalesAccountCode"],
    postponeSalesAccountName: json["postponeSalesAccountName"],
    creditSalesAccountCode: json["creditSalesAccountCode"],
    creditSalesAccountName: json["creditSalesAccountName"],
    salesDiscountAccountCode: json["salesDiscountAccountCode"],
    salesDiscountAccountName: json["salesDiscountAccountName"],
    downPaymentAccountCode: json["downPaymentAccountCode"],
    downPaymentAccountName: json["downPaymentAccountName"],
    defaultEmailSettingCode: json["defaultEmailSettingCode"],
    defaultEmailSettingName: json["defaultEmailSettingName"],
    defaultWhatsAppSettingCode: json["defaultWhatsAppSettingCode"],
    defaultWhatsAppSettingName: json["defaultWhatsAppSettingName"],
    postingSettingCode: json["postingSettingCode"],
    postingSettingName: json["postingSettingName"],
    defaultTaxGroupCode: json["defaultTaxGroupCode"],
    defaultTaxGroupName: json["defaultTaxGroupName"],
    branchTypeCode: json["branchTypeCode"],
    branchTypeName: json["branchTypeName"],
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
    locationCoordinates: json["locationCoordinates"],
    instagram: json["instagram"],
    addressOnMap: json["addressOnMap"],
    mobile1: json["mobile1"],
    mobile2: json["mobile2"],
    tel1: json["tel1"],
    tel2: json["tel2"],
    fax1: json["fax1"],
    eMail1: json["eMail1"],
    webSite1: json["webSite1"],
    buildingNo: json["buildingNo"],
    countryId: json["countryID"],
    cityCode1: json["cityCode1"],
    zoneCode: json["zoneCode"],
    zoneName: json["zoneName"],
    address2: json["address2"],
    year: json["year"],
    descriptionAra: json["descriptionAra"],
    descriptionEng: json["descriptionEng"],
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
    deletionTime: json["deletionTime"],
    langId: json["langId"],
    branchImage: json["branchImage"],
    branchImageName: json["branchImageName"],
    branchImageExtension: json["branchImageExtension"],
    branchImageData: json["branchImageData"],
    tiktok: json["tiktok"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyCode": companyCode,
    "branchCode": branchCode,
    "branchNameAra": branchNameAra,
    "branchNameEng": branchNameEng,
    "branchName": branchName,
    "isDefult": isDefult,
    "mobile": mobile,
    "logo": logo,
    "fax": fax,
    "postalCode": postalCode,
    "postalName": postalName,
    "webSite": webSite,
    "eMail": eMail,
    "address": address,
    "commercialName": commercialName,
    "taxNumber": taxNumber,
    "countryCode": countryCode,
    "countryName": countryName,
    "cityCode": cityCode,
    "cityName": cityName,
    "regionCode": regionCode,
    "regionName": regionName,
    "buildingNumber": buildingNumber,
    "floorNumber": floorNumber,
    "roomNumber": roomNumber,
    "landmark": landmark,
    "eleBranchId": eleBranchId,
    "cashSalesAccountCode": cashSalesAccountCode,
    "cashSalesAccountName": cashSalesAccountName,
    "postponeSalesAccountCode": postponeSalesAccountCode,
    "postponeSalesAccountName": postponeSalesAccountName,
    "creditSalesAccountCode": creditSalesAccountCode,
    "creditSalesAccountName": creditSalesAccountName,
    "salesDiscountAccountCode": salesDiscountAccountCode,
    "salesDiscountAccountName": salesDiscountAccountName,
    "downPaymentAccountCode": downPaymentAccountCode,
    "downPaymentAccountName": downPaymentAccountName,
    "defaultEmailSettingCode": defaultEmailSettingCode,
    "defaultEmailSettingName": defaultEmailSettingName,
    "defaultWhatsAppSettingCode": defaultWhatsAppSettingCode,
    "defaultWhatsAppSettingName": defaultWhatsAppSettingName,
    "postingSettingCode": postingSettingCode,
    "postingSettingName": postingSettingName,
    "defaultTaxGroupCode": defaultTaxGroupCode,
    "defaultTaxGroupName": defaultTaxGroupName,
    "branchTypeCode": branchTypeCode,
    "branchTypeName": branchTypeName,
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
    "locationCoordinates": locationCoordinates,
    "instagram": instagram,
    "addressOnMap": addressOnMap,
    "mobile1": mobile1,
    "mobile2": mobile2,
    "tel1": tel1,
    "tel2": tel2,
    "fax1": fax1,
    "eMail1": eMail1,
    "webSite1": webSite1,
    "buildingNo": buildingNo,
    "countryID": countryId,
    "cityCode1": cityCode1,
    "zoneCode": zoneCode,
    "zoneName": zoneName,
    "address2": address2,
    "year": year,
    "descriptionAra": descriptionAra,
    "descriptionEng": descriptionEng,
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
    "deletionTime": deletionTime,
    "langId": langId,
    "branchImage": branchImage,
    "branchImageName": branchImageName,
    "branchImageExtension": branchImageExtension,
    "branchImageData": branchImageData,
    "tiktok": tiktok,
  };
}
