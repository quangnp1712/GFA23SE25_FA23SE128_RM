import 'dart:core';

class LoginOtpModel {
  LoginOtpModel({this.phone, this.passCode, this.loginOtpResponseModel});

  String? phone;
  String? passCode;
  LoginOtpResponseModel? loginOtpResponseModel;

  // Future<String?> getPhone() async {
  //   this.phone = await SharedPreferencesService.getPhone();
  //   return this.phone;
  // }

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
      loginOtpResponseModel: LoginOtpResponseModel.fromJson(json["value"]));

  Map<String, dynamic> toJson() => {"phone": phone, "passCode": passCode};
}

class LoginOtpResponseModel {
  LoginOtpResponseModel(
      {this.phone,
      this.jwtToken,
      this.role,
      this.expTime,
      this.isPhoneRegistered});

  String? phone;
  String? jwtToken;
  String? role;
  String? expTime;
  bool? isPhoneRegistered;

  factory LoginOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginOtpResponseModel(
          phone: json["phone"],
          jwtToken: json["jwtToken"],
          role: json["role"],
          isPhoneRegistered: json["isPhoneRegistered"]);
}
