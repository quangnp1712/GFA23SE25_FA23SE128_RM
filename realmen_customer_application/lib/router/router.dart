import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/screens/booking/booking_processing.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_branch/choose_branch_screen.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_service/choose_service_screen.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_branch/choose_stylist_screen.dart';
import 'package:realmen_customer_application/screens/history_booking/detail_history_hair_cut_screen.dart';
import 'package:realmen_customer_application/screens/history_booking/history_booking_screen.dart';
import 'package:realmen_customer_application/screens/list_branch/branches_overview.dart';
import 'package:realmen_customer_application/screens/list_branch/list_branches.dart';
import 'package:realmen_customer_application/screens/login/login_otp_screen.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/login/register_screen.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_customer_application/screens/other/test.dart';

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
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return const MainScreen();
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
                  } else {
                    return const ViewEditProfileScreen();
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
                  } else {
                    return const BranchesOverviewScreen();
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
                  } else {
                    return const HistoryBookingScreen();
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
                  } else {
                    return const DetailHistoryBookingScreen();
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
                  } else {
                    return const BookingProcessingScreen();
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
                  } else {
                    return ListBranchesScreen();
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
                  } else {
                    return ChooseBranchesScreen();
                  }
                });
          }),
      GetPage(
          name: ChooseServiceBookingScreen.ChooseServiceBookingScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return ChooseServiceBookingScreen();
                  }
                });
          }),
      GetPage(
          name: TestScreen.TestScreenRoute,
          page: () {
            return FutureBuilder(
                future: SharedPreferencesService.checkJwtExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const LoginPhoneScreen();
                  } else {
                    return TestScreen();
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
                  } else {
                    return ChooseStylistScreen();
                  }
                });
          }),
    ];
  }
}
