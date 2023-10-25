import 'dart:core';

class AccountInfoModel {
  int? accountId;
  int? branchId;
  String? thumbnailUrl;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? dob;
  String? gender;
  String? status;
  String? branchName;
  String? branchAddress;
  String? professional;
  int? average;
  String? role;

  AccountInfoModel({
    this.accountId,
    this.branchId,
    this.thumbnailUrl,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.dob,
    this.gender,
    this.status,
    this.branchName,
    this.branchAddress,
    this.professional,
    this.average,
    this.role,
  });

  AccountInfoModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    branchId = json['branchId'];
    thumbnailUrl = json['thumbnailUrl'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
    status = json['status'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    professional = json['professional'];
    average = json['average'];
    role = json['role'];
  }
}
