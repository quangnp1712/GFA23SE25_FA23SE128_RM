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
    List<String>? result = sharedPreferences.getStringList("otpIdPhone");
    if (result != null && result.length >= 2) {
      Map<String, String> resultMap = {"otpId": result[0], "phone": result[1]};
      return resultMap;
    } else {
      throw Exception(
          "Failed to get OTP ID and phone number from SharedPreferences");
    }
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
    String? result = sharedPreferences.getString("passCode")!;
    if (result != null) {
      return result;
    } else {
      throw Exception("Failed to get phone number from SharedPreferences");
    }
  }

  static Future<void> savePhone(String phone) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("phone", phone);
  }

  static Future<String> getPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString("phone")!;
    if (result != null) {
      return result;
    } else {
      throw Exception("Failed to get phone number from SharedPreferences");
    }
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

    if (result != null) {
      Map<String, String> resultMap = {
        "phone": result[0],
        "jwtToken": result[1],
        "role": result[2],
        "accountId": result[3]
      };
      return resultMap;
    } else {
      throw Exception("Failed to get accountInfo from SharedPreferences");
    }
  }

  static Future<String> getAccountId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("accountInfo");
    if (result != null && result.length >= 4) {
      String accountId = result[3];
      return accountId;
    } else {
      throw Exception("Failed to get account ID from SharedPreferences");
    }
  }

  static Future<String> getJwt() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? result = sharedPreferences.getStringList("accountInfo");
    if (result != null && result.length >= 2) {
      String jwtToken = result[1];
      return jwtToken;
    } else {
      throw Exception("Failed to get jwtToken from SharedPreferences");
    }
  }
}
