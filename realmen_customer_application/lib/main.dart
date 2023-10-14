import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/home/main_screen.dart';
import 'package:realmen_customer_application/screens/login/login_otp_screen.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/login/register_screen.dart';
import 'package:realmen_customer_application/screens/splash/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: SplashScreen.SplashScreenRoute,
        // initialRoute: LoginOTPScreen.LoginOTPScreenRoute,
        routes: {
          LoginPhoneScreen.LoginPhoneScreenRoute: (context) =>
              const LoginPhoneScreen(),
          SplashScreen.SplashScreenRoute: (context) => const SplashScreen(),
          LoginOTPScreen.LoginOTPScreenRoute: (context) =>
              const LoginOTPScreen(),
          RegisterScreen.RegisterScreenRoute: (context) =>
              const RegisterScreen(),
          MainScreen.MainScreenRoute: (context) => const MainScreen(),
        },
      );
    });
  }
}
