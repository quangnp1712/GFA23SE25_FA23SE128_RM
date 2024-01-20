import 'package:flutter_dotenv/flutter_dotenv.dart';

// API URL
// OTP API
final loginPhoneUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_PHONE"]}";
final loginOtpUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["LOGIN_OTP"]}";

//  ACCOUNT API
final registerUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["REGISTER_CUSTOMER"]}";
final accountInfoUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_ACCOUNT"]}";
final getStaffUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_STAFF"]}";

//  BRANCH API
final getBranchesUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_BRANCHES"]}";
final getBranchUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_BRANCH"]}";
final getBranchesByCityUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_BRANCHES_CITY"]}";

// Autocomplete
final autoCompleteUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["AUTOCOMPLETE_SEARCH"]}";

// Category Service List
final getCategoryServicesUrl =
    "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_CATEGORYSERVICES"]}";
// common variable
final connectionTimeOut = int.parse(dotenv.env["CONNECTION_TIMEOUT"]!);
final customer = "${dotenv.env["CUSTOMER"]}";

// Service API
final getServices = "${dotenv.env["DOMAIN"]}/${dotenv.env["GET_SERVICE"]}";

// Booking API
final bookingUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["BOOKING"]}";

// TimeSlot API
final timeslotUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["TIMESLOT"]}";

// Rating API
final ratingUrl = "${dotenv.env["DOMAIN"]}/${dotenv.env["RATING"]}";
