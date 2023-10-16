import 'dart:convert';
import 'package:realmen_customer_application/models/login_otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> saveOtpIdPhone(String otpId, String phone) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setStringList("otpIdPhone", [otpId, phone]);
  }

  static Future<Map<String, String>> getOtpPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String> result = sharedPreferences.getStringList("otpIdPhone")!;
    Map<String, String> resultMap = {"otpId": result[0], "phone": result[1]};
    return resultMap;
  }

  // static Future<String> getPhone() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   List<String> resultList = sharedPreferences.getStringList("otpIdPhone")!;
  //   String result = resultList[1];
  //   return result;
  // }

  static Future<void> savePassCode(String passCode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("passCode", passCode);
  }

  static Future<String> getPassCode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String result = sharedPreferences.getString("passCode")!;
    return result;
  }

  static Future<void> savePhone(String phone) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("phone", phone);
  }

  static Future<String> getPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String result = sharedPreferences.getString("phone")!;
    return result;
  }

  static Future<void> saveAccountInfo(
      LoginOtpResponseModel loginOtpResponseModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setStringList("accountInfo", [
      loginOtpResponseModel.phone!,
      loginOtpResponseModel.jwtToken!,
      loginOtpResponseModel.role!,
      loginOtpResponseModel.accountId!.toString()
    ]);
  }

  static Future<Map<String, String>> getAccountInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String> result = sharedPreferences.getStringList("accountInfo")!;
    Map<String, String> resultMap = {
      "phone": result[0],
      "jwtToken": result[1],
      "role": result[2],
      "accountId": result[3]
    };
    return resultMap;
  }
}
