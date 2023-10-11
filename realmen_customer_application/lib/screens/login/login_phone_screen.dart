import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realmen_customer_application/screens/login/login_otp_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});
  static const String LoginPhoneScreenRoute = "/login-phone-screen";

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  TextEditingController phoneController = TextEditingController();
  Future<void> submitPhone() async {
    // Model
    String phone = phoneController.text.toString();
    Map<String, dynamic> body = {"value": phone};

    // API
    final client = http.Client();
    const url = 'http://192.168.2.223:8080/v1/otp';
    var uri = Uri.parse(url);

    final response = await client.post(uri, body: json.encode(body), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });

    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
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
                                  "Nhập số điện thoại",
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
                              Container(
                                width: 70.w,
                                // height: 40,
                                child: TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  cursorColor: Colors.black,
                                  cursorWidth: 1,
                                  style: const TextStyle(
                                      height: 1.17,
                                      fontSize: 20,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffC4C4C4)),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffC4C4C4)),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        // top: 10,
                                        // bottom: 20,
                                        left: 15,
                                        right: 15),
                                    hintText: "Nhập số điện thoại của bạn",
                                    hintStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffC4C4C4)),
                                  ),
                                ),
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
                                  onPressed: submitPhone
                                  // () {
                                  //   Navigator.pushNamed(context,
                                  //       LoginOTPScreen.LoginOTPScreenRoute);
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
                                    "TIẾP THEO",
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
}
