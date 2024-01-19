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
