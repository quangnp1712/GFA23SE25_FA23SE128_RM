import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  static const String ProfileScreenRoute = "/profile-screen";
}

class _ProfileScreenState extends State<ProfileScreen> {
  //UI
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
                top: 15,
                bottom: 27,
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  width: 90.w,
                  height: 90.h,
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/admin.png",
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                'Mike Tyson',
                                style: GoogleFonts.quicksand(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Center(
                              child: Text(
                                '09xx.xxx.xxx',
                                style: GoogleFonts.quicksand(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              width: 82.w,
                              margin: const EdgeInsets.only(top: 24),
                              padding: EdgeInsets.only(top: 13),
                              height: 400,
                              child: Row(
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(left: 0),
                                          ),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons.crown,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "RealMen Member",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(left: 0),
                                          ),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons
                                                      .account_circle,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Chỉnh sửa thông tin cơ bản",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(left: 0),
                                          ),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons
                                                      .history,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Lịch sử cắt tóc",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(left: 0),
                                          ),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons
                                                      .storefront,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Hệ thống chi nhánh",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 82.w,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0x4D444444),
                                                width: 1.0),
                                          ),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(left: 0),
                                          ),
                                          onPressed: _logout,
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  CommunityMaterialIcons.logout,
                                                  color: Color(0xffFF0000),
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Đăng xuất',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xffFF0000)),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  // Logic
  Future<void> _logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    _errorMessage("Đăng xuất");
    Navigator.pushNamed(context, LoginPhoneScreen.LoginPhoneScreenRoute);
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
