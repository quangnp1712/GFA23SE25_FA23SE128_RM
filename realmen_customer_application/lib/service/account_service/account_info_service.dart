import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/account_info.dart';
import 'package:realmen_customer_application/models/exception_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

abstract class IAccountService {
  Future<dynamic> getAccountInfo();
}

class AccountService extends IAccountService {
  @override
  Future getAccountInfo() async {
    AccountInfoModel accountInfoModel = AccountInfoModel();
    try {
      final int accountId = await SharedPreferencesService.getAccountId();

      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse("$accountInfoUrl/$accountId/$customer");
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $jwtToken'
        },
      ).timeout(Duration(seconds: connectionTimeOut));
      final statusCode = response.statusCode;
      final responseBody = response.body;
      if (statusCode == 200) {
        final accountInfo =
            AccountInfoModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': accountInfo,
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
        'error': 'Socket error',
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'error': e,
      };
    }
  }
}
