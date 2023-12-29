// ignore_for_file: unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/models/exception/exception_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

abstract class IAccountService {
  Future<dynamic> getAccountInfo();
  Future<dynamic> getStaff(int pageSize);
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
        accountInfoModel =
            AccountInfoModel.fromJson(json.decode(responseBody)['value']);
        return {
          'statusCode': statusCode,
          'data': accountInfoModel,
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
  Future getStaff(int pageSize) async {
    try {
      List<AccountInfoModel> accountInfoModels = [];
      final String jwtToken = await SharedPreferencesService.getJwt();
      double lat = 0;
      double lng = 0;
      bool isShowDistance = false;
      bool locationPermission =
          await SharedPreferencesService.getLocationPermission();
      int current = 1;
      String sorter = "createdAt";
      if (locationPermission) {
        final positionLongLat = await SharedPreferencesService.getLongLat();
        lat = positionLongLat['lat'] as double;
        lng = positionLongLat['lng'] as double;
        isShowDistance = true;
      } else {
        lat = 0;
        lng = 0;
        isShowDistance = false;
      }
      Uri uri = Uri.parse(
          "$getStaffUrl?role=STAFF&iShowDistance=$isShowDistance&lat=$lat&lng=$lng&current=$current&pageSize=$pageSize&sorter=$sorter");
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
        final content = json.decode(responseBody)['content'] as List;
        accountInfoModels =
            content.map((e) => AccountInfoModel.fromJson(e)).toList();
        return {
          'statusCode': statusCode,
          'data': accountInfoModels,
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
}
