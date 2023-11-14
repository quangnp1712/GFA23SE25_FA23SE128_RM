import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/firebase_options.dart';

import 'package:realmen_customer_application/router/router.dart';

import 'package:realmen_customer_application/screens/splash/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        // onGenerateRoute: Routers.generateRoute,
        // onGenerateRoute: (settings) => GetPageRoute(settings: settings),
        getPages: RouteGenerator.routes(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: GoogleFonts.ebGaramondTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: SplashScreen.SplashScreenRoute,
        // initialRoute: MainScreen.MainScreenRoute,
        // routes: {
        //   LoginPhoneScreen.LoginPhoneScreenRoute: (context) =>
        //       const LoginPhoneScreen(),
        //   SplashScreen.SplashScreenRoute: (context) => const SplashScreen(),
        //
        // },
      );
    });
  }
}
