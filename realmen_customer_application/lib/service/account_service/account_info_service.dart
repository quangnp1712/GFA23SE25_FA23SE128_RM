import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:realmen_customer_application/global_variable.dart';
import 'package:realmen_customer_application/models/account_info.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

abstract class IAccountService {
  Future<dynamic> getAccountInfo(AccountInfoModel accountInfoModel);
}

class AccountService extends IAccountService {
  @override
  Future getAccountInfo(AccountInfoModel accountInfoModel) async {
    try {
      final int accountId =
          int.parse(SharedPreferencesService.getAccountId().toString());
      Uri uri = Uri.parse("$accountInfoUrl/$accountId/$customer");
      final client = http.Client();

      final response = await client.post(uri);
    } catch (e) {}
  }
}
