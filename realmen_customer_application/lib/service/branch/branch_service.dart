// ignore_for_file: unused_catch_clause

import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/models/exception/exception_model.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

abstract class IBranchService {
  Future<dynamic> getBranchId(int branchId);
  Future<dynamic> getBranches(String search, int pageSize);
  Future<dynamic> getSearchBranches(String search, int pageSize);
  Future<dynamic> getBranchesByCity();
}

class BranchService implements IBranchService {
  @override
  Future getBranchId(int branchId) async {
    double lat = 0;
    double lng = 0;
    bool isShowDistance = false;
    bool locationPermission =
        await SharedPreferencesService.getLocationPermission();
    // ignore: unnecessary_null_comparison
    if (branchId == null) {
      return const Iterable<String>.empty();
    } else {
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
      try {
        final String jwtToken = await SharedPreferencesService.getJwt();
        Uri uri = Uri.parse(
            "$getBranchUrl/$branchId?isShowDistance=$isShowDistance&lat=$lat&lng=$lng");
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
          final branch = BranchModel.fromJson(value['value']);
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

  @override
  Future getBranches(String search, int pageSize) async {
    int current = 1;
    String sorter = "branchName";
    double lat = 0;
    double lng = 0;
    bool locationPermission =
        await SharedPreferencesService.getLocationPermission();
    // ignore: unnecessary_null_comparison
    if (search == null && search == '') {
      return const Iterable<String>.empty();
    } else if (locationPermission) {
      try {
        final positionLongLat = await SharedPreferencesService.getLongLat();
        lat = positionLongLat['lat'] as double;
        lng = positionLongLat['lng'] as double;
        final String jwtToken = await SharedPreferencesService.getJwt();
        Uri uri;
        // v1/branches/{city}
        uri = Uri.parse(
            "$getBranchesUrl/$search?isShowDistance=true&lat=$lat&lng=$lng&sorter=$sorter&current=$current&pageSize=$pageSize");

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
          'error': 'Kiểm tra lại kết nối Internet',
        };
      } catch (e) {
        return {
          'statusCode': 500,
          'error': 'Kiểm tra lại kết nối Internet',
        };
      }
    } else {
      try {
        final String jwtToken = await SharedPreferencesService.getJwt();
        Uri uri;
        uri = Uri.parse(
            "$getBranchesUrl/$search?isShowDistance=false&lat=$lat&lng=$lng&sorter=$sorter&current=$current&pageSize=$pageSize");

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

  @override
  Future getSearchBranches(String search, int pageSize) async {
    int current = 1;
    String sorter = "createdAt";
    double lat = 0;
    double lng = 0;
    bool locationPermission =
        await SharedPreferencesService.getLocationPermission();
    if (locationPermission) {
      try {
        final positionLongLat = await SharedPreferencesService.getLongLat();
        lat = positionLongLat['lat'] as double;
        lng = positionLongLat['lng'] as double;

        final String jwtToken = await SharedPreferencesService.getJwt();
        Uri uri;
        // v1/branches
        uri = Uri.parse(
            "$getBranchesUrl?isShowDistance=true&originLat=$lat&originLng=$lng&current=$current&sorter=$sorter&pageSize=$pageSize");

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
          final branch = json.decode(responseBody);
          final branches = (branch['content'] as List)
              .map((e) => BranchModel.fromJson(e))
              .toList();

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
          'error': 'Kiểm tra lại kết nối Internet',
        };
      } catch (e) {
        return {
          'statusCode': 500,
          'error': "Kiểm tra lại kết nối Internet",
        };
      }
    } else {
      // ignore: unnecessary_null_comparison
      if (search == null && search == '') {
        return const Iterable<String>.empty();
      } else {
        try {
          final String jwtToken = await SharedPreferencesService.getJwt();
          Uri uri;
          uri = Uri.parse(
              "$getBranchesUrl?search=$search&isShowDistance=false&originLat=$lat&originLng=$lng&current=$current&sorter=$sorter&pageSize=$pageSize");

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
            final branch = json.decode(responseBody);
            final branches = (branch['content'] as List)
                .map((e) => BranchModel.fromJson(e))
                .toList();

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
  }

  @override
  Future getBranchesByCity() async {
    try {
      final String jwtToken = await SharedPreferencesService.getJwt();
      Uri uri = Uri.parse(getBranchesByCityUrl);
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
