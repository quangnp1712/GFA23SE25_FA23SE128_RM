// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:core';

import 'package:realmen_customer_application/models/account/staff_model.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';

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
  BranchModel? branch;
  StaffModel? staff;

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
    this.branch,
    this.staff,
    this.itimacyLevel,
    this.professional,
    this.average,
    this.role,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      accountId: json['accountId'],
      branchId: json['branchId'],
      thumbnailUrl: json['thumbnailUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      address: json['address'],
      dob: json['dob'],
      gender: json['gender'],
      status: json['status'],
      branch: json['branch'] != null && json['branch'] != []
          ? BranchModel.fromJson(json['branch'])
          : null,
      staff: json['staff'] != null && json['staff'] != []
          ? StaffModel.fromJson(json['staff'])
          : null,
      itimacyLevel: json['itimacyLevel'],
      professional: json['professional'],
      average: json['average'],
      role: json['role'],
    );
  }
}
