import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/models/exception/exception_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

abstract class IBranchService {
  Future<dynamic> getBranches(String search);
  Future<dynamic> getBranchId(int branchId);
  Future<dynamic> getBranchesByCity();
}

class BranchService implements IBranchService {
  @override
  Future getBranchId(int branchId) async {
    BranchModel branchModel = BranchModel();

    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse("$getBranchUrl/$branchId");
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
        final branch = BranchModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': branch,
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

  @override
  Future getBranches(String search) async {
    BranchesModel branchesModel = BranchesModel();
    int current = 1;
    String sorter = "createdAt";
    int pageSize = 20;
    if (search == null && search == '') {
      return const Iterable<String>.empty();
    } else {
      try {
        final String jwtToken = await SharedPreferencesService.getJwt();
        Uri uri;
        uri = Uri.parse(
            "$getBranchesUrl?search=$search&current=$current&sorter=$sorter&pageSize=$pageSize");

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
          final branches = BranchesModel.fromJson(json.decode(responseBody));
          return {
            'statusCode': statusCode,
            'data': branches,
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

  @override
  Future getBranchesByCity() async {
    BranchesByCityModel branchesByCityModel = BranchesByCityModel();
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse("$getBranchesByCityUrl?isSortedByDistance=false");
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
        final branches =
            BranchesByCityModel.fromJson(json.decode(responseBody));
        return {
          'statusCode': statusCode,
          'data': branches,
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
