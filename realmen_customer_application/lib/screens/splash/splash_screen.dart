// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  // ignore: constant_identifier_names
  static const String SplashScreenRoute = "/splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  // @override
  // void didUpdateWidget(SplashScreen oldWidget) {
  //   _navigateToLogin();
  //   super.didUpdateWidget(oldWidget);
  // }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Future<void> _navigateToLogin() async {
    // final authenticateService = AuthenticateService();
    if (!_isDisposed && mounted) {
      await Future.delayed(const Duration(milliseconds: 2000));
      try {
        final result = await SharedPreferencesService.checkJwtExpired();
        if (result == false) {
          Get.toNamed(MainScreen.MainScreenRoute);
        } else {
          Get.toNamed(LoginPhoneScreen.LoginPhoneScreenRoute);
        }
      } catch (e) {
        print(e);
        Get.toNamed(LoginPhoneScreen.LoginPhoneScreenRoute);
      }
    } else {
      Get.toNamed(LoginPhoneScreen.LoginPhoneScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg-splash.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/logo.png",
              width: 300,
              height: 144,
            ),
            const SizedBox(
              height: 160,
            ),
            const SpinKitSpinningLines(
              color: Colors.black,
              size: 60.0,
            )
          ]),
        ],
      ),
    );
  }
}
