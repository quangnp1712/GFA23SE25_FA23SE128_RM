// ignore_for_file: unused_catch_clause, no_leading_underscores_for_local_identifiers

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
  Future<dynamic> getAccountUnauth(String phone);
  Future<dynamic> putAccountUnauth(
      RegisterCustomerModel registerCustomerModel, String phone);
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
            LoginPhoneModel.fromJson(json.decode(responseBody)['value']);
        await SharedPreferencesService.savePhone(loginPhoneModel.value!);

        return {
          'statusCode': statusCode,
          'data': _loginPhoneModel,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
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
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
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
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(response.body));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  @override
  Future<bool> isLogin() async {
    try {
      // ignore: non_constant_identifier_names
      final SAccountInfo = await SharedPreferencesService.getAccountInfo();
      String? jwtToken;
      if (SAccountInfo.isNotEmpty) {
        jwtToken = SAccountInfo["jwtToken"].toString();
        if (jwtToken.isNotEmpty) {
          return true;
        } else {
          return false;
        }
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
    Get.to(() => const LoginPhoneScreen());
  }

  @override
  Future<dynamic> getAccountUnauth(String phone) async {
    try {
      RegisterCustomerModel accountInfor = RegisterCustomerModel();

      Uri uri = Uri.parse("$unauthUrl/$phone");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': '*/*',
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        accountInfor =
            RegisterCustomerModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': accountInfor,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }

  @override
  Future putAccountUnauth(
      RegisterCustomerModel registerCustomerModel, String phone) async {
    try {
      Uri uri = Uri.parse("$unauthUrl/$phone");
      final client = http.Client();
      final response = await client
          .put(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': '*/*',
              },
              body: json.encode(registerCustomerModel.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else {
        try {
          final ServerExceptionModel exceptionModel =
              ServerExceptionModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'error': exceptionModel,
            'message': "Vui lòng thử lại",
          };
        } catch (e) {
          return {
            'statusCode': 400,
            'error': e,
            'message': "Vui lòng thử lại",
          };
        }
      }
    } on TimeoutException catch (e) {
      return {
        'statusCode': 408,
        'error': e,
        'message':
            "Yêu cầu của bạn mất quá nhiều thời gian để phản hồi. Vui lòng thử lại sau.",
      };
    } on SocketException catch (e) {
      return {
        'statusCode': 500,
        'error': e,
        'message': 'Kiểm tra lại kết nối Internet',
      };
    } catch (e) {
      return {
        'statusCode': 400,
        'error': e,
        'message': 'Vui lòng thử lại',
      };
    }
  }
}
