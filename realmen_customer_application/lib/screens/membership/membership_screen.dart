import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/screens/login/login_phone_screen.dart';
import 'package:realmen_customer_application/screens/membership/components/cardcredit_customer.dart';
import 'package:realmen_customer_application/screens/membership/components/labeltext_level.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/account/account_service.dart';
import 'package:sizer/sizer.dart';

class MembershipScreen extends StatefulWidget {
  Function callback;
  MembershipScreen(this.callback, {super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
  static const String MembershipScreenRoute = "/membership-screen";
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 0),
                  width: 90.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(left: 7),
                          child: Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: IconButton(
                                    alignment: Alignment.centerLeft,
                                    color: Colors.black,
                                    iconSize: 22,
                                    icon: const Icon(Icons.keyboard_arrow_left),
                                    onPressed: () {
                                      widget.callback(0);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "realmen member".toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              child: ClipOval(
                                child: Image.network(
                                  avatarUrl ?? avatarDefault,
                                  scale: 1.0,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            // color: Colors.white,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child: const CardCreditCustomer()),
                          ),
                          const SizedBox(height: 5),
                          LabelTextLevel(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    ));
  }

// Logic
  @override
  void initState() {
    super.initState();
    getAccountInfo();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  AccountInfoModel? accountInfo = AccountInfoModel();
  String? avatarUrl;
  final storage = FirebaseStorage.instance;
  String avatarDefault =
      "https://cdn.vectorstock.com/i/preview-1x/62/38/avatar-13-vector-42526238.jpg";
  Future<void> getAccountInfo() async {
    if (!_isDisposed) {
      try {
        AccountService accountService = AccountService();
        final result = await accountService.getAccountInfo();
        if (result['statusCode'] == 200) {
          accountInfo = result['data'] as AccountInfoModel;
          if (accountInfo!.thumbnailUrl != null &&
              accountInfo!.thumbnailUrl != "") {
            var reference = storage.ref('avatar/${accountInfo!.thumbnailUrl}');
            avatarUrl = await reference.getDownloadURL();
          } else {
            var reference = storage.ref('avatar/default.png');
            avatarUrl = await reference.getDownloadURL();
          }
          setState(() {
            avatarUrl;
          });
        } else if (result['statusCode'] == 403) {
          Get.toNamed(LoginPhoneScreen.LoginPhoneScreenRoute);
          _errorMessage(": Cần đăng nhập lại");
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print("Error: $e");
      }
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
