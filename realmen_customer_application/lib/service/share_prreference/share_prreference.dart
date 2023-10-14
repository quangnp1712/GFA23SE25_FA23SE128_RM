import 'dart:convert';
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

  static Future<String> getPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String> resultList = sharedPreferences.getStringList("otpIdPhone")!;
    String result = resultList[1];
    return result;
  }

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
}
