import 'package:flutter_dotenv/flutter_dotenv.dart';

// API URL
// ${dotenv.env[""]}
final loginPhoneUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_PHONE"]}";
final loginOtpUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_OTP"]}";

// common variable
final connectionTimeOut = int.parse(dotenv.env["CONNECTION_TIMEOUT"]!);
