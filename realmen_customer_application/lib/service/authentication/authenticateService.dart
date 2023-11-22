import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/exception/exception_model.dart';
import 'package:realmen_customer_application/models/login_register/login_otp_model.dart';
import 'package:realmen_customer_application/models/login_register/login_phone_model.dart';
import 'package:realmen_customer_application/models/login_register/register_customer_model.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

abstract class IAuthenticateService {
  Future<dynamic> loginPhone(LoginPhoneModel loginPhoneModel);
  Future<dynamic> loginOtp(LoginOtpModel loginOtpModel);
  Future<dynamic> registerCustomer(RegisterCustomerModel registerCustomerModel);
  Future<dynamic> isLogin();
  Future<void> logout();
}

class AuthenticateService extends IAuthenticateService {
  @override
  Future<dynamic> loginPhone(LoginPhoneModel loginPhoneModel) async {
    Uri uri = Uri.parse(loginPhoneUrl);
    final client = http.Client();
    try {
      final response = await client
          .post(
            uri,
            headers: {
              "Access-Control-Allow-Origin": "*",
              'Content-Type': 'application/json',
              'Accept': '*/*',
            },
            body: json.encode(loginPhoneModel.toJson()),
          )
          .timeout(Duration(seconds: connectionTimeOut));

      final statusCode = response.statusCode;
      final responseBody = response.body;

      if (statusCode == 200) {
        final _loginPhoneModel =
            LoginPhoneModel.fromJson(json.decode(responseBody));
        await SharedPreferencesService.savePhone(loginPhoneModel.value!);

        return {
          'statusCode': statusCode,
          'data': _loginPhoneModel.value,
        };
      } else if (statusCode == 401) {
        try {
          final exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
          };
        } catch (e) {
          return {
            'statusCode': statusCode,
            'error': e,
          };
        }
      } else if (statusCode == 403) {
        return {
          'statusCode': statusCode,
          'error': "Forbidden",
        };
      } else if (statusCode == 400) {
        return {
          'statusCode': statusCode,
          'error': "Bad request",
        };
      } else {
        return {
          'statusCode': statusCode,
          'error': 'Failed to fetch data',
        };
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': "Request timeout",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'error': e,
      };
    }
  }

  @override
  Future<dynamic> loginOtp(LoginOtpModel loginOtpModel) async {
    Uri uri = Uri.parse(loginOtpUrl);
    final client = http.Client();
    try {
      final response = await client
          .post(
            uri,
            headers: {
              "Access-Control-Allow-Origin": "*",
              'Content-Type': 'application/json',
              'Accept': '*/*',
            },
            body: json.encode(loginOtpModel.toJson()),
          )
          .timeout(Duration(seconds: connectionTimeOut));

      final statusCode = response.statusCode;
      final responseBody = response.body;

      if (statusCode == 200) {
        final _loginOtpModel =
            LoginOtpModel.fromJson(json.decode(responseBody));
        if (_loginOtpModel.loginOtpResponseModel?.jwtToken != null) {
          await SharedPreferencesService.saveAccountInfo(
              _loginOtpModel.loginOtpResponseModel!);
          return {
            'statusCode': statusCode,
            'data': _loginOtpModel,
          };
        } else {
          return {
            'statusCode': statusCode,
            'error': "ERROR: $_loginOtpModel",
          };
        }
      } else if (statusCode == 401) {
        try {
          final exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
          };
        } catch (e) {
          return {
            'statusCode': statusCode,
            'error': e,
          };
        }
      } else if (statusCode == 403) {
        return {
          'statusCode': statusCode,
          'error': "Forbidden",
        };
      } else if (statusCode == 400) {
        return {
          'statusCode': statusCode,
          'error': "Bad request",
        };
      } else {
        return {
          'statusCode': statusCode,
          'error': 'Failed to fetch data',
        };
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': "Request timeout",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': 'Socket error',
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'error': e,
      };
    }
  }

  @override
  Future registerCustomer(RegisterCustomerModel registerCustomerModel) async {
    // final otpIdPhone = await SharedPreferencesService.getOtpPhone();
    // final int otpId = int.parse(otpIdPhone["otpId"].toString());
    // final String phone = otpIdPhone["phone"].toString();
    String phone = await SharedPreferencesService.getPhone();
    // final String passCode = await SharedPreferencesService.getPassCode();
    registerCustomerModel.phone = phone;
    // Uri uri = Uri.parse("$registerUrl?otpId=$otpId&passCode=$passCode");
    Uri uri = Uri.parse(registerUrl);
    final client = http.Client();
    try {
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*'
              },
              body: json.encode(registerCustomerModel.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else if (statusCode == 401) {
        try {
          final exceptionModel =
              ServerExceptionModel.fromJson(json.decode(response.body));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
          };
        } catch (e) {
          return {
            'statusCode': statusCode,
            'error': e,
          };
        }
      } else if (statusCode == 403) {
        return {
          'statusCode': statusCode,
          'error': "Forbidden",
        };
      } else if (statusCode == 400) {
        return {
          'statusCode': statusCode,
          'error': "Bad request",
        };
      } else {
        return {
          'statusCode': statusCode,
          'error': 'Tên chỉ 1 từ',
        };
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': "Request timeout",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': 'Socket error',
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'error': e,
      };
    }
  }

  @override
  Future<bool> isLogin() async {
    try {
      final SAccountInfo = await SharedPreferencesService.getAccountInfo();
      String? jwtToken;
      if (SAccountInfo != null) {
        jwtToken = SAccountInfo["jwtToken"].toString();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Get.to(() => LoginPhoneScreen());
    return;
  }
}
