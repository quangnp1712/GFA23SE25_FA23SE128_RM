// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:realmen_customer_application/models/account/account_info_model.dart';

class BranchesModel {
  List<BranchesValuesModel>? values;
  BranchesModel({
    this.values,
  });

  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
      values: json['values'] != null && json['values'] != []
          ? (json['values'] as List)
              .map((e) => BranchesValuesModel.fromJson(e))
              .toList()
          : null,
    );
  }
}

class BranchesValuesModel {
  String? city;
  int? branch;
  List<BranchModel>? branchList;
  BranchesValuesModel({
    this.city,
    this.branch,
    this.branchList,
  });
  factory BranchesValuesModel.fromJson(Map<String, dynamic> json) {
    return BranchesValuesModel(
      city: json['city'] ?? null,
      branch: json['branch'] ?? null,
      branchList: json['branchList'] != null && json['branchList'] != []
          ? (json['branchList'] as List)
              .map((e) => BranchModel.fromJson(e))
              .toList()
          : null,
    );
  }
}

class BranchModel {
  int? branchId;
  int? shopOwnerId;
  String? branchName;
  String? thumbnailUrl;
  String? phone;
  String? address;
  String? status;
  int? numberStaffs;
  String? open;
  String? close;
  List<BranchDisplayListUrl>? branchDisplayList;
  List<BranchServiceModel>? branchServiceList;
  List<AccountInfoModel>? accountStaffList;
  String? distanceKilometer;

  BranchModel(
      {this.branchId,
      this.shopOwnerId,
      this.branchName,
      this.thumbnailUrl,
      this.phone,
      this.address,
      this.status,
      this.numberStaffs,
      this.open,
      this.close,
      this.branchDisplayList,
      this.branchServiceList,
      this.accountStaffList,
      this.distanceKilometer});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branchId: json['branchId'] ?? null,
      shopOwnerId: json['shopOwnerId'] ?? null,
      branchName: json['branchName'] ?? null,
      phone: json['phone'] ?? null,
      address: json['address'] ?? null,
      status: json['status'] ?? null,
      numberStaffs: json['numberStaffs'] ?? null,
      open: json['open'] ?? null,
      close: json['close'] ?? null,
      branchDisplayList: json['branchDisplayList'] != null
          ? (json['branchDisplayList'] as List)
              .map((e) => BranchDisplayListUrl.fromJson(e))
              .toList()
          : null,
      branchServiceList: json['branchServiceList'] != null
          ? (json['branchServiceList'] as List)
              .map((e) => BranchServiceModel.fromJson(e))
              .toList()
          : null,
      accountStaffList: json['accountStaffList'] != null
          ? (json['accountStaffList'] as List)
              .map((e) => AccountInfoModel.fromJson(e))
              .toList()
          : null,
      distanceKilometer: json['distanceKilometer'] ?? null,
    );
  }
}

class OpenModel {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  OpenModel({
    this.hour,
    this.minute,
    this.second,
    this.nano,
  });

  factory OpenModel.fromJson(Map<String, dynamic> json) {
    return OpenModel(
      hour: json['hour'],
      minute: json['minute'],
      second: json['second'],
      nano: json['nano'],
    );
  }
}

class CloseModel {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  CloseModel({
    this.hour,
    this.minute,
    this.second,
    this.nano,
  });

  factory CloseModel.fromJson(Map<String, dynamic> json) {
    return CloseModel(
      hour: json['hour'],
      minute: json['minute'],
      second: json['second'],
      nano: json['nano'],
    );
  }
}

class BranchServiceModel {
  int? serviceId;
  int? branchId;
  String? serviceName;
  String? branchName;
  String? thumbnailUrl;
  int? price;

  BranchServiceModel(
      {this.serviceId,
      this.branchId,
      this.serviceName,
      this.branchName,
      this.thumbnailUrl,
      this.price});

  factory BranchServiceModel.fromJson(Map<String, dynamic> json) =>
      BranchServiceModel(
          serviceId: json["serviceId"],
          branchId: json["branchId"],
          serviceName: json["serviceName"],
          branchName: json["branchName"],
          thumbnailUrl: json["thumbnailUrl"],
          price: json["price"]);
}

class BranchDisplayListUrl {
  String? url;
  BranchDisplayListUrl({
    this.url,
  });

  factory BranchDisplayListUrl.fromJson(Map<String, dynamic> json) {
    return BranchDisplayListUrl(
      url: json['url'],
    );
  }
}
