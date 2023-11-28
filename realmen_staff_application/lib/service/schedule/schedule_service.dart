import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_staff_application/global_variable.dart';
import 'package:realmen_staff_application/models/exception/exception_model.dart';
import 'package:realmen_staff_application/models/schedule/schedule_model.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';

abstract class IScheduleService {
  Future<dynamic> postSchedule(int accountId, SchedulesModel schedulesModel);
  Future<dynamic> getSchedule(int accountId);
}

class ScheduleService extends IScheduleService {
  @override
  Future postSchedule(int accountId, SchedulesModel schedulesModel) async {
    try {
      ScheduleModel scheduleModel = ScheduleModel();
      Uri uri = Uri.parse("$schedulesListUrl?accountId=$accountId");
      final client = http.Client();
      final String jwtToken = await SharedPreferencesService.getJwt();

      final response = await client
          .post(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer $jwtToken'
              },
              body: json.encode(schedulesModel.toJson()))
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
  Future getSchedule(int accountId) async {
    try {
      SchedulesModel schedulesModel = SchedulesModel();
      ScheduleModel scheduleModel = ScheduleModel();
      Uri uri = Uri.parse("$scheduleListUrl/$accountId");
      final client = http.Client();
      final String jwtToken = await SharedPreferencesService.getJwt();

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
        final result = SchedulesModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': result,
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
}
