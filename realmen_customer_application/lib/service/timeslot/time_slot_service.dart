// ignore_for_file: unused_catch_clause

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/exception/exception_model.dart';
import 'package:realmen_customer_application/models/time_slot/time_slot_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

abstract class ITimeSlotService {
  Future<dynamic> getTimeSlot(String chosenDate, int staffId);
}

class TimeSlotService implements ITimeSlotService {
  @override
  Future getTimeSlot(String chosenDate, int staffId) async {
    try {
      List<TimeSlotModel> timeSlotModel = [];
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri =
          Uri.parse("$timeslotUrl?chosenDate=$chosenDate&staffId=$staffId");
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
        final value = json.decode(responseBody);
        timeSlotModel = (value['values'] as List)
            .map((e) => TimeSlotModel.fromJson(e))
            .toList();
        return {
          'statusCode': statusCode,
          'data': timeSlotModel,
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
          'error': "Hết hạn đăng nhập",
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
