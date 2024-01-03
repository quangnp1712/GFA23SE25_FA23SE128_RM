import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/screens/booking/booking_haircut_temporary.dart';
import 'package:realmen_customer_application/screens/booking/booking_processing.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_branch/choose_branch_screen.dart';

import 'package:realmen_customer_application/screens/booking/components/choose_stylist_branch/choose_stylist_screen.dart';
import 'package:realmen_customer_application/screens/history_booking/detail_history_hair_cut_screen.dart';
import 'package:realmen_customer_application/screens/history_booking/history_booking_screen.dart';
import 'package:realmen_customer_application/screens/list_branch/branches_overview.dart';
import 'package:realmen_customer_application/screens/list_branch/list_branches.dart';
import 'package:realmen_customer_application/screens/login/login_otp_screen.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/login/register_screen.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';

import 'package:realmen_customer_application/screens/profile/view_edit_profile.dart';
import 'package:realmen_customer_application/screens/splash/splash_screen.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

class RouteGenerator {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: SplashScreen.SplashScreenRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: LoginPhoneScreen.LoginPhoneScreenRoute,
        page: () => const LoginPhoneScreen(),
      ),
      GetPage(
        name: LoginOTPScreen.LoginOTPScreenRoute,
        page: () => const LoginOTPScreen(),
      ),
      GetPage(
        name: RegisterScreen.RegisterScreenRoute,
        page: () => const RegisterScreen(),
      ),
      GetPage(
          name: MainScreen.MainScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.data == false) {
                    return MainScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: ViewEditProfileScreen.ViewEditProfileScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return const ViewEditProfileScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: BranchesOverviewScreen.BranchesOverviewScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return const BranchesOverviewScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: HistoryBookingScreen.HistoryBookingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return const HistoryBookingScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: DetailHistoryBookingScreen.DetailHistoryBookingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return const DetailHistoryBookingScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: BookingProcessingScreen.BookingProcessingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return const BookingProcessingScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: ListBranchesScreen.ListBranchesScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return ListBranchesScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: ChooseBranchesScreen.ChooseBranchesScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return ChooseBranchesScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: ChooseStylistScreen.ChooseStylistScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return const ChooseStylistScreen();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
      GetPage(
          name: BookingHaircutTemporary.BookingHaircutTemporaryScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else if (snapshot.data == false) {
                    return BookingHaircutTemporary();
                  } else {
                    return const LoginPhoneScreen();
                  }
                });
          }),
    ];
  }
}
