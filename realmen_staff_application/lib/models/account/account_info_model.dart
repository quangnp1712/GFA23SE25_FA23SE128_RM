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
  String? itimacyLevel;
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
    this.itimacyLevel,
    this.professional,
    this.average,
    this.role,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      accountId: json['value']['accountId'],
      branchId: json['value']['branchId'],
      thumbnailUrl: json['value']['thumbnailUrl'],
      firstName: json['value']['firstName'],
      lastName: json['value']['lastName'],
      phone: json['value']['phone'],
      address: json['value']['address'],
      dob: json['value']['dob'],
      gender: json['value']['gender'],
      status: json['value']['status'],
      branchName: json['value']['branchName'],
      branchAddress: json['value']['branchAddress'],
      itimacyLevel: json['value']['itimacyLevel'],
      professional: json['value']['professional'],
      average: json['value']['average'],
      role: json['value']['role'],
    );
  }
}
