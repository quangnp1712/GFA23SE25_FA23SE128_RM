import 'dart:core';

class LoginPhoneModel {
  LoginPhoneModel({
    this.isAccountExist,
    this.isAccountActivated,
    this.value,
  });

  bool? isAccountExist;
  bool? isAccountActivated;
  String? value;
  // LoginPhoneResponseModel? loginPhoneResponse;

  factory LoginPhoneModel.fromJson(Map<String, dynamic> json) =>
      LoginPhoneModel(
        isAccountExist: json["isAccountExist"],
        isAccountActivated: json["isAccountActivated"],
      );

  Map<String, dynamic> toJson() => {"value": value};
}
