import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/exception_model.dart';
import 'package:realmen_customer_application/models/login_otp_model.dart';
import 'package:realmen_customer_application/models/login_phone_model.dart';
import 'package:realmen_customer_application/models/register_customer_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthenticateService {
  Future<dynamic> loginPhone(LoginPhoneModel loginPhoneModel);
  Future<dynamic> loginOtp(LoginOtpModel loginOtpModel);
  Future<dynamic> registerCustomer(RegisterCustomerModel registerCustomerModel);
  Future<dynamic> isLogin();
}

class AuthenticateService extends IAuthenticateService {
  @override
  Future loginPhone(LoginPhoneModel loginPhoneModel) async {
    Uri uri = Uri.parse(loginPhoneUrl);
    final client = http.Client();
    try {
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*'
              },
              body: json.encode(loginPhoneModel.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));
      if (response.statusCode == 200) {
        final _loginPhoneModel =
            LoginPhoneModel.fromJson(json.decode(response.body));
        await SharedPreferencesService.savePhone(
            // loginPhoneModel.loginPhoneResponse!.otpId!.toString(),
            // loginPhoneModel.loginPhoneResponse!.phoneAttemp!,
            loginPhoneModel.value!);

        return _loginPhoneModel.value;
      } else if (response.statusCode == 401) {
        final exceptionModel =
            ServerExceptionModel.fromJson(json.decode(response.body));
        return exceptionModel;
      }
    } on TimeoutException catch (e) {
      return e;
    } on SocketException catch (e) {
      return e;
    } catch (e) {
      return e;
    }
  }

  @override
  Future loginOtp(LoginOtpModel loginOtpModel) async {
    Uri uri = Uri.parse(loginOtpUrl);
    final client = http.Client();
    try {
      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*'
              },
              body: json.encode(loginOtpModel.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));
      if (response.statusCode == 200) {
        final _loginOtpModel =
            LoginOtpModel.fromJson(json.decode(response.body));
        if (_loginOtpModel.loginOtpResponseModel!.jwtToken != null) {
          await SharedPreferencesService.saveAccountInfo(
              _loginOtpModel.loginOtpResponseModel!);
          return _loginOtpModel;
        } else {
          return "ERROR: $_loginOtpModel";
        }
      } else if (response.statusCode == 401) {
        final exceptionModel =
            ServerExceptionModel.fromJson(json.decode(response.body));
        return exceptionModel;
      }
    } on TimeoutException catch (e) {
      return e;
    } on SocketException catch (e) {
      return e;
    } catch (e) {
      return e;
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
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 401) {
        final exceptionModel =
            ServerExceptionModel.fromJson(json.decode(response.body));
        return exceptionModel;
      } else {
        return response.statusCode;
      }
    } on TimeoutException catch (e) {
      return e;
    } on SocketException catch (e) {
      return e;
    } catch (e) {
      return e;
    }
  }

  @override
  Future isLogin() async {
    try {
      final SAccountInfo = await SharedPreferencesService.getAccountInfo()!;
      String? jwtToken;
      if (SAccountInfo != null) {
        jwtToken = SAccountInfo["jwtToken"].toString();
        return "true";
      } else {
        return "false";
      }
    } catch (e) {
      return "false";
    }
  }
}
