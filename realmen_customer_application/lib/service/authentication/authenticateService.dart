import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/exception_model.dart';
import 'package:realmen_customer_application/models/login_otp_model.dart';
import 'package:realmen_customer_application/models/login_phone_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

abstract class IAuthenticateService {
  Future<dynamic> loginPhone(LoginPhoneModel loginPhoneModel);
  Future<dynamic> loginOtp(LoginOtpModel loginOtpModel);
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
        final loginPhoneModel =
            LoginPhoneModel.fromJson(json.decode(response.body));
        await SharedPreferencesService.saveOtpIdPhone(
            loginPhoneModel.loginPhoneResponse!.otpId!.toString(),
            loginPhoneModel.loginPhoneResponse!.phoneAttemp!);
        return loginPhoneModel;
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
        final loginOtpModel =
            LoginOtpModel.fromJson(json.decode(response.body));
        if (loginOtpModel.loginOtpResponseModel!.isPhoneRegistered! == false) {
          return "FALSE";
        } else if (loginOtpModel.loginOtpResponseModel!.isPhoneRegistered! ==
            true) {
          return "TRUE";
        } else {
          return "ERROR";
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
    }
  }
}
