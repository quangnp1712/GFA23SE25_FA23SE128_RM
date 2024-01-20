import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/rating/rating_model.dart';
import 'package:realmen_customer_application/screens/history_booking/detail_history_hair_cut_screen.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

abstract class IRatingService {
  Future<dynamic> postRatings(RatingModel ratingModel);
  Future<dynamic> putRatings(int ratingId, RatingModel ratingModel);
}

class RatingService implements IRatingService {
  @override
  Future<dynamic> postRatings(RatingModel ratingModel) async {
    try {
      Uri uri = Uri.parse(ratingUrl);
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
              body: json.encode(ratingModel.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));

      final statusCode = response.statusCode;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else {
        try {
          return {
            'statusCode': statusCode,
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
  Future<dynamic> putRatings(int ratingId, RatingModel ratingModel) async {
    try {
      Uri uri = Uri.parse('$ratingUrl/$ratingId');
      final client = http.Client();
      final String jwtToken = await SharedPreferencesService.getJwt();
      final response = await client
          .put(uri,
              headers: {
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer $jwtToken'
              },
              body: json.encode(ratingModel.toJson()))
          .timeout(Duration(seconds: connectionTimeOut));

      final statusCode = response.statusCode;
      if (statusCode == 200) {
        return {
          'statusCode': statusCode,
        };
      } else {
        try {
          return {
            'statusCode': statusCode,
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
