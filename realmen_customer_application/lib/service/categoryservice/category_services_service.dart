// ignore_for_file: unused_catch_clause

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:realmen_customer_application/models/categoryservice/category_model.dart';
import 'package:realmen_customer_application/models/service/service_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:realmen_customer_application/models/exception/exception_model.dart';
import 'package:realmen_customer_application/global_variable.dart';

abstract class ICategoryService {
  Future<dynamic> getCategoryServiceList();
  Future<dynamic> getServiceList();
  // Add more methods as needed
}

class CategoryServices implements ICategoryService {
  @override
  Future getCategoryServiceList() async {
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(getCategoryServicesUrl);
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
        final category = CategoryListModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': category,
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
        'error': 'Kiểm tra lại kết nối Internet',
      };
    }
  }

  // Home: Recoment service
  @override
  Future getServiceList() async {
    int current = 1;
    String sorter = "serviceName";
    int pageSize = 5;
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      // v1/services
      Uri uri = Uri.parse(
          "$getServices?current=$current&sorter=$sorter&pageSize=$pageSize");
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
        final serviceModel = ServiceModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': serviceModel,
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
        'error': 'Kiểm tra lại kết nối Internet',
      };
    }
  }
}
