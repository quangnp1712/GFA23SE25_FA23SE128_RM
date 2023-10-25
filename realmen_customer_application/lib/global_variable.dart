import 'package:flutter_dotenv/flutter_dotenv.dart';

// API URL
// OTP API
final loginPhoneUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_PHONE"]}";
final loginOtpUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_OTP"]}";

//  ACCOUNT API
final registerUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["REGISTER_CUSTOMER"]}";
final accountInfoUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_ACCOUNT"]}";
// common variable
final connectionTimeOut = int.parse(dotenv.env["CONNECTION_TIMEOUT"]!);
final customer = "${dotenv.env["CUSTOMER"]}";
