import 'dart:core';

class LoginPhoneModel {
  LoginPhoneModel({this.value, this.loginPhoneResponse});

  String? value;
  LoginPhoneResponseModel? loginPhoneResponse;

  factory LoginPhoneModel.fromJson(Map<String, dynamic> json) =>
      LoginPhoneModel(
          loginPhoneResponse: LoginPhoneResponseModel.fromJson(json["value"]));

  Map<String, dynamic> toJson() => {"value": value};
}

class LoginPhoneResponseModel {
  LoginPhoneResponseModel({this.otpId, this.phoneAttemp});

  int? otpId;
  String? phoneAttemp;

  factory LoginPhoneResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginPhoneResponseModel(
          otpId: json["otpId"], phoneAttemp: json["phoneAttemp"]);
}
