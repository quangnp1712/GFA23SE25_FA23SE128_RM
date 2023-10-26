import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_customer_application/service/authentication/authenticateService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    // TODO: implement initState
    super.initState();
    _navigateToLogin();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Future<void> _navigateToLogin() async {
    final authenticateService = AuthenticateService();
    await Future.delayed(const Duration(milliseconds: 2000));

    try {
      final result = await authenticateService.isLogin();
      if (result == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPhoneScreen()),
        );
      }
    } catch (e) {
      print(e);
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
