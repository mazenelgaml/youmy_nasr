// To parse this JSON data, do
//
//     final couriesListModel = couriesListModelFromJson(jsonString);

import 'dart:convert';

CouriesListModel couriesListModelFromJson(String str) => CouriesListModel.fromJson(json.decode(str));

String couriesListModelToJson(CouriesListModel data) => json.encode(data.toJson());

class CouriesListModel {
  List<CouriersDetails>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CouriesListModel({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory CouriesListModel.fromJson(Map<String, dynamic> json) => CouriesListModel(
    data: json["data"] == null ? [] : List<CouriersDetails>.from(json["data"]!.map((x) => CouriersDetails.fromJson(x))),
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

class CouriersDetails {
  String? empCode;
  String? empName;
  String? empNameAra;
  String? empNameEng;
  String? mobile;
  dynamic fax;
  dynamic telPhone;
  String? eMail;
  dynamic address;
  dynamic userCode;
  String? userId;
  String? password;
  bool? isUser;
  bool? isManager;
  bool? isIt;
  bool? isStoreKeeper;
  bool? isSafeKeeper;
  bool? isSalesMan;
  bool? isCashier;
  bool? isWorkFlowActivate;
  bool? isLawyer;
  String? accountCode;
  dynamic accountName;
  dynamic projectCode;
  dynamic projectName;
  String? departmentCode;
  dynamic departmentName;
  dynamic budgetCode;
  dynamic budgetName;
  dynamic journalCode;
  dynamic journalName;
  dynamic downPaymentAccont;
  String? costCenterCode;
  String? costCenterName;
  String? fingerPrintCode;
  dynamic fingerPrintName;
  DateTime? birthdate;
  int? nationalityCode;
  dynamic nationalityName;
  int? genderCode;
  dynamic genderName;
  int? religionCode;
  dynamic religionName;
  int? militaryStatusCode;
  dynamic militaryStatusName;
  int? maritalStatusCode;
  dynamic maritalStatusName;
  int? countryCode;
  dynamic countryName;
  int? cityCode;
  dynamic cityName;
  int? regionCode;
  dynamic regionName;
  dynamic hiringDate;
  String? idNo;
  dynamic passportNo;
  int? bankCode;
  dynamic bankName;
  dynamic banckAccountNo;
  dynamic insuranceNo;
  bool? innsured;
  int? jobCode;
  String? jobName;
  int? jobPositionCode;
  dynamic jobPositionName;
  int? graduationCode;
  dynamic graduationName;
  int? qualificationCode;
  dynamic qualificationName;
  int? specializationCode;
  dynamic specializationName;
  int? qualificationDegreeCode;
  dynamic qualificationDegreeName;
  int? graduationYear;
  dynamic photo;
  String? employeeStatusCode;
  dynamic employeeStatusName;
  int? maxDiscount;
  bool? isTechnician;
  bool? isDriver;
  int? basicSalary;
  int? monthlyTarget;
  int? technicianCost;
  int? commissionRate;
  int? malfunctionCommission;
  int? partsCommission;
  dynamic licenceTypeCode;
  dynamic licenceTypeName;
  dynamic licenceNumber;
  dynamic licenceReleaseDate;
  dynamic licenceEndDate;
  int? driverCommission;
  String? duePayrollAccountCode;
  dynamic duePayrollAccountName;
  String? payrollExpenseAccountCode;
  dynamic payrollExpenseAccountName;
  String? employeeLoanAccountCode;
  dynamic employeeLoanAccountName;
  String? overTimeAccountCode;
  dynamic overTimeAccountName;
  dynamic dueInsuranceAccountCode;
  dynamic dueInsuranceAccountName;
  dynamic insurancesExpenseAccountCode;
  dynamic insurancesExpenseAccountName;
  dynamic costCenterCode2;
  dynamic costCenterCode3;
  dynamic storeCode;
  dynamic storeName;
  String? safeCode;
  dynamic safeName;
  int? workHourCount;
  String? paySalaryMethodCode;
  dynamic paySalaryMethodName;
  bool? isClearanceAgent;
  String? defaultBankCode;
  dynamic defaultBankName;
  bool? isEditPrice;
  dynamic defaultPortCode;
  dynamic defaultPortName;
  dynamic salesInvoiceTypeCode;
  dynamic salesInvoiceTypeName;
  dynamic salesInvoiceReturnTypeCode;
  dynamic salesInvoiceReturnTypeName;
  dynamic posDefaultCustomerCode;
  dynamic posDefaultCustomerName;
  dynamic madaaCredit;
  dynamic visaCredit;
  dynamic masterCardCredit;
  dynamic stcPayCredit;
  dynamic accountTransferCredit;
  int? defaultMenuId;
  dynamic postingSettingCode;
  dynamic postingSettingName;
  bool? isActivateShowJournal;
  dynamic couponDiscountCode;
  dynamic couponDiscountName;
  String? skinName;
  dynamic priceListCode;
  dynamic priceListName;
  dynamic vendorCode;
  dynamic isStudent;
  dynamic isTeacher;
  dynamic isParent;
  dynamic employeeImage;
  int? id;
  dynamic baseSyncId;
  int? companyCode;
  dynamic lineNum;
  int? branchCode;
  dynamic year;
  dynamic descriptionAra;
  dynamic attachment;
  dynamic descriptionEng;
  dynamic requestTypeCode;
  dynamic notes;
  bool? notActive;
  bool? flgDelete;
  dynamic addBy;
  dynamic addTime;
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
  dynamic lastModificationTime;
  dynamic deleterUserId;
  dynamic deleterUserName;
  dynamic glSerial;
  dynamic glType;
  dynamic deletionTime;
  dynamic confirmationTime;
  dynamic langId;
  dynamic synchronizationStatusCode;
  dynamic isSynchronized;
  dynamic postedToGl;
  dynamic confirmed;
  dynamic isPaidFinancialTransaction;
  dynamic isLinkWithTaxAuthority;
  dynamic synchronizationDate;

  CouriersDetails({
    this.empCode,
    this.empName,
    this.empNameAra,
    this.empNameEng,
    this.mobile,
    this.fax,
    this.telPhone,
    this.eMail,
    this.address,
    this.userCode,
    this.userId,
    this.password,
    this.isUser,
    this.isManager,
    this.isIt,
    this.isStoreKeeper,
    this.isSafeKeeper,
    this.isSalesMan,
    this.isCashier,
    this.isWorkFlowActivate,
    this.isLawyer,
    this.accountCode,
    this.accountName,
    this.projectCode,
    this.projectName,
    this.departmentCode,
    this.departmentName,
    this.budgetCode,
    this.budgetName,
    this.journalCode,
    this.journalName,
    this.downPaymentAccont,
    this.costCenterCode,
    this.costCenterName,
    this.fingerPrintCode,
    this.fingerPrintName,
    this.birthdate,
    this.nationalityCode,
    this.nationalityName,
    this.genderCode,
    this.genderName,
    this.religionCode,
    this.religionName,
    this.militaryStatusCode,
    this.militaryStatusName,
    this.maritalStatusCode,
    this.maritalStatusName,
    this.countryCode,
    this.countryName,
    this.cityCode,
    this.cityName,
    this.regionCode,
    this.regionName,
    this.hiringDate,
    this.idNo,
    this.passportNo,
    this.bankCode,
    this.bankName,
    this.banckAccountNo,
    this.insuranceNo,
    this.innsured,
    this.jobCode,
    this.jobName,
    this.jobPositionCode,
    this.jobPositionName,
    this.graduationCode,
    this.graduationName,
    this.qualificationCode,
    this.qualificationName,
    this.specializationCode,
    this.specializationName,
    this.qualificationDegreeCode,
    this.qualificationDegreeName,
    this.graduationYear,
    this.photo,
    this.employeeStatusCode,
    this.employeeStatusName,
    this.maxDiscount,
    this.isTechnician,
    this.isDriver,
    this.basicSalary,
    this.monthlyTarget,
    this.technicianCost,
    this.commissionRate,
    this.malfunctionCommission,
    this.partsCommission,
    this.licenceTypeCode,
    this.licenceTypeName,
    this.licenceNumber,
    this.licenceReleaseDate,
    this.licenceEndDate,
    this.driverCommission,
    this.duePayrollAccountCode,
    this.duePayrollAccountName,
    this.payrollExpenseAccountCode,
    this.payrollExpenseAccountName,
    this.employeeLoanAccountCode,
    this.employeeLoanAccountName,
    this.overTimeAccountCode,
    this.overTimeAccountName,
    this.dueInsuranceAccountCode,
    this.dueInsuranceAccountName,
    this.insurancesExpenseAccountCode,
    this.insurancesExpenseAccountName,
    this.costCenterCode2,
    this.costCenterCode3,
    this.storeCode,
    this.storeName,
    this.safeCode,
    this.safeName,
    this.workHourCount,
    this.paySalaryMethodCode,
    this.paySalaryMethodName,
    this.isClearanceAgent,
    this.defaultBankCode,
    this.defaultBankName,
    this.isEditPrice,
    this.defaultPortCode,
    this.defaultPortName,
    this.salesInvoiceTypeCode,
    this.salesInvoiceTypeName,
    this.salesInvoiceReturnTypeCode,
    this.salesInvoiceReturnTypeName,
    this.posDefaultCustomerCode,
    this.posDefaultCustomerName,
    this.madaaCredit,
    this.visaCredit,
    this.masterCardCredit,
    this.stcPayCredit,
    this.accountTransferCredit,
    this.defaultMenuId,
    this.postingSettingCode,
    this.postingSettingName,
    this.isActivateShowJournal,
    this.couponDiscountCode,
    this.couponDiscountName,
    this.skinName,
    this.priceListCode,
    this.priceListName,
    this.vendorCode,
    this.isStudent,
    this.isTeacher,
    this.isParent,
    this.employeeImage,
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
    this.isSynchronized,
    this.postedToGl,
    this.confirmed,
    this.isPaidFinancialTransaction,
    this.isLinkWithTaxAuthority,
    this.synchronizationDate,
  });

  factory CouriersDetails.fromJson(Map<String, dynamic> json) => CouriersDetails(
    empCode: json["empCode"],
    empName: json["empName"],
    empNameAra: json["empNameAra"],
    empNameEng: json["empNameEng"],
    mobile: json["mobile"],
    fax: json["fax"],
    telPhone: json["telPhone"],
    eMail: json["eMail"],
    address: json["address"],
    userCode: json["userCode"],
    userId: json["userId"],
    password: json["password"],
    isUser: json["isUser"],
    isManager: json["isManager"],
    isIt: json["isIt"],
    isStoreKeeper: json["isStoreKeeper"],
    isSafeKeeper: json["isSafeKeeper"],
    isSalesMan: json["isSalesMan"],
    isCashier: json["isCashier"],
    isWorkFlowActivate: json["isWorkFlowActivate"],
    isLawyer: json["isLawyer"],
    accountCode: json["accountCode"],
    accountName: json["accountName"],
    projectCode: json["projectCode"],
    projectName: json["projectName"],
    departmentCode: json["departmentCode"],
    departmentName: json["departmentName"],
    budgetCode: json["budgetCode"],
    budgetName: json["budgetName"],
    journalCode: json["journalCode"],
    journalName: json["journalName"],
    downPaymentAccont: json["downPaymentAccont"],
    costCenterCode: json["costCenterCode"],
    costCenterName: json["costCenterName"],
    fingerPrintCode: json["fingerPrintCode"],
    fingerPrintName: json["fingerPrintName"],
    birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
    nationalityCode: json["nationalityCode"],
    nationalityName: json["nationalityName"],
    genderCode: json["genderCode"],
    genderName: json["genderName"],
    religionCode: json["religionCode"],
    religionName: json["religionName"],
    militaryStatusCode: json["militaryStatusCode"],
    militaryStatusName: json["militaryStatusName"],
    maritalStatusCode: json["maritalStatusCode"],
    maritalStatusName: json["maritalStatusName"],
    countryCode: json["countryCode"],
    countryName: json["countryName"],
    cityCode: json["cityCode"],
    cityName: json["cityName"],
    regionCode: json["regionCode"],
    regionName: json["regionName"],
    hiringDate: json["hiringDate"],
    idNo: json["idNo"],
    passportNo: json["passportNo"],
    bankCode: json["bankCode"],
    bankName: json["bankName"],
    banckAccountNo: json["banckAccountNo"],
    insuranceNo: json["insuranceNo"],
    innsured: json["innsured"],
    jobCode: json["jobCode"],
    jobName: json["jobName"],
    jobPositionCode: json["jobPositionCode"],
    jobPositionName: json["jobPositionName"],
    graduationCode: json["graduationCode"],
    graduationName: json["graduationName"],
    qualificationCode: json["qualificationCode"],
    qualificationName: json["qualificationName"],
    specializationCode: json["specializationCode"],
    specializationName: json["specializationName"],
    qualificationDegreeCode: json["qualificationDegreeCode"],
    qualificationDegreeName: json["qualificationDegreeName"],
    graduationYear: json["graduationYear"],
    photo: json["photo"],
    employeeStatusCode: json["employeeStatusCode"],
    employeeStatusName: json["employeeStatusName"],
    maxDiscount: json["maxDiscount"],
    isTechnician: json["isTechnician"],
    isDriver: json["isDriver"],
    basicSalary: json["basicSalary"],
    monthlyTarget: json["monthlyTarget"],
    technicianCost: json["technicianCost"],
    commissionRate: json["commissionRate"],
    malfunctionCommission: json["malfunctionCommission"],
    partsCommission: json["partsCommission"],
    licenceTypeCode: json["licenceTypeCode"],
    licenceTypeName: json["licenceTypeName"],
    licenceNumber: json["licenceNumber"],
    licenceReleaseDate: json["licenceReleaseDate"],
    licenceEndDate: json["licenceEndDate"],
    driverCommission: json["driverCommission"],
    duePayrollAccountCode: json["duePayrollAccountCode"],
    duePayrollAccountName: json["duePayrollAccountName"],
    payrollExpenseAccountCode: json["payrollExpenseAccountCode"],
    payrollExpenseAccountName: json["payrollExpenseAccountName"],
    employeeLoanAccountCode: json["employeeLoanAccountCode"],
    employeeLoanAccountName: json["employeeLoanAccountName"],
    overTimeAccountCode: json["overTimeAccountCode"],
    overTimeAccountName: json["overTimeAccountName"],
    dueInsuranceAccountCode: json["dueInsuranceAccountCode"],
    dueInsuranceAccountName: json["dueInsuranceAccountName"],
    insurancesExpenseAccountCode: json["insurancesExpenseAccountCode"],
    insurancesExpenseAccountName: json["insurancesExpenseAccountName"],
    costCenterCode2: json["costCenterCode2"],
    costCenterCode3: json["costCenterCode3"],
    storeCode: json["storeCode"],
    storeName: json["storeName"],
    safeCode: json["safeCode"],
    safeName: json["safeName"],
    workHourCount: json["workHourCount"],
    paySalaryMethodCode: json["paySalaryMethodCode"],
    paySalaryMethodName: json["paySalaryMethodName"],
    isClearanceAgent: json["isClearanceAgent"],
    defaultBankCode: json["defaultBankCode"],
    defaultBankName: json["defaultBankName"],
    isEditPrice: json["isEditPrice"],
    defaultPortCode: json["defaultPortCode"],
    defaultPortName: json["defaultPortName"],
    salesInvoiceTypeCode: json["salesInvoiceTypeCode"],
    salesInvoiceTypeName: json["salesInvoiceTypeName"],
    salesInvoiceReturnTypeCode: json["salesInvoiceReturnTypeCode"],
    salesInvoiceReturnTypeName: json["salesInvoiceReturnTypeName"],
    posDefaultCustomerCode: json["posDefaultCustomerCode"],
    posDefaultCustomerName: json["posDefaultCustomerName"],
    madaaCredit: json["madaaCredit"],
    visaCredit: json["visaCredit"],
    masterCardCredit: json["masterCardCredit"],
    stcPayCredit: json["stcPayCredit"],
    accountTransferCredit: json["accountTransferCredit"],
    defaultMenuId: json["defaultMenuId"],
    postingSettingCode: json["postingSettingCode"],
    postingSettingName: json["postingSettingName"],
    isActivateShowJournal: json["isActivateShowJournal"],
    couponDiscountCode: json["couponDiscountCode"],
    couponDiscountName: json["couponDiscountName"],
    skinName: json["skinName"],
    priceListCode: json["priceListCode"],
    priceListName: json["priceListName"],
    vendorCode: json["vendorCode"],
    isStudent: json["isStudent"],
    isTeacher: json["isTeacher"],
    isParent: json["isParent"],
    employeeImage: json["employeeImage"],
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
    notes: json["notes"],
    notActive: json["notActive"],
    flgDelete: json["flgDelete"],
    addBy: json["addBy"],
    addTime: json["addTime"],
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
    lastModificationTime: json["lastModificationTime"],
    deleterUserId: json["deleterUserId"],
    deleterUserName: json["deleterUserName"],
    glSerial: json["glSerial"],
    glType: json["glType"],
    deletionTime: json["deletionTime"],
    confirmationTime: json["confirmationTime"],
    langId: json["langId"],
    synchronizationStatusCode: json["synchronizationStatusCode"],
    isSynchronized: json["isSynchronized"],
    postedToGl: json["postedToGL"],
    confirmed: json["confirmed"],
    isPaidFinancialTransaction: json["isPaidFinancialTransaction"],
    isLinkWithTaxAuthority: json["isLinkWithTaxAuthority"],
    synchronizationDate: json["synchronizationDate"],
  );

  Map<String, dynamic> toJson() => {
    "empCode": empCode,
    "empName": empName,
    "empNameAra": empNameAra,
    "empNameEng": empNameEng,
    "mobile": mobile,
    "fax": fax,
    "telPhone": telPhone,
    "eMail": eMail,
    "address": address,
    "userCode": userCode,
    "userId": userId,
    "password": password,
    "isUser": isUser,
    "isManager": isManager,
    "isIt": isIt,
    "isStoreKeeper": isStoreKeeper,
    "isSafeKeeper": isSafeKeeper,
    "isSalesMan": isSalesMan,
    "isCashier": isCashier,
    "isWorkFlowActivate": isWorkFlowActivate,
    "isLawyer": isLawyer,
    "accountCode": accountCode,
    "accountName": accountName,
    "projectCode": projectCode,
    "projectName": projectName,
    "departmentCode": departmentCode,
    "departmentName": departmentName,
    "budgetCode": budgetCode,
    "budgetName": budgetName,
    "journalCode": journalCode,
    "journalName": journalName,
    "downPaymentAccont": downPaymentAccont,
    "costCenterCode": costCenterCode,
    "costCenterName": costCenterName,
    "fingerPrintCode": fingerPrintCode,
    "fingerPrintName": fingerPrintName,
    "birthdate": birthdate?.toIso8601String(),
    "nationalityCode": nationalityCode,
    "nationalityName": nationalityName,
    "genderCode": genderCode,
    "genderName": genderName,
    "religionCode": religionCode,
    "religionName": religionName,
    "militaryStatusCode": militaryStatusCode,
    "militaryStatusName": militaryStatusName,
    "maritalStatusCode": maritalStatusCode,
    "maritalStatusName": maritalStatusName,
    "countryCode": countryCode,
    "countryName": countryName,
    "cityCode": cityCode,
    "cityName": cityName,
    "regionCode": regionCode,
    "regionName": regionName,
    "hiringDate": hiringDate,
    "idNo": idNo,
    "passportNo": passportNo,
    "bankCode": bankCode,
    "bankName": bankName,
    "banckAccountNo": banckAccountNo,
    "insuranceNo": insuranceNo,
    "innsured": innsured,
    "jobCode": jobCode,
    "jobName": jobName,
    "jobPositionCode": jobPositionCode,
    "jobPositionName": jobPositionName,
    "graduationCode": graduationCode,
    "graduationName": graduationName,
    "qualificationCode": qualificationCode,
    "qualificationName": qualificationName,
    "specializationCode": specializationCode,
    "specializationName": specializationName,
    "qualificationDegreeCode": qualificationDegreeCode,
    "qualificationDegreeName": qualificationDegreeName,
    "graduationYear": graduationYear,
    "photo": photo,
    "employeeStatusCode": employeeStatusCode,
    "employeeStatusName": employeeStatusName,
    "maxDiscount": maxDiscount,
    "isTechnician": isTechnician,
    "isDriver": isDriver,
    "basicSalary": basicSalary,
    "monthlyTarget": monthlyTarget,
    "technicianCost": technicianCost,
    "commissionRate": commissionRate,
    "malfunctionCommission": malfunctionCommission,
    "partsCommission": partsCommission,
    "licenceTypeCode": licenceTypeCode,
    "licenceTypeName": licenceTypeName,
    "licenceNumber": licenceNumber,
    "licenceReleaseDate": licenceReleaseDate,
    "licenceEndDate": licenceEndDate,
    "driverCommission": driverCommission,
    "duePayrollAccountCode": duePayrollAccountCode,
    "duePayrollAccountName": duePayrollAccountName,
    "payrollExpenseAccountCode": payrollExpenseAccountCode,
    "payrollExpenseAccountName": payrollExpenseAccountName,
    "employeeLoanAccountCode": employeeLoanAccountCode,
    "employeeLoanAccountName": employeeLoanAccountName,
    "overTimeAccountCode": overTimeAccountCode,
    "overTimeAccountName": overTimeAccountName,
    "dueInsuranceAccountCode": dueInsuranceAccountCode,
    "dueInsuranceAccountName": dueInsuranceAccountName,
    "insurancesExpenseAccountCode": insurancesExpenseAccountCode,
    "insurancesExpenseAccountName": insurancesExpenseAccountName,
    "costCenterCode2": costCenterCode2,
    "costCenterCode3": costCenterCode3,
    "storeCode": storeCode,
    "storeName": storeName,
    "safeCode": safeCode,
    "safeName": safeName,
    "workHourCount": workHourCount,
    "paySalaryMethodCode": paySalaryMethodCode,
    "paySalaryMethodName": paySalaryMethodName,
    "isClearanceAgent": isClearanceAgent,
    "defaultBankCode": defaultBankCode,
    "defaultBankName": defaultBankName,
    "isEditPrice": isEditPrice,
    "defaultPortCode": defaultPortCode,
    "defaultPortName": defaultPortName,
    "salesInvoiceTypeCode": salesInvoiceTypeCode,
    "salesInvoiceTypeName": salesInvoiceTypeName,
    "salesInvoiceReturnTypeCode": salesInvoiceReturnTypeCode,
    "salesInvoiceReturnTypeName": salesInvoiceReturnTypeName,
    "posDefaultCustomerCode": posDefaultCustomerCode,
    "posDefaultCustomerName": posDefaultCustomerName,
    "madaaCredit": madaaCredit,
    "visaCredit": visaCredit,
    "masterCardCredit": masterCardCredit,
    "stcPayCredit": stcPayCredit,
    "accountTransferCredit": accountTransferCredit,
    "defaultMenuId": defaultMenuId,
    "postingSettingCode": postingSettingCode,
    "postingSettingName": postingSettingName,
    "isActivateShowJournal": isActivateShowJournal,
    "couponDiscountCode": couponDiscountCode,
    "couponDiscountName": couponDiscountName,
    "skinName": skinName,
    "priceListCode": priceListCode,
    "priceListName": priceListName,
    "vendorCode": vendorCode,
    "isStudent": isStudent,
    "isTeacher": isTeacher,
    "isParent": isParent,
    "employeeImage": employeeImage,
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
    "notes": notes,
    "notActive": notActive,
    "flgDelete": flgDelete,
    "addBy": addBy,
    "addTime": addTime,
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
    "lastModificationTime": lastModificationTime,
    "deleterUserId": deleterUserId,
    "deleterUserName": deleterUserName,
    "glSerial": glSerial,
    "glType": glType,
    "deletionTime": deletionTime,
    "confirmationTime": confirmationTime,
    "langId": langId,
    "synchronizationStatusCode": synchronizationStatusCode,
    "isSynchronized": isSynchronized,
    "postedToGL": postedToGl,
    "confirmed": confirmed,
    "isPaidFinancialTransaction": isPaidFinancialTransaction,
    "isLinkWithTaxAuthority": isLinkWithTaxAuthority,
    "synchronizationDate": synchronizationDate,
  };
}
