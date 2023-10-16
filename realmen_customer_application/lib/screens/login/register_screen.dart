import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realmen_customer_application/models/register_customer_model.dart';
import 'package:realmen_customer_application/screens/login/login_otp_screen.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_customer_application/service/authentication/authenticateService.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'dart:core';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String RegisterScreenRoute = "/register-screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover),
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
                    // padding: const EdgeInsets.only(top: 20),
                    // margin: EdgeInsets.symmetric(horizontal: 68),
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                              // height: 59,
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
                              // margin: EdgeInsets.only(top: 31, bottom: 22),
                              child: Text(
                                "Nhập thông tin",
                                style: GoogleFonts.quicksand(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff444444),
                                ),
                              ),
                            ),
                            // Họ và tên
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              width: 70.w,
                              // height: 40,
                              child: TextField(
                                controller: firstNameController,
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
                                  hintText: "Nhập Họ và Tên đệm của bạn",
                                  hintStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC4C4C4)),
                                ),
                              ),
                            ),
                            // Tên
                            SizedBox(
                              height: 2.h,
                            ),

                            Container(
                              width: 70.w,
                              // height: 40,
                              child: TextField(
                                controller: lastNameController,
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
                                  hintText: "Nhập Tên của bạn",
                                  hintStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC4C4C4)),
                                ),
                              ),
                            ),
                            // Địa chỉ
                            SizedBox(
                              height: 2.h,
                            ),

                            Container(
                              width: 70.w,
                              // height: 40,
                              child: TextField(
                                controller: addressController,
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
                                  hintText: "Nhập Địa chỉ của bạn",
                                  hintStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC4C4C4)),
                                ),
                              ),
                            ),
                            // DOB
                            SizedBox(
                              height: 2.h,
                            ),

                            Container(
                              width: 70.w,
                              // height: 40,
                              child: TextField(
                                controller: dobController,
                                readOnly: true,
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
                                  hintText: "Nhập Ngày sinh dd/mm/yyyy",
                                  hintStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC4C4C4)),
                                ),
                                onTap: _selectDate,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            // Gender
                            Container(
                              // margin: const EdgeInsets.only(top: 22),
                              width: 70.w,
                              // height: 40,
                              // padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: Color(0xffC4C4C4)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    iconSize: 20,
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    value: genderController,
                                    items: genders
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item,
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ))
                                        .toList(),
                                    onChanged: (item) => setState(
                                        () => genderController = item)),
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Container(
                              // margin: const EdgeInsets.only(top: 22),
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
                                onPressed: submitRegister,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: const Text(
                                  "HOÀN TẤT",
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Logic
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  List<String> genders = ['NAM', 'NỮ'];
  String? genderController = 'NAM';
  DateTime? dobSubmit;

  Future<void> _selectDate() async {
    DateTime? dob = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (dob != null) {
      setState(() {
        dobSubmit = dob;
        dobController.text = dob.toString().split(" ")[0];
      });
      print(dobController.toString());
    }
  }

  void submitRegister() async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String dob = dobSubmit!.toIso8601String();
    String gender = genderController.toString();
    String thumbnailUrl = "";
    RegisterCustomerModel registerCustomerModel = RegisterCustomerModel(
        thumbnailUrl: thumbnailUrl,
        firstName: firstName,
        lastName: lastName,
        address: address,
        gender: gender,
        dob: dob);
    AuthenticateService authenticateService = AuthenticateService();
    try {
      var result =
          await authenticateService.registerCustomer(registerCustomerModel);
      if (result == 200) {
        Navigator.pushNamed(context, LoginOTPScreen.LoginOTPScreenRoute);
      } else {
        print("Error: $result");
      }
    } catch (e) {
      print(e);
    }
  }
}
