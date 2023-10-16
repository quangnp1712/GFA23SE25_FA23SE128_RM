import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realmen_customer_application/models/login_otp_model.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_customer_application/screens/login/register_screen.dart';
import 'package:realmen_customer_application/service/authentication/authenticateService.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class LoginOTPScreen extends StatefulWidget {
  const LoginOTPScreen({super.key});
  static const String LoginOTPScreenRoute = "/login-otp-screen";

  @override
  State<LoginOTPScreen> createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  // UI
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffC4C4C4)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color(0xff777777)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(239, 240, 241, 1),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 10.h,
                  child: Container(
                    // padding: const EdgeInsets.only(top: 10),
                    // margin: EdgeInsets.symmetric(horizontal: 68),
                    width: 80.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5.h,
                              ),
                              Image.asset(
                                'assets/images/logo.png',
                                width: 257,
                                // height: 478,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                child: Text(
                                  "ĐĂNG NHẬP",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff444444),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                child: Text(
                                  "Nhập OTP",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff444444),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Pinput(
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                length: 5,
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (pin) => print(pin),
                                controller: otpController,
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 22),
                                width: 70.w,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff302E2E),
                                        Color(0xe6444141),
                                        Color(0x8c484646),
                                        Color(0x26444141),
                                      ]),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ElevatedButton(
                                  onPressed: submitOtp
                                  // () {
                                  // Navigator.pushNamed(context,
                                  //     RegisterScreen.RegisterScreenRoute);
                                  // }
                                  ,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "ĐĂNG NHẬP",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xffC4C4C4),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Logic
  TextEditingController otpController = TextEditingController();

  void submitOtp() async {
    String phone = await SharedPreferencesService.getPhone();
    String otp = otpController.text.toString();
    LoginOtpModel loginOtpModel = LoginOtpModel(phone: phone, passCode: otp);
    AuthenticateService authenticateService = AuthenticateService();
    try {
      var result = await authenticateService.loginOtp(loginOtpModel);
      if (result != null) {
        if (result.loginOtpResponseModel.jwtToken != null) {
          Navigator.pushNamed(context, MainScreen.MainScreenRoute);
        } else {
          print(result);
        }
      } else {
        print("Error");
      }
    } catch (e) {
      print(e);
    }
  }
}
